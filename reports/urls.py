from django.urls import path
from .views import (
    DashboardDataView, StockReportView, MovementReportView, ExportReportView,
    ReorderRecommendationsView, ReorderMonitoringView,
    recalculate_product_analysis, ExportXlsxAdvancedView
)

urlpatterns = [
    # Existing endpoints
    path('dashboard/', DashboardDataView.as_view(), name='dashboard-data'),
    path('stock/', StockReportView.as_view(), name='stock-report'),
    path('movements/', MovementReportView.as_view(), name='movement-report'),
    path('export/', ExportReportView.as_view(), name='export-report'),
    path('export-xlsx-advanced/', ExportXlsxAdvancedView.as_view(), name='export-xlsx-advanced'),
    
    # New reorder recommendation endpoints
    path('reorder-recommendations/', ReorderRecommendationsView.as_view(), name='reorder-recommendations'),
    path('reorder-recommendations/recalculate/', recalculate_product_analysis, name='recalculate-analysis'),
    
    # Monitoring
    path('monitoring/', ReorderMonitoringView.as_view(), name='reorder-monitoring'),
]