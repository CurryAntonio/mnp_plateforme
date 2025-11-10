#!/usr/bin/env python
import os
import sys
import django

# Configuration Django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings')
sys.path.append(os.path.dirname(os.path.abspath(__file__)))
django.setup()

from journal.models import Mouvement
from products.models import Produit, InventaireProduit, Groupe
from users.models import User

print("=== VÉRIFICATION DES DONNÉES ===\n")

# Vérification des groupes
print(f"Nombre de groupes: {Groupe.objects.count()}")
if Groupe.objects.exists():
    print("Groupes disponibles:")
    for g in Groupe.objects.all():
        print(f"  - {g.id}: {g.nom} ({g.produits.count()} produits)")
else:
    print("AUCUN GROUPE TROUVÉ!")

# Vérification des produits
print(f"\nNombre de produits: {Produit.objects.count()}")
if Produit.objects.exists():
    print("Premiers produits:")
    for p in Produit.objects.all()[:5]:
        groupe_nom = p.groupe.nom if p.groupe else "Sans groupe"
        print(f"  - {p.id}: {p.code} - {p.nom} (Groupe: {groupe_nom})")
else:
    print("AUCUN PRODUIT TROUVÉ!")

# Vérification des inventaires
print(f"\nNombre d'inventaires: {InventaireProduit.objects.count()}")
if InventaireProduit.objects.exists():
    print("Inventaires disponibles:")
    for inv in InventaireProduit.objects.all()[:10]:
        print(f"  - {inv.id}: {inv.produit.nom} - Stock sys: {inv.stock_systeme}, Stock phy: {inv.stock_physique}, Écart: {inv.ecart} ({inv.date_inventaire})")
else:
    print("AUCUN INVENTAIRE TROUVÉ!")
    print("C'est pourquoi le rapport retourne une liste vide.")

# Vérification des utilisateurs
print(f"\nNombre d'utilisateurs: {User.objects.count()}")
if User.objects.exists():
    print("Utilisateurs disponibles:")
    for u in User.objects.all()[:3]:
        print(f"  - {u.id}: {u.email} ({u.nom} {u.prenom})")
else:
    print("AUCUN UTILISATEUR TROUVÉ!")

# Vérification des mouvements
print(f"\nNombre de mouvements: {Mouvement.objects.count()}")
if Mouvement.objects.exists():
    print("Derniers mouvements:")
    for m in Mouvement.objects.order_by('-date')[:5]:
        print(f"  - {m.id}: {m.mouvement} de {m.quantite} {m.produit.nom} le {m.date}")
else:
    print("AUCUN MOUVEMENT TROUVÉ!")

print("\n=== DIAGNOSTIC ===\n")
if not InventaireProduit.objects.exists():
    print("PROBLÈME IDENTIFIÉ: Aucun inventaire dans la base de données.")
    print("Solutions possibles:")
    print("1. L'endpoint /api/products/4/inventorier/ retourne 404 - il faut corriger cette route")
    print("2. Créer manuellement un inventaire pour tester")
    print("3. Vérifier que l'action 'inventorier' existe dans ProduitViewSet")

print("\n=== FIN VÉRIFICATION ===")