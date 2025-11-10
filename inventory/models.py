from django.db import models
from django.conf import settings
from django.utils import timezone

class SessionInventaire(models.Model):
    """
    Modèle pour gérer les sessions d'inventaire
    """
    STATUT_CHOIX = [
        ('EN_COURS', 'En cours'),
        ('TERMINEE', 'Terminée'),
    ]
    
    reference = models.CharField(max_length=40, unique=True)
    date_debut = models.DateTimeField(default=timezone.now)
    date_fin = models.DateTimeField(null=True, blank=True)
    statut = models.CharField(
        max_length=10, 
        choices=STATUT_CHOIX, 
        default='EN_COURS'
    )
    responsable = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.PROTECT
    )
    
    class Meta:
        verbose_name = "Session d'inventaire"
        verbose_name_plural = "Sessions d'inventaire"
        ordering = ['-date_debut']
    
    def __str__(self):
        return self.reference

class LigneComptage(models.Model):
    """
    Modèle pour enregistrer les comptages lors d'une session d'inventaire
    """
    session = models.ForeignKey(
        SessionInventaire, 
        related_name='comptages', 
        on_delete=models.CASCADE
    )
    produit = models.ForeignKey(
        'products.Produit', 
        on_delete=models.PROTECT
    )
    quantite_physique = models.DecimalField(
        max_digits=14, 
        decimal_places=3
    )
    date_comptage = models.DateTimeField(auto_now_add=True)
    operateur = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.PROTECT
    )
    
    class Meta:
        verbose_name = "Ligne de comptage"
        verbose_name_plural = "Lignes de comptage"
        indexes = [
            models.Index(fields=['session', 'produit']),
        ]
        unique_together = [['session', 'produit']]
    
    def __str__(self):
        return f"Comptage {self.produit.nom} - {self.session.reference}"

class AjustementInventaire(models.Model):
    """
    Modèle pour gérer les ajustements suite à un inventaire
    """
    session = models.ForeignKey(
        SessionInventaire, 
        related_name='ajustements', 
        on_delete=models.CASCADE
    )
    produit = models.ForeignKey(
        'products.Produit', 
        on_delete=models.PROTECT
    )
    quantite_theorique = models.DecimalField(
        max_digits=14, 
        decimal_places=3
    )
    quantite_physique = models.DecimalField(
        max_digits=14, 
        decimal_places=3
    )
    ecart = models.DecimalField(
        max_digits=14, 
        decimal_places=3
    )
    date_ajustement = models.DateTimeField(auto_now_add=True)
    commentaire = models.TextField(blank=True)
    valide_par = models.ForeignKey(
        settings.AUTH_USER_MODEL, 
        on_delete=models.PROTECT, 
        related_name='ajustements_valides', 
        null=True, 
        blank=True
    )
    
    class Meta:
        verbose_name = "Ajustement d'inventaire"
        verbose_name_plural = "Ajustements d'inventaire"
        ordering = ['-date_ajustement']
    
    def __str__(self):
        return f"Ajust {self.produit.nom} ({self.ecart})"
    
    def save(self, *args, **kwargs):
        # Calculer automatiquement l'écart
        self.ecart = self.quantite_physique - self.quantite_theorique
        super().save(*args, **kwargs)
