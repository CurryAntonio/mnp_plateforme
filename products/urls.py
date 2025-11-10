from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ProduitViewSet, InventaireProduitViewSet

router = DefaultRouter()
router.register(r'products', ProduitViewSet, basename='produit')
router.register(r'inventaires', InventaireProduitViewSet, basename='inventaire-produit')

urlpatterns = [
    path('', include(router.urls)),
]