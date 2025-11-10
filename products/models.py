from django.db import models
from django.utils.text import slugify
import uuid

class Groupe(models.Model):
    nom = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    couleur = models.CharField(max_length=20, blank=True, null=True, default="#3B82F6")
    date_creation = models.DateTimeField(auto_now_add=True)
    date_modification = models.DateTimeField(auto_now=True)
    
    class Meta:
        verbose_name = "Groupe"
        verbose_name_plural = "Groupes"
        ordering = ['nom']
    
    def __str__(self):
        return self.nom

class Produit(models.Model):
    code = models.CharField(max_length=50, unique=True)
    nom = models.CharField(max_length=200)
    groupe = models.ForeignKey(Groupe, on_delete=models.SET_NULL, null=True, related_name='produits')
    stock_initial = models.IntegerField(default=0)
    seuil = models.IntegerField(default=10)
    unite = models.CharField(max_length=50, default="Pièce")
    zone = models.CharField(max_length=100, blank=True, null=True)
    observation = models.TextField(blank=True, null=True)
    lead_time = models.IntegerField(
        default=7, 
        help_text="Délai de livraison en jours"
    )
    date_creation = models.DateTimeField(auto_now_add=True)
    date_modification = models.DateTimeField(auto_now=True)
    # stock_initial_fixe supprimé
    
    class Meta:
        verbose_name = "Produit"
        verbose_name_plural = "Produits"
        ordering = ['nom']
    
    def __str__(self):
        return f"{self.code} - {self.nom}"
    
    def save(self, *args, **kwargs):
        # Générer un code unique si non fourni
        if not self.code:
            prefix = "PRD"
            if self.groupe:
                prefix = ''.join(word[0] for word in self.groupe.nom.split()[:3]).upper()
            unique_id = str(uuid.uuid4())[:8]
            self.code = f"{prefix}-{unique_id}"
        super().save(*args, **kwargs)
    
    @property
    def is_low_stock(self):
        return self.stock_initial < self.seuil

class InventaireProduit(models.Model):
    """Modèle pour l'inventaire individuel par produit"""
    produit = models.ForeignKey(
        Produit, 
        on_delete=models.CASCADE, 
        related_name='inventaires'
    )
    stock_systeme = models.DecimalField(
        max_digits=10, 
        decimal_places=2,
        help_text="Stock selon le système au moment de l'inventaire"
    )
    stock_physique = models.DecimalField(
        max_digits=10, 
        decimal_places=2,
        help_text="Stock compté physiquement"
    )
    ecart = models.DecimalField(
        max_digits=10, 
        decimal_places=2,
        help_text="Différence entre stock physique et système"
    )
    date_inventaire = models.DateTimeField(auto_now_add=True)
    observation = models.TextField(blank=True, null=True)
    utilisateur = models.ForeignKey(
        'users.User', 
        on_delete=models.CASCADE,
        help_text="Utilisateur ayant effectué l'inventaire"
    )
    ajustement_effectue = models.BooleanField(
        default=False,
        help_text="Indique si l'ajustement de stock a été effectué"
    )
    mouvement_ajustement = models.ForeignKey(
        'journal.Mouvement',
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        help_text="Mouvement d'ajustement créé suite à l'inventaire"
    )
    
    class Meta:
        ordering = ['-date_inventaire']
        verbose_name = "Inventaire Produit"
        verbose_name_plural = "Inventaires Produits"
    
    def save(self, *args, **kwargs):
        # Calcul automatique de l'écart
        self.ecart = self.stock_physique - self.stock_systeme
        super().save(*args, **kwargs)
    
    def __str__(self):
        return f"Inventaire {self.produit.nom} - {self.date_inventaire.strftime('%d/%m/%Y')}"