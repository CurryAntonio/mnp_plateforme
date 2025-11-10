#!/usr/bin/env python
import os
import sys
import django

# Configuration Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
django.setup()

from django.urls import get_resolver
from products.views import ProduitViewSet
from rest_framework.routers import DefaultRouter
from django.test import RequestFactory

print("=== VÉRIFICATION DES ROUTES ===\n")

# Vérifier les routes disponibles
resolver = get_resolver()
print("Routes disponibles pour products:")
for pattern in resolver.url_patterns:
    if hasattr(pattern, 'pattern') and 'products' in str(pattern.pattern):
        print(f"  - {pattern.pattern}")
        if hasattr(pattern, 'url_patterns'):
            for sub_pattern in pattern.url_patterns:
                print(f"    └─ {sub_pattern.pattern}")

# Tester le router directement
print("\n=== TEST DU ROUTER ===")
router = DefaultRouter()
router.register(r'', ProduitViewSet, basename='produit')

print("\nRoutes générées par le router:")
for url_pattern in router.urls:
    print(f"  - {url_pattern.pattern} -> {url_pattern.name}")

# Vérifier les actions disponibles sur la classe (pas l'instance)
print("\n=== ACTIONS DISPONIBLES ===")
print("Actions dans ProduitViewSet:")
for attr_name in dir(ProduitViewSet):
    attr = getattr(ProduitViewSet, attr_name)
    if hasattr(attr, 'mapping') and not attr_name.startswith('_'):
        print(f"  - {attr_name}: {getattr(attr, 'mapping', {})}")
        if hasattr(attr, 'detail'):
            detail_info = "detail" if attr.detail else "list"
            print(f"    └─ Type: {detail_info}")

# Vérifier spécifiquement l'action inventorier
print("\n=== VÉRIFICATION INVENTORIER ===")
if hasattr(ProduitViewSet, 'inventorier'):
    inventorier_action = getattr(ProduitViewSet, 'inventorier')
    print(f"Action 'inventorier' trouvée:")
    print(f"  - Méthodes: {getattr(inventorier_action, 'mapping', {})}")
    print(f"  - Detail: {getattr(inventorier_action, 'detail', False)}")
    print(f"  - URL attendue: /api/products/{'{id}'}/inventorier/")
    
    # Tester la génération d'URL
    try:
        from django.urls import reverse
        url = reverse('produit-inventorier', kwargs={'pk': 1})
        print(f"  - URL générée: {url}")
    except Exception as e:
        print(f"  - Erreur génération URL: {e}")
else:
    print("ERREUR: Action 'inventorier' non trouvée!")

# Test avec une requête simulée
print("\n=== TEST REQUÊTE SIMULÉE ===")
try:
    from django.test import Client
    from django.contrib.auth import get_user_model
    
    # Créer un client de test
    client = Client()
    
    # Tester l'endpoint
    response = client.post('/api/products/1/inventorier/', 
                          data={'stock_physique': 100},
                          content_type='application/json')
    print(f"Status code: {response.status_code}")
    if response.status_code == 404:
        print("CONFIRMÉ: L'endpoint retourne 404")
    elif response.status_code == 401:
        print("Endpoint trouvé mais authentification requise")
    else:
        print(f"Réponse: {response.content.decode()}")
        
except Exception as e:
    print(f"Erreur lors du test: {e}")

print("\n=== DIAGNOSTIC ===")
print("Si l'action 'inventorier' est trouvée mais l'URL retourne 404:")
print("1. Problème de configuration des URLs")
print("2. Problème de routage Django REST Framework")
print("3. Conflit dans les patterns d'URL")

print("\n=== FIN VÉRIFICATION ===")