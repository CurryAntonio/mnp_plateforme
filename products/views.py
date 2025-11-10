from rest_framework import viewsets, status, filters
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from django_filters.rest_framework import DjangoFilterBackend
from django.db import transaction
from django.db import models
from django.utils import timezone
from .models import Produit, Groupe, InventaireProduit
from .serializers import (
    ProduitSerializer,
    ProduitDetailSerializer,
    ProduitCreateUpdateSerializer,
    GroupeSerializer,
    InventaireProduitSerializer,
    InventaireProduitCreateSerializer
)
from journal.models import Mouvement

class ProduitViewSet(viewsets.ModelViewSet):
    queryset = Produit.objects.all()
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['groupe', 'zone']
    search_fields = ['code', 'nom', 'observation']
    ordering_fields = ['nom', 'code', 'stock_initial', 'date_creation']
    ordering = ['nom']
    
    def get_serializer_class(self):
        if self.action in ['create', 'update', 'partial_update']:
            return ProduitCreateUpdateSerializer
        elif self.action == 'retrieve':
            return ProduitDetailSerializer
        return ProduitSerializer
    
    def get_queryset(self):
        queryset = Produit.objects.select_related('groupe').all()
        
        # Filtrage par stock faible
        stock_faible = self.request.query_params.get('stock_faible', None)
        if stock_faible == 'true':
            queryset = queryset.filter(stock_initial__lt=models.F('seuil'))
        
        return queryset
    
    @action(detail=True, methods=['get'])
    def check_stock(self, request, pk=None):
        produit = self.get_object()
        is_low_stock = produit.stock_initial < produit.seuil
        return Response({
            'is_low_stock': is_low_stock,
            'stock_actuel': produit.stock_initial,
            'seuil': produit.seuil
        })
    
    @action(detail=True, methods=['patch'])
    def update_stock(self, request, pk=None):
        """Mettre à jour le stock d'un produit"""
        produit = self.get_object()
        
        try:
            nouveau_stock = request.data.get('stock')
            if nouveau_stock is None:
                return Response(
                    {'error': 'Le paramètre stock est requis'}, 
                    status=status.HTTP_400_BAD_REQUEST
                )
            
            nouveau_stock = float(nouveau_stock)
            ancien_stock = produit.stock_initial
            
            with transaction.atomic():
                # Mettre à jour le stock
                produit.stock_initial = nouveau_stock
                produit.save()
                
                # Créer un mouvement de stock si nécessaire
                if ancien_stock != nouveau_stock:
                    from journal.models import Mouvement
                    
                    type_mouvement = 'ENTREE' if nouveau_stock > ancien_stock else 'SORTIE'
                    quantite = abs(nouveau_stock - ancien_stock)
                    
                    Mouvement.objects.create(
                        produit=produit,
                        type_mouvement=type_mouvement,
                        quantite=quantite,
                        stock_avant=ancien_stock,
                        stock_apres=nouveau_stock,
                        observation=f"Mise à jour manuelle du stock",
                        utilisateur=request.user
                    )
            
            return Response({
                'success': True,
                'message': 'Stock mis à jour avec succès',
                'ancien_stock': ancien_stock,
                'nouveau_stock': nouveau_stock
            })
            
        except ValueError:
            return Response(
                {'error': 'Le stock doit être un nombre valide'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        except Exception as e:
            return Response(
                {'error': str(e)}, 
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )
    
    def get_queryset(self):
        queryset = Produit.objects.all()
        
        # Filtrer par stock faible
        low_stock = self.request.query_params.get('low_stock')
        if low_stock and low_stock.lower() == 'true':
            queryset = queryset.filter(stock_initial__lt=models.F('seuil'))
        
        return queryset
    
    @action(detail=True, methods=['get'])
    def check_stock(self, request, pk=None):
        produit = self.get_object()
        return Response({
            'id': produit.id,
            'code': produit.code,
            'nom': produit.nom,
            'stock_initial': produit.stock_initial,
            'seuil': produit.seuil,
            'is_low_stock': produit.is_low_stock
        })

class GroupeViewSet(viewsets.ModelViewSet):
    queryset = Groupe.objects.all()
    serializer_class = GroupeSerializer
    filter_backends = [filters.SearchFilter, filters.OrderingFilter]
    search_fields = ['nom', 'description']
    ordering_fields = ['nom', 'date_creation', 'product_count']
    ordering = ['nom']
    
    def get_queryset(self):
        queryset = Groupe.objects.all()
        
        # Annoter tous les groupes avec le nombre de produits pour le tri
        queryset = queryset.annotate(product_count=models.Count('produits'))
        
        # Filtrer par groupes avec alertes de stock
        has_low_stock = self.request.query_params.get('hasLowStock')
        if has_low_stock and has_low_stock.lower() == 'true':
            queryset = queryset.filter(
                produits__stock_initial__lt=models.F('produits__seuil')
            ).distinct()
        
        # Filtrer par groupes créés récemment (30 derniers jours)
        recently_created = self.request.query_params.get('recentlyCreated')
        if recently_created and recently_created.lower() == 'true':
            from django.utils import timezone
            from datetime import timedelta
            thirty_days_ago = timezone.now() - timedelta(days=30)
            queryset = queryset.filter(date_creation__gte=thirty_days_ago)
        
        # Filtrer par nombre minimum de produits
        min_products = self.request.query_params.get('minProducts')
        if min_products and min_products.isdigit():
            queryset = queryset.annotate(product_count=models.Count('produits'))
            queryset = queryset.filter(product_count__gte=int(min_products))
        
        # Filtrer par nombre maximum de produits
        max_products = self.request.query_params.get('maxProducts')
        if max_products and max_products.isdigit():
            queryset = queryset.annotate(product_count=models.Count('produits'))
            queryset = queryset.filter(product_count__lte=int(max_products))
        
        return queryset
    
    @action(detail=True, methods=['get'])
    def products(self, request, pk=None):
        groupe = self.get_object()
        produits = Produit.objects.filter(groupe=groupe)
        serializer = ProduitSerializer(produits, many=True)
        return Response(serializer.data)
    
    @action(detail=False, methods=['get'])
    def stats(self, request):
        # Nombre total de produits
        total_products = Produit.objects.count()
        
        # Nombre de groupes avec des produits en stock faible
        groups_with_low_stock = Groupe.objects.filter(
            produits__stock_initial__lt=models.F('produits__seuil')
        ).distinct().count()
        
        # Groupe le plus actif (avec le plus de produits)
        most_active_group = Groupe.objects.annotate(
            products_count=models.Count('produits')
        ).order_by('-products_count').first()
        
        return Response({
            'total_products': total_products,
            'groups_with_low_stock': groups_with_low_stock,
            'most_active_group': most_active_group.nom if most_active_group else 'Aucun'
        })
    
    @action(detail=True, methods=['post'])
    def inventorier(self, request, pk=None):
        """Créer un inventaire pour un produit spécifique"""
        produit = self.get_object()
        
        # Vérifier si un inventaire récent existe (moins de 24h)
        inventaire_recent = InventaireProduit.objects.filter(
            produit=produit,
            date_inventaire__gte=timezone.now() - timezone.timedelta(hours=24)
        ).first()
        
        if inventaire_recent:
            return Response({
                'error': 'Un inventaire a déjà été effectué pour ce produit dans les dernières 24 heures',
                'dernier_inventaire': InventaireProduitSerializer(inventaire_recent).data
            }, status=status.HTTP_400_BAD_REQUEST)
        
        # Récupérer les données de la requête
        stock_physique = request.data.get('stock_physique')
        observation = request.data.get('observation', '')
        
        if stock_physique is None:
            return Response(
                {'error': 'Le stock physique est requis'}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        try:
            with transaction.atomic():
                # Créer l'inventaire
                # Ligne ~160 - Remplacer stock_initial_fixe par stock_initial
                inventaire = InventaireProduit.objects.create(
                    produit=produit,
                    stock_systeme=produit.stock_initial,  # Changé de stock_initial_fixe
                    stock_physique=float(stock_physique),
                    observation=observation,
                    utilisateur=request.user
                )
                
                # Si l'écart n'est pas nul, créer un mouvement d'ajustement
                if inventaire.ecart != 0:
                    type_mouvement = 'ENTREE' if inventaire.ecart > 0 else 'SORTIE'
                    quantite_ajustement = abs(inventaire.ecart)
                    
                    mouvement = Mouvement.objects.create(
                        produit=produit,
                        type_mouvement=type_mouvement,
                        quantite=quantite_ajustement,
                        stock_avant=produit.stock_initial,
                        stock_apres=inventaire.stock_physique,
                        observation=f"Ajustement inventaire - {inventaire.observation or 'Aucune observation'}",
                        utilisateur=request.user
                    )
                    
                    inventaire.mouvement_ajustement = mouvement
                    inventaire.ajustement_effectue = True
                    inventaire.save()
                
                # Mettre à jour les stocks du produit
                produit.stock_initial = inventaire.stock_physique
                # produit.stock_initial_fixe = inventaire.stock_physique  # À supprimer
                produit.save()
            
            return Response(
                InventaireProduitSerializer(inventaire).data,
                status=status.HTTP_201_CREATED
            )
            
        except Exception as e:
            return Response(
                {'error': str(e)}, 
                status=status.HTTP_400_BAD_REQUEST
            )
        
        serializer = InventaireProduitCreateSerializer(
            data=request.data,
            context={'request': request}
        )
        
        if serializer.is_valid():
            with transaction.atomic():
                inventaire = serializer.save()
                
                # Si l'écart n'est pas nul, créer un mouvement d'ajustement
                if inventaire.ecart != 0:
                    type_mouvement = 'ENTREE' if inventaire.ecart > 0 else 'SORTIE'
                    quantite_ajustement = abs(inventaire.ecart)
                    
                    mouvement = Mouvement.objects.create(
                        produit=produit,
                        type_mouvement=type_mouvement,
                        quantite=quantite_ajustement,
                        stock_avant=produit.stock_initial,
                        stock_apres=inventaire.stock_physique,
                        observation=f"Ajustement inventaire - {inventaire.observation or 'Aucune observation'}",
                        utilisateur=request.user
                    )
                    
                    inventaire.mouvement_ajustement = mouvement
                    inventaire.ajustement_effectue = True
                    inventaire.save()
                
                # Mettre à jour les stocks du produit (supprimer la ligne stock_initial_fixe)
                produit.stock_initial = inventaire.stock_physique
                # produit.stock_initial_fixe = inventaire.stock_physique  # À supprimer
                produit.save()
            
            return Response(
                InventaireProduitSerializer(inventaire).data,
                status=status.HTTP_201_CREATED
            )
        
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
    @action(detail=True, methods=['get'])
    def historique_inventaires(self, request, pk=None):
        """Récupérer l'historique des inventaires d'un produit"""
        produit = self.get_object()
        inventaires = InventaireProduit.objects.filter(produit=produit)
        serializer = InventaireProduitSerializer(inventaires, many=True)
        return Response(serializer.data)

class InventaireProduitViewSet(viewsets.ModelViewSet):
    """ViewSet pour la gestion des inventaires par produit"""
    queryset = InventaireProduit.objects.all()
    serializer_class = InventaireProduitSerializer
    
    def get_queryset(self):
        queryset = super().get_queryset()
        
        # Filtres optionnels
        groupe_id = self.request.query_params.get('groupe', None)
        date_debut = self.request.query_params.get('date_debut', None)
        date_fin = self.request.query_params.get('date_fin', None)
        avec_ecart = self.request.query_params.get('avec_ecart', None)
        
        if groupe_id:
            queryset = queryset.filter(produit__groupe_id=groupe_id)
        
        if date_debut:
            queryset = queryset.filter(date_inventaire__gte=date_debut)
        
        if date_fin:
            queryset = queryset.filter(date_inventaire__lte=date_fin)
        
        if avec_ecart == 'true':
            queryset = queryset.exclude(ecart=0)
        
        return queryset
    
    @action(detail=False, methods=['get'])
    def rapport_par_groupe(self, request):
        """Génère un rapport d'inventaire groupé par groupe de produits"""
        from django.db.models import Count, Sum, Avg
        from products.models import Groupe
        
        groupes = Groupe.objects.annotate(
            nb_inventaires=Count('produits__inventaires'),
            ecart_total=Sum('produits__inventaires__ecart'),
            ecart_moyen=Avg('produits__inventaires__ecart')
        ).filter(nb_inventaires__gt=0)
        
        rapport = []
        for groupe in groupes:
            inventaires_groupe = InventaireProduit.objects.filter(
                produit__groupe=groupe
            ).order_by('-date_inventaire')
            
            ecarts_positifs = inventaires_groupe.filter(ecart__gt=0).count()
            ecarts_negatifs = inventaires_groupe.filter(ecart__lt=0).count()
            ecarts_nuls = inventaires_groupe.filter(ecart=0).count()
            
            rapport.append({
                'groupe_nom': groupe.nom,
                'nb_inventaires': groupe.nb_inventaires,
                'ecart_total': groupe.ecart_total or 0,
                'ecart_moyen': groupe.ecart_moyen or 0,
                'ecarts_positifs': ecarts_positifs,
                'ecarts_negatifs': ecarts_negatifs,
                'ecarts_nuls': ecarts_nuls,
                'derniers_inventaires': InventaireProduitSerializer(
                    inventaires_groupe[:5], many=True
                ).data
            })
        
        return Response(rapport)
    
    @action(detail=False, methods=['get'])
    def statistiques_globales(self, request):
        """Statistiques globales des inventaires"""
        from django.db.models import Count, Sum, Avg
        
        stats = InventaireProduit.objects.aggregate(
            total_inventaires=Count('id'),
            ecart_total=Sum('ecart'),
            ecart_moyen=Avg('ecart'),
            inventaires_avec_ecart=Count('id', filter=models.Q(ecart__ne=0))
        )
        
        # Inventaires par période
        aujourd_hui = timezone.now().date()
        cette_semaine = aujourd_hui - timezone.timedelta(days=7)
        ce_mois = aujourd_hui.replace(day=1)
        
        stats.update({
            'inventaires_aujourd_hui': InventaireProduit.objects.filter(
                date_inventaire__date=aujourd_hui
            ).count(),
            'inventaires_cette_semaine': InventaireProduit.objects.filter(
                date_inventaire__date__gte=cette_semaine
            ).count(),
            'inventaires_ce_mois': InventaireProduit.objects.filter(
                date_inventaire__date__gte=ce_mois
            ).count()
        })
        
        return Response(stats)
