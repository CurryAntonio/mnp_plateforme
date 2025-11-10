from django.db import models
from django.contrib.auth import get_user_model
from products.models import Produit
import math

User = get_user_model()

class ReorderConfiguration(models.Model):
    """Configuration globale pour les calculs de point de commande"""
    # Paramètres de calcul
    window_days = models.IntegerField(default=90, help_text="Fenêtre d'historique en jours")
    forecast_horizon = models.IntegerField(default=30, help_text="Horizon de prévision en jours")
    z_factor = models.DecimalField(max_digits=5, decimal_places=2, default=1.65, help_text="Facteur de service (1.65 = 95%)")
    default_lead_time = models.IntegerField(default=7, help_text="Lead time par défaut en jours")
    
    # Seuils de statut
    urgent_threshold_multiplier = models.DecimalField(max_digits=3, decimal_places=1, default=1.0)
    monitor_threshold_multiplier = models.DecimalField(max_digits=3, decimal_places=1, default=2.0)
    
    # Confiance
    min_historical_days_for_confidence = models.IntegerField(default=30)
    min_movements_for_confidence = models.IntegerField(default=10)
    
    # Métadonnées
    created_at = models.DateTimeField(auto_now_add=True)
    is_active = models.BooleanField(default=True)
    
    class Meta:
        verbose_name = "Configuration Point de Commande"
        verbose_name_plural = "Configurations Point de Commande"
    
    def __str__(self):
        return f"Config {self.created_at.strftime('%Y-%m-%d')} ({'Active' if self.is_active else 'Inactive'})"

class ReorderAnalysis(models.Model):
    """Analyse de point de commande pour un produit"""
    STATUS_CHOICES = [
        ('OK', 'OK'),
        ('A_SURVEILLER', 'À Surveiller'),
        ('URGENT', 'Urgent'),
    ]
    
    CONFIDENCE_CHOICES = [
        ('HIGH', 'Élevée'),
        ('MEDIUM', 'Moyenne'),
        ('LOW', 'Faible'),
    ]
    
    # Référence produit
    produit = models.ForeignKey(Produit, on_delete=models.CASCADE, related_name='reorder_analyses')
    depot = models.CharField(max_length=100, default='Principal')
    
    # Métriques calculées
    avg_daily_demand = models.DecimalField(max_digits=10, decimal_places=3, help_text="Demande journalière moyenne")
    sigma_daily_demand = models.DecimalField(max_digits=10, decimal_places=3, help_text="Écart-type journalier")
    lead_time_days = models.IntegerField(help_text="Lead time en jours")
    safety_stock = models.DecimalField(max_digits=10, decimal_places=2, help_text="Stock de sécurité")
    reorder_point = models.DecimalField(max_digits=10, decimal_places=2, help_text="Point de commande")
    predicted_30d = models.DecimalField(max_digits=10, decimal_places=2, help_text="Prévision 30 jours")
    days_of_coverage = models.DecimalField(max_digits=10, decimal_places=2, help_text="Jours de couverture")
    suggested_qty = models.DecimalField(max_digits=10, decimal_places=2, help_text="Quantité suggérée")
    
    # Statut et confiance
    status = models.CharField(max_length=20, choices=STATUS_CHOICES)
    confidence_level = models.CharField(max_length=10, choices=CONFIDENCE_CHOICES)
    confidence_reason = models.TextField(blank=True, help_text="Raison du niveau de confiance")
    
    # Métadonnées de calcul
    calculation_date = models.DateTimeField(auto_now=True)
    window_days_used = models.IntegerField()
    z_factor_used = models.DecimalField(max_digits=5, decimal_places=2)
    movements_count = models.IntegerField(help_text="Nombre de mouvements utilisés")
    
    # Explications
    explanation = models.JSONField(default=dict, help_text="Détails des calculs")
    
    class Meta:
        verbose_name = "Analyse Point de Commande"
        verbose_name_plural = "Analyses Point de Commande"
        ordering = ['-calculation_date', 'status', 'produit__nom']
        unique_together = ['produit', 'depot', 'calculation_date']
    
    def __str__(self):
        return f"{self.produit.nom} - {self.status} ({self.calculation_date.strftime('%Y-%m-%d')})"
    
    @property
    def is_urgent(self):
        return self.status == 'URGENT'
    
    @property
    def needs_monitoring(self):
        return self.status in ['URGENT', 'A_SURVEILLER']


class ReorderMonitoring(models.Model):
    """Monitoring des performances du système de recommandations"""
    # Métriques quotidiennes
    date = models.DateField(unique=True)
    
    # Compteurs par statut
    urgent_count = models.IntegerField(default=0)
    monitor_count = models.IntegerField(default=0)
    ok_count = models.IntegerField(default=0)
    
    # Métriques de performance
    total_suggested_units = models.DecimalField(max_digits=15, decimal_places=2, default=0)
    draft_orders_created = models.IntegerField(default=0)
    draft_orders_approved = models.IntegerField(default=0)
    
    # Temps d'exécution
    batch_execution_time = models.DecimalField(max_digits=10, decimal_places=2, null=True, help_text="Temps en secondes")
    batch_success = models.BooleanField(default=True)
    batch_error_message = models.TextField(blank=True)
    
    # Métriques de qualité
    average_confidence = models.DecimalField(max_digits=5, decimal_places=2, null=True)
    low_confidence_count = models.IntegerField(default=0)
    
    created_at = models.DateTimeField(auto_now_add=True)
    
    class Meta:
        verbose_name = "Monitoring Recommandations"
        verbose_name_plural = "Monitoring Recommandations"
        ordering = ['-date']
    
    def __str__(self):
        return f"Monitoring {self.date} - {self.urgent_count} urgents"
    
    @property
    def approval_rate(self):
        if self.draft_orders_created == 0:
            return 0
        return (self.draft_orders_approved / self.draft_orders_created) * 100