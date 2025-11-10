from django.urls import path
from .views import (
    sauvegarde_view, 
    restauration_view, 
    liste_sauvegardes_view,
    statut_tache_view,
    informations_stockage_view,
    supprimer_sauvegarde_view  # Ajouter cet import
)

urlpatterns = [
    path("sauvegarde/", sauvegarde_view, name="sauvegarde"),
    path("restauration/", restauration_view, name="restauration"),
    path("sauvegardes/", liste_sauvegardes_view, name="liste_sauvegardes"),
    path("statut/<str:task_id>/", statut_tache_view, name="statut_tache"),
    path("stockage/", informations_stockage_view, name="informations_stockage"),
    path("supprimer/<str:filename>/", supprimer_sauvegarde_view, name="supprimer_sauvegarde"),  # Nouvelle route
]