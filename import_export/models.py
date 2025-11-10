from django.db import models
from django.utils import timezone
from django.contrib.auth import get_user_model

User = get_user_model()

class ImportHistory(models.Model):
    IMPORT_TYPES = (
        ('products', 'Produits'),
        ('groups', 'Groupes'),
        ('movements', 'Mouvements'),
    )
    
    STATUS_CHOICES = (
        ('pending', 'En attente'),
        ('processing', 'En cours'),
        ('completed', 'Terminé'),
        ('failed', 'Échoué'),
    )
    
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='imports')
    file_name = models.CharField(max_length=255)
    file_size = models.BigIntegerField(null=True, blank=True)  # NOUVEAU CHAMP
    import_type = models.CharField(max_length=20, choices=IMPORT_TYPES)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    total_rows = models.IntegerField(default=0)
    processed_rows = models.IntegerField(default=0)
    success_rows = models.IntegerField(default=0)
    error_rows = models.IntegerField(default=0)
    error_details = models.TextField(blank=True, null=True)
    
    def __str__(self):
        return f"{self.file_name} - {self.import_type} - {self.status}"
    
    def mark_completed(self, success_rows, error_rows, error_details=None):
        self.status = 'completed'
        self.completed_at = timezone.now()
        self.processed_rows = success_rows + error_rows
        self.success_rows = success_rows
        self.error_rows = error_rows
        self.error_details = error_details
        self.save()
    
    def mark_failed(self, error_details):
        self.status = 'failed'
        self.completed_at = timezone.now()
        self.error_details = error_details
        self.save()


class ExportHistory(models.Model):
    EXPORT_TYPES = (
        ('products', 'Produits'),
        ('groups', 'Groupes'),
        ('movements', 'Mouvements'),
        ('stock_report', 'Rapport de stock'),
        ('movement_report', 'Rapport de mouvements'),
        ('complet', 'Export Complet'),
    )
    
    STATUS_CHOICES = (
        ('pending', 'En attente'),
        ('processing', 'En cours'),
        ('completed', 'Terminé'),
        ('failed', 'Échoué'),
    )
    
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='exports')
    file_name = models.CharField(max_length=255)
    export_type = models.CharField(max_length=20, choices=EXPORT_TYPES)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    completed_at = models.DateTimeField(null=True, blank=True)
    filters = models.JSONField(default=dict, blank=True)
    row_count = models.IntegerField(default=0)
    error_details = models.TextField(blank=True, null=True)
    
    def __str__(self):
        return f"{self.file_name} - {self.export_type} - {self.status}"