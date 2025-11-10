from rest_framework import serializers
from .models import SessionInventaire, LigneComptage, AjustementInventaire
from products.serializers import ProduitSerializer

class LigneComptageSerializer(serializers.ModelSerializer):
    produit_detail = ProduitSerializer(source='produit', read_only=True)
    
    class Meta:
        model = LigneComptage
        fields = '__all__'

class AjustementInventaireSerializer(serializers.ModelSerializer):
    produit_detail = ProduitSerializer(source='produit', read_only=True)
    
    class Meta:
        model = AjustementInventaire
        fields = '__all__'

class SessionInventaireSerializer(serializers.ModelSerializer):
    comptages = LigneComptageSerializer(many=True, read_only=True)
    ajustements = AjustementInventaireSerializer(many=True, read_only=True)
    
    class Meta:
        model = SessionInventaire
        fields = ['id', 'reference', 'date_debut', 'date_fin', 'statut',
                 'responsable', 'comptages', 'ajustements']
        read_only_fields = ['date_debut', 'statut', 'responsable']