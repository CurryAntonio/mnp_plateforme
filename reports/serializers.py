from rest_framework import serializers
from .models import ReorderAnalysis, ReorderConfiguration, ReorderMonitoring
from products.serializers import ProduitSerializer

class DashboardDataSerializer(serializers.Serializer):
    stats = serializers.DictField()
    recent_movements = serializers.ListField()
    low_stock_items = serializers.ListField()
    stock_evolution = serializers.ListField()

class StockReportSerializer(serializers.Serializer):
    date = serializers.DateField()
    products = serializers.ListField()
    low_stock_count = serializers.IntegerField()

class MovementReportSerializer(serializers.Serializer):
    start_date = serializers.DateField(allow_null=True)
    end_date = serializers.DateField(allow_null=True)
    movements = serializers.ListField()
    stats = serializers.DictField()

class ReorderAnalysisSerializer(serializers.ModelSerializer):
    """Serializer pour les analyses de point de commande"""
    produit_details = ProduitSerializer(source='produit', read_only=True)
    is_urgent = serializers.ReadOnlyField()
    needs_monitoring = serializers.ReadOnlyField()
    
    class Meta:
        model = ReorderAnalysis
        fields = [
            'id', 'produit', 'produit_details', 'depot',
            'avg_daily_demand', 'sigma_daily_demand', 'lead_time_days',
            'safety_stock', 'reorder_point', 'predicted_30d',
            'days_of_coverage', 'suggested_qty', 'status',
            'confidence_level', 'confidence_reason', 'calculation_date',
            'window_days_used', 'z_factor_used', 'movements_count',
            'explanation', 'is_urgent', 'needs_monitoring'
        ]
        read_only_fields = [
            'calculation_date', 'avg_daily_demand', 'sigma_daily_demand',
            'safety_stock', 'reorder_point', 'predicted_30d',
            'days_of_coverage', 'suggested_qty', 'explanation'
        ]

class ReorderConfigurationSerializer(serializers.ModelSerializer):
    """Serializer pour la configuration des calculs"""
    
    class Meta:
        model = ReorderConfiguration
        fields = '__all__'
        read_only_fields = ['created_at']

class ReorderMonitoringSerializer(serializers.ModelSerializer):
    """Serializer pour le monitoring des recommandations"""
    approval_rate = serializers.ReadOnlyField()
    
    class Meta:
        model = ReorderMonitoring
        fields = '__all__'
        read_only_fields = ['created_at']
