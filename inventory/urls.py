from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import SessionInventaireViewSet, LigneComptageViewSet, AjustementInventaireViewSet

router = DefaultRouter()
router.register(r'sessions-inventaire', SessionInventaireViewSet)
router.register(r'ligne-comptages', LigneComptageViewSet)
router.register(r'ajustements-inventaire', AjustementInventaireViewSet)

urlpatterns = [
    path('', include(router.urls)),
]