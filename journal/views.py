from rest_framework import viewsets, filters, status
from rest_framework.views import APIView
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from django.db.models import Q
from django.db.models import Sum, Count
from django.utils import timezone
from datetime import datetime, timedelta
from .models import Mouvement
from .serializers import MouvementSerializer, MouvementDetailSerializer, MouvementCreateSerializer

class MouvementViewSet(viewsets.ModelViewSet):
    queryset = Mouvement.objects.all()
    filter_backends = [DjangoFilterBackend, filters.SearchFilter, filters.OrderingFilter]
    filterset_fields = ['mouvement', 'produit', 'demandeur']
    search_fields = ['produit__nom', 'produit__code', 'demandeur', 'observation']
    ordering_fields = ['date', 'produit__nom', 'quantite']
    ordering = ['-date']
    
    def get_serializer_class(self):
        if self.action == 'retrieve':
            return MouvementDetailSerializer
        elif self.action in ['create', 'update', 'partial_update']:
            return MouvementCreateSerializer
        return MouvementSerializer
    
    def get_queryset(self):
        queryset = Mouvement.objects.all()
        
        # Filtrer par date
        date_start = self.request.query_params.get('date_start')
        date_end = self.request.query_params.get('date_end')
        
        if date_start:
            try:
                date_start = datetime.strptime(date_start, '%Y-%m-%d')
                queryset = queryset.filter(date__gte=date_start)
            except ValueError:
                pass
        
        if date_end:
            try:
                date_end = datetime.strptime(date_end, '%Y-%m-%d')
                date_end = date_end + timedelta(days=1)  # Inclure toute la journée
                queryset = queryset.filter(date__lt=date_end)
            except ValueError:
                pass
        
        # Filtrer par période
        period = self.request.query_params.get('period')
        today = datetime.now().date()
        
        if period == 'today':
            queryset = queryset.filter(date__date=today)
        elif period == 'yesterday':
            yesterday = today - timedelta(days=1)
            queryset = queryset.filter(date__date=yesterday)
        elif period == 'this_week':
            start_of_week = today - timedelta(days=today.weekday())
            queryset = queryset.filter(date__date__gte=start_of_week)
        elif period == 'this_month':
            start_of_month = today.replace(day=1)
            queryset = queryset.filter(date__date__gte=start_of_month)
        
        return queryset



class JournalStatsView(APIView):
    def get(self, request):
        today = timezone.now().date()
        
        # Statistiques pour aujourd'hui
        today_entries = Mouvement.objects.filter(
            date__date=today,
            mouvement='Entrée'
        ).count()
        
        today_exits = Mouvement.objects.filter(
            date__date=today,
            mouvement='Sortie'
        ).count()
        
        today_requests = Mouvement.objects.filter(
            date__date=today,
            mouvement='Demandée'
        ).count()
        
        total_today = today_entries + today_exits + today_requests
        
        return Response({
            'todayEntries': today_entries,
            'todayExits': today_exits,
            'todayRequests': today_requests,
            'totalToday': total_today
        })