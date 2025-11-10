from django.db import models
from django.utils import timezone
from datetime import datetime, timedelta
from decimal import Decimal
import logging
import math
from journal.models import Mouvement
from .models import ReorderAnalysis, ReorderConfiguration
import statistics
from products.models import Produit
from django.db.models import Q, Sum, Avg
from django.utils import timezone
from datetime import timedelta, datetime
import numpy as np
from decimal import Decimal
import logging

logger = logging.getLogger(__name__)

class ReorderCalculationService:
    """Service principal pour les calculs de point de commande"""
    
    def __init__(self, config=None):
        self.config = config or ReorderConfiguration.objects.filter(is_active=True).first()
        if not self.config:
            # Créer configuration par défaut
            self.config = ReorderConfiguration.objects.create()
    
    def calculate_for_product(self, product_id):
        """Calculer l'analyse de réapprovisionnement pour un produit"""
        try:
            product = Produit.objects.get(id=product_id)
            
            # Récupérer l'historique des mouvements
            movements = self._get_movements_history(product_id, self.config.window_days)
            
            # Évaluer la confiance des données
            confidence = self._assess_data_confidence(movements)
            
            # Nettoyer les mouvements
            clean_movements = self._clean_movements(movements)
            
            # ✅ VALIDATION AJOUTÉE
            if not clean_movements:
                logger.warning(f"Aucun mouvement valide après nettoyage pour {product.code}")
                return None
            
            # Calculer les métriques de base
            avg_daily = self._calculate_avg_daily_demand(clean_movements)
            sigma_daily = self._calculate_sigma_daily_demand(clean_movements)
            lead_time = self._calculate_lead_time(product_id)
            
            # Appliquer les règles conservatrices
            avg_daily, sigma_daily = self._apply_conservative_rules(avg_daily, sigma_daily)
            
            # Calculer les métriques dérivées
            safety_stock = self._calculate_safety_stock(sigma_daily, lead_time)
            reorder_point = self._calculate_reorder_point(avg_daily, lead_time, safety_stock)
            predicted_30d = self._calculate_forecast(clean_movements, avg_daily)
            days_coverage = self._calculate_days_coverage(product.stock_initial, avg_daily)
            status = self._determine_status(days_coverage, lead_time, product.stock_initial, reorder_point)
            suggested_qty = self._calculate_suggested_quantity(predicted_30d, product.stock_initial, safety_stock)
            
            # ✅ CORRECTION : Convertir tous les Decimal en float pour éviter l'erreur JSON
            avg_daily_float = float(avg_daily)
            sigma_daily_float = float(sigma_daily)
            safety_stock_float = float(safety_stock)
            reorder_point_float = float(reorder_point)
            predicted_30d_float = float(predicted_30d)
            days_coverage_float = float(days_coverage)
            suggested_qty_float = float(suggested_qty)
            
            # Créer ou mettre à jour l'analyse
            analysis, created = ReorderAnalysis.objects.update_or_create(
                produit=product,
                depot='Principal',
                defaults={
                    'avg_daily_demand': avg_daily_float,
                    'sigma_daily_demand': sigma_daily_float,
                    'lead_time_days': lead_time,
                    'safety_stock': safety_stock_float,
                    'reorder_point': reorder_point_float,
                    'predicted_30d': predicted_30d_float,
                    'days_of_coverage': days_coverage_float,
                    'suggested_qty': suggested_qty_float,
                    'status': status,
                    'confidence_level': confidence['level'],
                    'confidence_reason': confidence['reason'],
                    'calculation_date': timezone.now(),
                    'window_days_used': self.config.window_days,
                    'z_factor_used': float(self.config.z_factor),  # ✅ Conversion ajoutée
                    'movements_count': len(clean_movements),
                    'explanation': self._generate_explanation(avg_daily, sigma_daily, lead_time, safety_stock, reorder_point)
                }
            )
            
            return analysis
            
        except Produit.DoesNotExist:
            logger.error(f"Produit {product_id} non trouvé")
            return None
        except Exception as e:
            logger.error(f"Erreur calcul pour produit {product_id}: {str(e)}")
            return None
    
    def _get_movements_history(self, product_id, days=30):
        """Récupère l'historique des mouvements pour un produit"""
        end_date = timezone.now().date()
        start_date = end_date - timedelta(days=days)
        
        return Mouvement.objects.filter(
            produit_id=product_id,
            date__date__range=[start_date, end_date],
            mouvement__in=['Entrée', 'Sortie']  # Exclure les demandes
        ).order_by('-date')
    
    def _assess_data_confidence(self, movements):
        """Évaluer la confiance dans les données"""
        movements_count = len(movements)
        
        if movements_count == 0:
            return {'level': 'LOW', 'reason': 'Aucun mouvement dans l\'historique'}
        
        # Calculer la période couverte
        if movements_count > 0:
            first_movement = movements[0].date
            last_movement = movements[movements_count-1].date
            days_covered = (last_movement - first_movement).days
        else:
            days_covered = 0
        
        if (movements_count < self.config.min_movements_for_confidence or 
            days_covered < self.config.min_historical_days_for_confidence):
            return {
                'level': 'LOW', 
                'reason': f'Historique insuffisant: {movements_count} mouvements sur {days_covered} jours'
            }
        elif movements_count < 25 or days_covered < 60:
            return {
                'level': 'MEDIUM', 
                'reason': f'Historique modéré: {movements_count} mouvements sur {days_covered} jours'
            }
        else:
            return {
                'level': 'HIGH', 
                'reason': f'Historique suffisant: {movements_count} mouvements sur {days_covered} jours'
            }
    
    def _clean_movements(self, movements):
        """Nettoyer les mouvements en enlevant les anomalies"""
        if len(movements) < 5:
            return movements
        
        quantities = [m.quantite for m in movements]
        
        # Méthode IQR pour détecter les outliers
        q1 = statistics.quantiles(quantities, n=4)[0]  # 25e percentile
        q3 = statistics.quantiles(quantities, n=4)[2]  # 75e percentile
        iqr = q3 - q1
        
        lower_bound = q1 - 1.5 * iqr
        upper_bound = q3 + 1.5 * iqr
        
        # Filtrer les mouvements dans les bornes
        clean_movements = [
            m for m in movements 
            if lower_bound <= m.quantite <= upper_bound
        ]
        
        # Garder au moins 70% des données
        if len(clean_movements) < len(movements) * 0.7:
            return movements
        
        return clean_movements
    
    def _calculate_avg_daily_demand(self, movements):
        """Calculer la demande journalière moyenne"""
        if not movements:
            return Decimal('0.0')  # ✅ Retourner Decimal au lieu de float
        
        total_quantity = sum(Decimal(str(m.quantite)) for m in movements)
        return total_quantity / Decimal(str(self.config.window_days))
    
    def _calculate_sigma_daily_demand(self, movements):
        """Calculer l'écart-type de la demande journalière"""
        if len(movements) < 2:
            return Decimal('0.1')  # Valeur par défaut
        
        # Grouper par jour et sommer les quantités
        daily_demands = {}
        for movement in movements:
            day = movement.date.date()
            if day not in daily_demands:
                daily_demands[day] = Decimal('0')
            if movement.mouvement == 'Sortie':
                daily_demands[day] += Decimal(str(movement.quantite))
        
        if len(daily_demands) < 2:
            return Decimal('0.1')
        
        # Calculer l'écart-type
        demands = list(daily_demands.values())
        mean = sum(demands) / Decimal(str(len(demands)))
        variance = sum((d - mean) ** 2 for d in demands) / Decimal(str(len(demands) - 1))
        
        return variance.sqrt() if variance > 0 else Decimal('0.1')
    
    def _calculate_lead_time(self, product_id):
        """Calculer le lead time (pour l'instant, utiliser la valeur par défaut)"""
        # TODO: Implémenter calcul basé sur historique fournisseur
        return self.config.default_lead_time
    
    def _apply_conservative_rules(self, avg_daily, sigma_daily):
        """Appliquer les règles conservatrices"""
        # Règle 1: Demande minimale
        min_demand = Decimal('0.1')
        if avg_daily < min_demand:
            avg_daily = min_demand
        
        # Règle 2: Variabilité minimale
        min_sigma = avg_daily * Decimal('0.1')
        if sigma_daily < min_sigma:
            sigma_daily = min_sigma
        
        # Convertir avg_daily en Decimal si nécessaire
        avg_daily_decimal = Decimal(str(avg_daily)) if not isinstance(avg_daily, Decimal) else avg_daily
        
        # Augmenter légèrement la demande moyenne et l'écart-type
        conservative_avg = avg_daily_decimal * Decimal('1.2')
        conservative_sigma = max(sigma_daily * Decimal('1.5'), avg_daily_decimal * Decimal('0.3'))  # Au moins 30% de la moyenne
        
        return conservative_avg, conservative_sigma
    
    def _calculate_safety_stock(self, sigma_daily, lead_time):
        """Calculer le stock de sécurité"""
        if sigma_daily == 0:
            return Decimal('0.0')
        
        z_factor_decimal = Decimal(str(self.config.z_factor))
        lead_time_sqrt = Decimal(str(math.sqrt(lead_time)))
        
        return z_factor_decimal * sigma_daily * lead_time_sqrt
    
    def _calculate_reorder_point(self, avg_daily, lead_time, safety_stock):
        """Calculer le point de commande"""
        return avg_daily * lead_time + safety_stock
    
    def _calculate_forecast(self, movements, avg_daily):
        """Calculer la prévision 30 jours (méthode simple pour MVP)"""
        # Pour le MVP, utiliser la moyenne mobile
        return avg_daily * self.config.forecast_horizon
    
    def _calculate_days_coverage(self, current_stock, avg_daily_demand):
        """Calculer le nombre de jours de couverture du stock actuel"""
        try:
            if avg_daily_demand <= 0:
                # ✅ CORRECTION: Retourner une valeur décimale très élevée au lieu de float('inf')
                return Decimal('999999')  # Représente "infini" en décimal
            
            coverage = current_stock / avg_daily_demand
            return Decimal(str(coverage))
            
        except (ZeroDivisionError, InvalidOperation) as e:
            logger.warning(f"Erreur calcul jours de couverture: {e}")
            return Decimal('999999')  # Valeur très élevée en cas d'erreur
    
    def _determine_status(self, days_coverage, lead_time, current_stock, reorder_point):
        """Déterminer le statut du produit"""
        if (days_coverage <= lead_time or current_stock < reorder_point):
            return 'URGENT'
        elif days_coverage <= lead_time * self.config.monitor_threshold_multiplier:
            return 'A_SURVEILLER'
        else:
            return 'OK'
    
    def _calculate_suggested_quantity(self, predicted_30d, current_stock, safety_stock):
        """Calculer la quantité suggérée"""
        suggested = predicted_30d - current_stock + safety_stock
        return max(suggested, 0)
    
    def _generate_explanation(self, avg_daily, sigma_daily, lead_time, safety_stock, reorder_point):
        """
        Génère une explication détaillée des calculs
        """
        return {
            'formules': {
                'demande_moyenne': f"Moyenne des sorties quotidiennes sur {self.config.window_days} jours",
                'ecart_type': "Écart-type des demandes quotidiennes",
                'stock_securite': f"Z-factor ({float(self.config.z_factor)}) × σ × √(lead_time)",
                'point_commande': "Demande moyenne × Lead time + Stock de sécurité"
            },
            'donnees': {
                'demande_moyenne_jour': float(avg_daily),  # Conversion en float
                'ecart_type_jour': float(sigma_daily),     # Conversion en float
                'lead_time_jours': lead_time,
                'stock_securite': float(safety_stock),     # Conversion en float
                'point_commande': float(reorder_point),    # Conversion en float
                'z_factor': float(self.config.z_factor)    # Conversion en float
            },
            'interpretation': {
                'niveau_service': f"{float(self.config.z_factor * 100):.1f}%",
                'fenetre_analyse': f"{self.config.window_days} jours"
            }
        }

class ReorderActionService:
    """Service pour générer les actions recommandées"""
    
    def get_actions_for_analysis(self, analysis):
        """Générer les actions pour une analyse"""
        actions = []
        
        if analysis.status == 'URGENT':
            # Action principale : créer PO brouillon
            actions.append({
                'type': 'CREATE_DRAFT_PO',
                'priority': 'HIGH',
                'label': 'Créer PO Brouillon',
                'description': f'Commander {analysis.suggested_qty:.0f} unités',
                'data': {
                    'quantity': analysis.suggested_qty,
                    'justification': f'Stock critique: {analysis.days_of_coverage:.1f} jours de couverture (lead time: {analysis.lead_time_days} jours)'
                }
            })
            
            # Action secondaire : vérifier transferts
            actions.append({
                'type': 'CHECK_TRANSFERS',
                'priority': 'MEDIUM',
                'label': 'Vérifier Transferts',
                'description': 'Chercher stock dans autres dépôts'
            })
            
            # Alerte si très critique
            if analysis.days_of_coverage < 1:
                actions.append({
                    'type': 'CRITICAL_ALERT',
                    'priority': 'CRITICAL',
                    'label': 'Alerte Critique',
                    'description': 'Risque de rupture immédiate'
                })
        
        elif analysis.status == 'A_SURVEILLER':
            actions.append({
                'type': 'MONITOR',
                'priority': 'LOW',
                'label': 'Surveiller',
                'description': 'Ajouter au tableau de bord'
            })
            
            actions.append({
                'type': 'CREATE_LOW_PRIORITY_PO',
                'priority': 'LOW',
                'label': 'PO Préventif',
                'description': f'Commander {analysis.suggested_qty * 0.7:.0f} unités (préventif)',
                'data': {
                    'quantity': analysis.suggested_qty * 0.7
                }
            })
        
        return actions
    
    def create_draft_po(self, analysis, user, comment=''):
        """Créer un bon de commande brouillon"""
        justification = (
            f"Recommandation automatique basée sur:\n"
            f"- Stock actuel: {analysis.produit.stock_initial}\n"
            f"- Point de commande: {analysis.reorder_point:.1f}\n"
            f"- Jours de couverture: {analysis.days_of_coverage:.1f}\n"
            f"- Demande moyenne: {analysis.avg_daily_demand:.2f}/jour\n"
            f"- Lead time: {analysis.lead_time_days} jours"
        )
        
        draft_po = DraftPurchaseOrder.objects.create(
            analysis=analysis,
            produit=analysis.produit,
            suggested_quantity=analysis.suggested_qty,
            justification=justification,
            user_comment=comment,
            created_by=user
        )
        
        return draft_po


class ReorderCalculationServiceCompatible:
    """
    Service de calcul de réapprovisionnement adapté aux modèles existants
    """
    
    def __init__(self, window_days=90, z_factor=1.65):
        self.window_days = window_days
        self.z_factor = z_factor  # 95% de niveau de service
    
    def calculate_reorder_analysis(self, produit_id, depot=None):
        """
        Calcule l'analyse de réapprovisionnement pour un produit
        """
        try:
            produit = Produit.objects.get(id=produit_id)
            
            # Récupérer l'historique des mouvements
            end_date = timezone.now()
            start_date = end_date - timedelta(days=self.window_days)
            
            # Filtrer les mouvements de sortie dans la période
            mouvements = Mouvement.objects.filter(  # Utiliser Mouvement au lieu de MouvementStock
            produit_id=product_id,
            date__date__range=[start_date, end_date],  # Utiliser date__date__range au lieu de date_mouvement
            mouvement='Sortie'
            ).order_by('date')
            
            # Évaluer la confiance des données
            confidence = self._assess_data_confidence(movements)
            
            # Nettoyer les mouvements
            clean_movements = self._clean_movements(movements)
            
            # ✅ VALIDATION AJOUTÉE
            if not clean_movements:
                logger.warning(f"Aucun mouvement valide après nettoyage pour {produit.code}")
                return None
            
            # Calculer les métriques de base
            avg_daily = self._calculate_avg_daily_demand(clean_movements)
            sigma_daily = self._calculate_sigma_daily_demand(clean_movements)
            
            # ✅ VALIDATION AJOUTÉE
            if avg_daily <= 0:
                logger.warning(f"Demande journalière moyenne invalide pour {produit.code}: {avg_daily}")
                avg_daily = 0.01  # Valeur minimale pour éviter division par zéro
            lead_time = self._calculate_lead_time(produit)
            
            # Appliquer règles conservatrices si faible confiance
            if confidence['level'] == 'LOW':  # ✅ CORRECTION: confidence au lieu de confidence_info
                avg_daily, sigma_daily = self._apply_conservative_rules(avg_daily, sigma_daily)
            
            # Calculer le stock de sécurité et point de commande
            safety_stock = self._calculate_safety_stock(sigma_daily, lead_time)
            reorder_point = self._calculate_reorder_point(avg_daily, lead_time, safety_stock)
            
            # Calculer la prévision
            forecast_7_days = self._calculate_forecast(avg_daily, 7)
            forecast_30_days = self._calculate_forecast(avg_daily, 30)
            
            # Calculer les jours de couverture
            days_coverage = self._calculate_days_coverage(produit.stock_initial, avg_daily)
            
            # Déterminer le statut
            status = self._determine_status(produit.stock_initial, reorder_point, safety_stock)
            
            # Calculer la quantité suggérée
            suggested_quantity = self._calculate_suggested_quantity(
                produit, reorder_point, avg_daily_demand, lead_time
            )
            
            # Générer l'explication
            explanation = self._generate_explanation(
                avg_daily_demand, sigma_daily_demand, lead_time, 
                safety_stock, reorder_point, confidence_level
            )
            
            # Créer ou mettre à jour l'analyse
            analysis, created = ReorderAnalysis.objects.update_or_create(
                produit=produit,
                defaults={
                    'avg_daily_demand': avg_daily_demand,
                    'sigma_daily_demand': sigma_daily_demand,
                    'lead_time': lead_time,
                    'safety_stock': safety_stock,
                    'reorder_point': reorder_point,
                    'forecast_7_days': forecast_7_days,
                    'forecast_30_days': forecast_30_days,
                    'days_coverage': days_coverage,
                    'suggested_quantity': suggested_quantity,
                    'status': status,
                    'confidence_level': confidence_level,
                    'confidence_reason': confidence_reason,
                    'window_days_used': self.window_days,
                    'z_factor_used': self.z_factor,
                    'movements_count': len(clean_movements),
                    'explanation': explanation
                }
            )
            
            return analysis
            
        except Produit.DoesNotExist:
            logger.error(f"Produit {produit_id} non trouvé")
            return None
        except Exception as e:
            logger.error(f"Erreur lors du calcul pour le produit {produit_id}: {str(e)}")
            return None
    
    def _assess_data_confidence(self, mouvements):
        """
        Évalue la confiance des données basée sur la quantité et régularité
        """
        count = len(mouvements)
        
        if count < 5:
            return 'LOW', f"Seulement {count} mouvements dans la période"
        elif count < 15:
            return 'MEDIUM', f"{count} mouvements disponibles"
        else:
            # Vérifier la régularité
            if count >= 30:
                return 'HIGH', f"{count} mouvements avec bonne régularité"
            else:
                return 'MEDIUM', f"{count} mouvements disponibles"
    
    def _clean_movements(self, mouvements):
        """
        Nettoie les mouvements en supprimant les valeurs aberrantes
        """
        if len(mouvements) < 3:
            return mouvements
        
        # Convertir en liste de quantités pour les sorties
        quantities = []
        for mouvement in mouvements:
            if mouvement.mouvement == 'Sortie':
                quantities.append(mouvement.quantite)
        
        if len(quantities) < 3:
            return mouvements
        
        # Calculer les quartiles pour détecter les outliers
        q1 = np.percentile(quantities, 25)
        q3 = np.percentile(quantities, 75)
        iqr = q3 - q1
        lower_bound = q1 - 1.5 * iqr
        upper_bound = q3 + 1.5 * iqr
        
        # Filtrer les mouvements
        clean_movements = []
        for mouvement in mouvements:
            if mouvement.mouvement == 'Sortie':
                if lower_bound <= mouvement.quantite <= upper_bound:
                    clean_movements.append(mouvement)
            else:
                clean_movements.append(mouvement)
        
        return clean_movements
    
    def _calculate_avg_daily_demand(self, mouvements):
        """
        Calcule la demande quotidienne moyenne basée sur les sorties
        """
        if not mouvements:
            return Decimal('0')
        
        # Regrouper les sorties par jour
        daily_demands = {}
        for mouvement in mouvements:
            if mouvement.mouvement == 'Sortie':
                date_key = mouvement.date.date()
                if date_key not in daily_demands:
                    daily_demands[date_key] = 0
                daily_demands[date_key] += mouvement.quantite
        
        if not daily_demands:
            return Decimal('0')
        
        total_demand = sum(daily_demands.values())
        days_with_demand = len(daily_demands)
        
        return Decimal(str(total_demand / days_with_demand))
    
    def _calculate_sigma_daily_demand(self, mouvements, avg_daily_demand):
        """
        Calcule l'écart-type de la demande quotidienne
        """
        if not mouvements:
            return Decimal('0')
        
        # Regrouper les sorties par jour
        daily_demands = {}
        for mouvement in mouvements:
            if mouvement.mouvement == 'Sortie':
                date_key = mouvement.date.date()
                if date_key not in daily_demands:
                    daily_demands[date_key] = 0
                daily_demands[date_key] += mouvement.quantite
        
        if len(daily_demands) < 2:
            return avg_daily_demand * Decimal('0.3')  # 30% de la moyenne par défaut
        
        demands = list(daily_demands.values())
        variance = np.var(demands, ddof=1)
        
        return Decimal(str(np.sqrt(variance)))
    
    def _get_lead_time(self, produit):
        """
        Récupère le délai de livraison du produit
        """
        return getattr(produit, 'lead_time', 7)  # 7 jours par défaut
    
    def _apply_conservative_rules(self, avg_daily_demand, sigma_daily_demand, confidence_level):
        """
        Applique des règles conservatrices selon le niveau de confiance
        """
        if confidence_level == 'LOW':
            # Augmenter la demande de 20% et l'écart-type de 50%
            avg_daily_demand *= Decimal('1.2')
            sigma_daily_demand *= Decimal('1.5')
        elif confidence_level == 'MEDIUM':
            # Augmenter légèrement
            avg_daily_demand *= Decimal('1.1')
            sigma_daily_demand *= Decimal('1.2')
        
        return avg_daily_demand, sigma_daily_demand
    
    def _calculate_safety_stock(self, avg_daily_demand, lead_time):
        """
        Calcule le stock de sécurité
        """
        return avg_daily_demand * Decimal(str(np.sqrt(lead_time))) * Decimal(str(self.z_factor))
    
    def _calculate_reorder_point(self, avg_daily_demand, lead_time, safety_stock):
        """
        Calcule le point de commande
        """
        return (avg_daily_demand * Decimal(str(lead_time))) + safety_stock
    
    def _calculate_forecast(self, avg_daily_demand, days):
        """
        Calcule la prévision pour un nombre de jours donné
        """
        return avg_daily_demand * Decimal(str(days))
    
    def _calculate_days_coverage(self, current_stock, avg_daily_demand):
        """
        Calcule le nombre de jours de couverture
        """
        if avg_daily_demand <= 0:
            return 999  # Stock suffisant indéfiniment
        
        return int(current_stock / float(avg_daily_demand))
    
    def _determine_status(self, current_stock, reorder_point, safety_stock):
        """
        Détermine le statut du stock
        """
        if current_stock <= safety_stock:
            return 'CRITICAL'
        elif current_stock <= reorder_point:
            return 'REORDER'
        else:
            return 'OK'
    
    def _calculate_suggested_quantity(self, produit, reorder_point, avg_daily_demand, lead_time):
        """
        Calcule la quantité suggérée à commander
        """
        if produit.stock_initial >= reorder_point:
            return Decimal('0')
        
        # Quantité pour atteindre le point de commande + stock pour la période de commande
        shortage = reorder_point - produit.stock_initial
        order_period_demand = avg_daily_demand * Decimal(str(lead_time))
        
        return shortage + order_period_demand
    
    def _generate_explanation(self, avg_daily_demand, sigma_daily_demand, lead_time, 
                            safety_stock, reorder_point, confidence_level):
        """
        Génère une explication détaillée des calculs
        """
        return {
            'avg_daily_demand': f"Demande quotidienne moyenne: {avg_daily_demand}",
            'sigma_daily_demand': f"Écart-type de la demande: {sigma_daily_demand}",
            'lead_time': f"Délai de livraison: {lead_time} jours",
            'safety_stock': f"Stock de sécurité: {safety_stock}",
            'reorder_point': f"Point de commande: {reorder_point}",
            'confidence': f"Niveau de confiance: {confidence_level}",
            'z_factor': f"Facteur Z (niveau de service): {self.z_factor}"
        }