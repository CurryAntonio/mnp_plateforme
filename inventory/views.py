from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django.utils import timezone
from django.db.models import Sum
from .models import SessionInventaire, LigneComptage, AjustementInventaire
from .serializers import SessionInventaireSerializer, LigneComptageSerializer, AjustementInventaireSerializer
# Import du modèle Produit depuis l'app products
from products.models import Produit

class SessionInventaireViewSet(viewsets.ModelViewSet):
    queryset = SessionInventaire.objects.all().order_by('-date_debut')
    serializer_class = SessionInventaireSerializer
    
    def perform_create(self, serializer):
        # Référence automatique: INV-YYYYMMDD-HHMMSS-<user id>
        now = timezone.now()
        ref = f"INV-{now.strftime('%Y%m%d%H%M%S')}-{self.request.user.id}"
        serializer.save(responsable=self.request.user, reference=ref)
    
    @action(detail=False, methods=['post'])
    def commencer(self, request):
        """Commencer une nouvelle session d'inventaire"""
        # Vérifier qu'il n'y a pas déjà une session en cours
        session_en_cours = SessionInventaire.objects.filter(statut='EN_COURS').first()
        if session_en_cours:
            return Response(
                {'error': 'Une session d\'inventaire est déjà en cours'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Générer une référence unique
        now = timezone.now()
        reference = f"INV-{now.strftime('%Y%m%d%H%M%S')}-{request.user.id}"
        
        session = SessionInventaire.objects.create(
            reference=reference,
            responsable=request.user
        )
        
        serializer = self.get_serializer(session)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    @action(detail=True, methods=['post'])
    def cloturer(self, request, pk=None):
        """Clôturer une session d'inventaire avec calcul automatique des ajustements"""
        session = self.get_object()
        if session.statut != 'EN_COURS':
            return Response({'detail': 'Session déjà clôturée.'}, 
                          status=status.HTTP_400_BAD_REQUEST)
        
        # Calcul des écarts par produit présent dans les comptages
        produit_ids = session.comptages.values_list('produit', flat=True).distinct()
        ajustements_crees = []
        
        for pid in produit_ids:
            produit = Produit.objects.get(id=pid)
            qt_phys = session.comptages.filter(produit=produit).aggregate(
                total=Sum('quantite_physique')
            )['total'] or 0
            
            # Utiliser stock_initial comme stock théorique
            qt_theo = produit.stock_initial
            ecart = qt_phys - qt_theo
            
            ajust = AjustementInventaire.objects.create(
                session=session,
                produit=produit,
                quantite_theorique=qt_theo,
                quantite_physique=qt_phys,
                ecart=ecart,
                commentaire='Calcul automatique lors de la clôture',
                valide_par=request.user
            )
            ajustements_crees.append(ajust)
            
            # Mettre à jour le stock initial du produit avec la nouvelle quantité
            produit.stock_initial = qt_phys
            produit.save()
        
        # Clôturer la session
        session.date_fin = timezone.now()
        session.statut = 'TERMINEE'
        session.save()
        
        serializer = self.get_serializer(session)
        return Response(serializer.data)
    
    @action(detail=True, methods=['post'])
    def terminer(self, request, pk=None):
        """Terminer une session d'inventaire (méthode simple)"""
        session = self.get_object()
        if session.statut == 'TERMINEE':
            return Response(
                {'error': 'Cette session est déjà terminée'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        session.statut = 'TERMINEE'
        session.date_fin = timezone.now()
        session.save()
        
        return Response({'message': 'Session terminée avec succès'})

class LigneComptageViewSet(viewsets.ModelViewSet):
    queryset = LigneComptage.objects.all().order_by('-date_comptage')
    serializer_class = LigneComptageSerializer
    
    def perform_create(self, serializer):
        serializer.save(operateur=self.request.user)

class AjustementInventaireViewSet(viewsets.ModelViewSet):
    queryset = AjustementInventaire.objects.all().order_by('-date_ajustement')
    serializer_class = AjustementInventaireSerializer
    
    def get_queryset(self):
        queryset = super().get_queryset()
        session_id = self.request.query_params.get('session', None)
        ecart_type = self.request.query_params.get('ecart_type', None)
        
        if session_id:
            queryset = queryset.filter(session_id=session_id)
            
        if ecart_type == 'negatif':
            queryset = queryset.filter(ecart__lt=0)
        elif ecart_type == 'positif':
            queryset = queryset.filter(ecart__gt=0)
        elif ecart_type == 'nul':
            queryset = queryset.filter(ecart=0)
            
        return queryset
    
    @action(detail=False, methods=['get'])
    def alertes(self, request):
        """Retourne les ajustements avec des écarts significatifs"""
        ajustements_problematiques = self.get_queryset().filter(
            ecart__lt=0  # Stock physique inférieur au stock théorique
        ).order_by('ecart')
        
        serializer = self.get_serializer(ajustements_problematiques, many=True)
        return Response({
            'count': ajustements_problematiques.count(),
            'results': serializer.data
        })