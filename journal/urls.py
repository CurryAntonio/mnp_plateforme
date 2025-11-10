from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import MouvementViewSet, JournalStatsView

router = DefaultRouter()
router.register(r'', MouvementViewSet)

urlpatterns = [
    # Placer l'URL stats/ avant le routeur
    path('stats/', JournalStatsView.as_view(), name='journal-stats'),
    path('', include(router.urls)),
]