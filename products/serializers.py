from rest_framework import serializers
from .models import Produit, Groupe, InventaireProduit
from django.db.models import Count, F, Q

class GroupeSerializer(serializers.ModelSerializer):
    productCount = serializers.SerializerMethodField()
    lowStockCount = serializers.SerializerMethodField()
    
    class Meta:
        model = Groupe
        fields = '__all__'
    
    def get_productCount(self, obj):
        return obj.produits.count()
    
    def get_lowStockCount(self, obj):
        return obj.produits.filter(stock_initial__lt=F('seuil')).count()

class InventaireProduitSerializer(serializers.ModelSerializer):
    produit_nom = serializers.CharField(source='produit.nom', read_only=True)
    produit_code = serializers.CharField(source='produit.code', read_only=True)
    groupe_nom = serializers.CharField(source='produit.groupe.nom', read_only=True)
    utilisateur_nom = serializers.CharField(source='utilisateur.get_full_name', read_only=True)
    
    class Meta:
        model = InventaireProduit
        fields = [
            'produit', 'produit_nom', 'produit_code', 'groupe_nom',
            'stock_systeme', 'stock_physique', 'ecart',
            'date_inventaire', 'observation', 'utilisateur_nom',
            'ajustement_effectue'
        ]
        read_only_fields = ['stock_systeme', 'ecart', 'date_inventaire', 'utilisateur_nom', 'ajustement_effectue']

class InventaireProduitCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = InventaireProduit
        fields = ['produit', 'stock_physique', 'observation']
    
    def create(self, validated_data):
        # Récupération du stock système actuel
        produit = validated_data['produit']
        validated_data['stock_systeme'] = produit.stock_initial
        validated_data['utilisateur'] = self.context['request'].user
        return super().create(validated_data)

class ProduitSerializer(serializers.ModelSerializer):
    groupe_nom = serializers.CharField(source='groupe.nom', read_only=True)
    dernier_inventaire = serializers.SerializerMethodField()
    
    class Meta:
        model = Produit
        fields = '__all__'
    
    def get_dernier_inventaire(self, obj):
        dernier = obj.inventaires.first()
        if dernier:
            return {
                'date': dernier.date_inventaire,
                'stock_physique': dernier.stock_physique,
                'ecart': dernier.ecart
            }
        return None

class ProduitDetailSerializer(serializers.ModelSerializer):
    groupe = GroupeSerializer(read_only=True)
    
    class Meta:
        model = Produit
        fields = '__all__'

class ProduitCreateUpdateSerializer(serializers.ModelSerializer):
    groupe_id = serializers.PrimaryKeyRelatedField(
        queryset=Groupe.objects.all(),
        source='groupe',
        required=False,
        allow_null=True
    )
    
    class Meta:
        model = Produit
        fields = ['id', 'code', 'nom', 'groupe_id', 'stock_initial', 'seuil', 'unite', 'zone', 'observation']
    
    def validate_code(self, value):
        # Vérifier si le code existe déjà lors de la création
        instance = getattr(self, 'instance', None)
        if instance is None:  # Création
            if Produit.objects.filter(code=value).exists():
                raise serializers.ValidationError("Ce code existe déjà.")
        else:  # Mise à jour
            if Produit.objects.filter(code=value).exclude(id=instance.id).exists():
                raise serializers.ValidationError("Ce code existe déjà.")
        return value