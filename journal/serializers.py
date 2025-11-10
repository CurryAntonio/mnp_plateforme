from rest_framework import serializers
from .models import Mouvement
from products.models import Produit
from products.serializers import ProduitSerializer
from datetime import datetime, time as time_cls
from django.utils import timezone

class MouvementSerializer(serializers.ModelSerializer):
    produit_nom = serializers.SerializerMethodField()
    produit_code = serializers.SerializerMethodField()
    groupe = serializers.SerializerMethodField()
    unite = serializers.SerializerMethodField()
    
    class Meta:
        model = Mouvement
        fields = '__all__'
    
    def get_produit_nom(self, obj):
        return obj.produit.nom
    
    def get_produit_code(self, obj):
        return obj.produit.code
    
    def get_groupe(self, obj):
        return obj.produit.groupe.nom if obj.produit.groupe else None
    
    def get_unite(self, obj):
        return obj.produit.unite

class MouvementDetailSerializer(serializers.ModelSerializer):
    produit = ProduitSerializer(read_only=True)
    
    class Meta:
        model = Mouvement
        fields = '__all__'

class MouvementCreateSerializer(serializers.ModelSerializer):
    produit_id = serializers.PrimaryKeyRelatedField(
        queryset=Produit.objects.all(),
        source='produit'
    )
    date = serializers.DateField(required=True, write_only=True)
    time = serializers.TimeField(required=False, allow_null=True, write_only=True)
    
    class Meta:
        model = Mouvement
        fields = ['produit_id', 'mouvement', 'quantite', 'demandeur', 'observation', 'date', 'time']
    
    def validate(self, data):
        produit = data['produit']
        mouvement = data['mouvement']
        quantite = data['quantite']
        
        if quantite <= 0:
            raise serializers.ValidationError("La quantité doit être supérieure à zéro.")
        
        if mouvement == 'Sortie' and quantite > produit.stock_initial:
            raise serializers.ValidationError("Stock insuffisant pour cette sortie.")
        
        return data
    
    def create(self, validated_data):
        produit = validated_data['produit']
        mouvement = validated_data['mouvement']
        quantite = validated_data['quantite']
        
        # Calculer le stock avant et après
        stock_avant = produit.stock_initial
        stock_apres = stock_avant
        
        if mouvement == 'Entrée':
            stock_apres = stock_avant + quantite
        elif mouvement == 'Sortie':
            stock_apres = stock_avant - quantite
        
        # Créer le mouvement
        # Transformer date + time en DateTime aware
        date_only = validated_data['date']
        time_part = validated_data.get('time') or time_cls(0, 0)
        combined_naive = datetime.combine(date_only, time_part)
        combined_aware = timezone.make_aware(combined_naive)

        mouvement_obj = Mouvement.objects.create(
            produit=produit,
            mouvement=mouvement,
            quantite=quantite,
            stock_avant=stock_avant,
            stock_apres=stock_apres,
            demandeur=validated_data['demandeur'],
            observation=validated_data.get('observation', ''),
            date=combined_aware,
            utilisateur=self.context['request'].user if 'request' in self.context else None
        )
        
        # Mettre à jour le stock du produit si ce n'est pas une demande
        if mouvement != 'Demandée':
            produit.stock_initial = stock_apres
            produit.save()
        
        return mouvement_obj
    
    def update(self, instance, validated_data):
        if 'produit' in validated_data:
            instance.produit = validated_data['produit']
        if 'mouvement' in validated_data:
            instance.mouvement = validated_data['mouvement']
        if 'quantite' in validated_data:
            instance.quantite = validated_data['quantite']
        if 'demandeur' in validated_data:
            instance.demandeur = validated_data['demandeur']
        if 'observation' in validated_data:
            instance.observation = validated_data['observation']
        if 'date' in validated_data:
            from datetime import datetime, time as time_cls
            from django.utils import timezone
            date_only = validated_data['date']
            time_part = validated_data.get('time') or time_cls(0, 0)
            instance.date = timezone.make_aware(datetime.combine(date_only, time_part))
        instance.save()
        return instance