from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import (
    ImportExcelView,
    ExportExcelView,
    ExportCompletView,
    ImportHistoryViewSet,
    ExportHistoryViewSet,
    BackupView,
    RestoreBackupView
)

router = DefaultRouter()
router.register(r'import-history', ImportHistoryViewSet)
router.register(r'export-history', ExportHistoryViewSet)

urlpatterns = [
    path('', include(router.urls)),
    path('import/excel/', ImportExcelView.as_view(), name='import-excel'),
    path('export/excel/', ExportExcelView.as_view(), name='export-excel'),
    path('export/complet/', ExportCompletView.as_view(), name='export-complet'),
    path('backup/', BackupView.as_view(), name='backup'),
    path('backup/restore/<int:backup_id>/', RestoreBackupView.as_view(), name='restore-backup'),
]