from django.contrib import admin
from .models import SessionInventaire, LigneComptage, AjustementInventaire

@admin.register(SessionInventaire)
class SessionInventaireAdmin(admin.ModelAdmin):
    list_display = ['reference', 'date_debut', 'date_fin', 'statut', 'responsable']
    list_filter = ['statut', 'date_debut']
    search_fields = ['reference']
    readonly_fields = ['date_debut']

@admin.register(LigneComptage)
class LigneComptageAdmin(admin.ModelAdmin):
    list_display = ['session', 'produit', 'quantite_physique', 'date_comptage', 'operateur']
    list_filter = ['session', 'date_comptage']
    search_fields = ['produit__nom', 'session__reference']

@admin.register(AjustementInventaire)
class AjustementInventaireAdmin(admin.ModelAdmin):
    list_display = ['session', 'produit', 'quantite_theorique', 'quantite_physique', 'ecart', 'date_ajustement']
    list_filter = ['session', 'date_ajustement']
    search_fields = ['produit__nom', 'session__reference']
    readonly_fields = ['ecart', 'date_ajustement']
