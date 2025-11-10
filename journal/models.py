from django.db import models
from django.contrib.auth import get_user_model
from products.models import Produit

User = get_user_model()

class Mouvement(models.Model):
    TYPE_CHOICES = (
        ('Entrée', 'Entrée'),
        ('Sortie', 'Sortie'),
        ('Demandée', 'Demandée'),
    )
    
    produit = models.ForeignKey(Produit, on_delete=models.CASCADE, related_name='mouvements')
    mouvement = models.CharField(max_length=20, choices=TYPE_CHOICES)
    quantite = models.IntegerField()
    stock_avant = models.IntegerField()
    stock_apres = models.IntegerField()
    demandeur = models.CharField(max_length=100)
    utilisateur = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, blank=True)
    date = models.DateTimeField()
    observation = models.TextField(blank=True, null=True)
    
    class Meta:
        verbose_name = "Mouvement"
        verbose_name_plural = "Mouvements"
        ordering = ['-date']
    
    def __str__(self):
        return f"{self.mouvement} de {self.quantite} {self.produit.unite} de {self.produit.nom}"
    
    def save(self, *args, **kwargs):
        # Mettre à jour le stock du produit si ce n'est pas une demande
        if self.mouvement != 'Demandée':
            produit = self.produit
            self.stock_avant = produit.stock_initial
            
            if self.mouvement == 'Entrée':
                produit.stock_initial += self.quantite
            elif self.mouvement == 'Sortie':
                produit.stock_initial -= self.quantite
            
            self.stock_apres = produit.stock_initial
            produit.save()
        
        super().save(*args, **kwargs)