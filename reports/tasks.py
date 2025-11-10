from django_q.tasks import async_task, schedule
from django_q.models import Schedule
from django.utils import timezone
from django.db import transaction
from datetime import timedelta, time
import time as time_module
import logging
from products.models import Produit
from .models import ReorderAnalysis, ReorderMonitoring, ReorderConfiguration
from .services import ReorderCalculationService

logger = logging.getLogger(__name__)    
def daily_reorder_calculation(depot='Principal', **kwargs):
    """Calcul quotidien des points de commande avec gestion robuste des paramètres"""
    # Correction pour gérer le double encapsulage Django-Q
    if 'kwargs' in kwargs:
        inner_kwargs = kwargs['kwargs']
        depot = inner_kwargs.get('depot', depot)
    else:
        depot = kwargs.get('depot', depot)
    
    start_time = time_module.time()
    calculation_date = timezone.now().date()
    
    logger.info(f"Début du calcul quotidien des points de commande pour {depot}")
    
    try:
        # Vérifier la configuration avant de commencer
        config = ReorderConfiguration.objects.filter(is_active=True).first()
        if not config:
            logger.error("Configuration de réapprovisionnement manquante")
            return {'success': False, 'error': 'Configuration manquante'}
        
        # Initialiser le service de calcul
        calculation_service = ReorderCalculationService(config)
        
        # Récupérer tous les produits actifs
        produits = Produit.objects.filter().select_related('groupe')
        
        total_products = produits.count()
        logger.info(f"Traitement de {total_products} produits")
        
        if total_products == 0:
            logger.warning("Aucun produit trouvé pour le calcul")
            return {'success': False, 'error': 'Aucun produit trouvé'}
        
        # Compteurs pour le monitoring
        success_count = 0
        error_count = 0
        urgent_count = 0
        watch_count = 0
        ok_count = 0
        low_confidence_count = 0
        
        # ✅ AMÉLIORATION - Traitement par lots pour éviter les timeouts
        batch_size = 50
        for i in range(0, total_products, batch_size):
            batch_products = produits[i:i + batch_size]
            
            for produit in batch_products:
                try:
                    # Calculer l'analyse pour ce produit
                    analysis = calculation_service.calculate_for_product(produit.id)
                    
                    if analysis:
                        success_count += 1
                        
                        # Compter par statut
                        if analysis.status == 'URGENT':
                            urgent_count += 1
                        elif analysis.status == 'A_SURVEILLER':
                            watch_count += 1
                        else:
                            ok_count += 1
                        
                        # Compter les faibles confiances
                        if analysis.confidence_level == 'LOW':
                            low_confidence_count += 1
                            
                        logger.debug(f"Analyse calculée pour {produit.code}: {analysis.status}")
                    else:
                        error_count += 1
                        logger.warning(f"Échec du calcul pour {produit.code}")
                        
                except Exception as e:
                    error_count += 1
                    logger.error(f"Erreur calcul pour produit {produit.id}: {str(e)}")
                    logger.error(f"Erreur calcul produit {produit.code}: {str(e)}")
                    continue
            
            # ✅ AMÉLIORATION - Log de progression
            logger.info(f"Traité {min(i + batch_size, total_products)}/{total_products} produits")
        
        # Calculer le temps d'exécution
        execution_time = time_module.time() - start_time
        
        # Enregistrer les métriques de monitoring
        with transaction.atomic():
            monitoring, created = ReorderMonitoring.objects.update_or_create(
                date=calculation_date,
                defaults={
                    'urgent_count': urgent_count,
                    'monitor_count': watch_count,
                    'ok_count': ok_count,
                    'low_confidence_count': low_confidence_count,
                    'batch_execution_time': float(execution_time),  # ✅ Conversion ajoutée
                    'batch_success': error_count == 0,
                    'total_suggested_units': 0,
                    'draft_orders_created': 0,
                    'draft_orders_approved': 0,
                    'average_confidence': 0
                }
            )
        
        logger.info(f"Calcul terminé: {success_count} succès, {error_count} erreurs en {execution_time:.2f}s")
        
        # ✅ CORRECTION : S'assurer que tous les types sont JSON-compatibles
        return {
            'success': True,
            'success_count': int(success_count),
            'error_count': int(error_count),
            'execution_time': float(execution_time),
            'urgent_count': int(urgent_count),
            'watch_count': int(watch_count),
            'ok_count': int(ok_count)
        }
        
    except Exception as e:
        logger.exception(f"Erreur générale dans daily_reorder_calculation: {str(e)}")
        return {'success': False, 'error': str(e)}

def cleanup_old_analyses(days_to_keep=90, **kwargs):
    """Nettoyer les anciennes analyses pour éviter l'accumulation"""
    # CORRECTION COMPLÈTE pour gérer le double encapsulage Django-Q
    if 'kwargs' in kwargs:
        # Django-Q passe {'kwargs': {'days_to_keep': 90}}
        inner_kwargs = kwargs['kwargs']
        days_to_keep = inner_kwargs.get('days_to_keep', days_to_keep)
    else:
        # Appel direct ou manuel
        days_to_keep = kwargs.get('days_to_keep', days_to_keep)
    
    cutoff_date = timezone.now().date() - timedelta(days=days_to_keep)
    
    deleted_count = ReorderAnalysis.objects.filter(
        calculation_date__date__lt=cutoff_date
    ).delete()[0]
    
    logger.info(f"Nettoyage: {deleted_count} anciennes analyses supprimées")
    
    return {
        'success': True,
        'deleted_count': deleted_count,
        'cutoff_date': cutoff_date
    }

def generate_critical_alerts(**kwargs):
    """Générer des alertes pour les produits critiques"""
    try:
        # Récupérer les produits urgents avec très faible couverture
        critical_analyses = ReorderAnalysis.objects.filter(
            status='URGENT',
            days_of_coverage__lt=1,  # Moins d'un jour de couverture
            calculation_date__date=timezone.now().date()
        ).select_related('produit')
        
        if not critical_analyses.exists():
            return {'success': True, 'critical_count': 0}
        
        # TODO: Implémenter l'envoi d'alertes (email, Slack, etc.)
        # Pour l'instant, juste logger
        for analysis in critical_analyses:
            logger.warning(
                f"ALERTE CRITIQUE: {analysis.produit.nom} "
                f"(Stock: {analysis.produit.stock_initial}, "
                f"Couverture: {analysis.days_of_coverage:.1f} jours)"
            )
        
        return {
            'success': True,
            'critical_count': critical_analyses.count(),
            'critical_products': [
                {
                    'produit_id': a.produit.id,
                    'nom': a.produit.nom,
                    'stock': a.produit.stock_initial,
                    'days_coverage': float(a.days_of_coverage)
                }
                for a in critical_analyses
            ]
        }
        
    except Exception as e:
        logger.error(f"Erreur génération alertes critiques: {str(e)}")
        return {'success': False, 'error': str(e)}

# NOUVELLES FONCTIONS POUR DJANGO-Q
def setup_scheduled_tasks():
    """Configure toutes les tâches planifiées"""
    # Supprimer les anciennes planifications
    Schedule.objects.filter(name__in=[
        'daily_reorder_calculation',
        'weekly_cleanup',
        'hourly_critical_alerts'
    ]).delete()
    
    # CORRECTION: Passer les arguments dans kwargs explicitement
    schedule(
        'reports.tasks.daily_reorder_calculation',
        name='daily_reorder_calculation',
        schedule_type=Schedule.DAILY,
        next_run=timezone.now().replace(hour=2, minute=0, second=0, microsecond=0),
        kwargs={'depot': 'Principal'}  # Utiliser kwargs explicitement
    )
    
    schedule(
        'reports.tasks.cleanup_old_analyses',
        name='weekly_cleanup',
        schedule_type=Schedule.WEEKLY,
        next_run=timezone.now().replace(hour=3, minute=0, second=0, microsecond=0),
        kwargs={'days_to_keep': 90}  # Utiliser kwargs explicitement
    )
    
    # Alertes critiques toutes les heures
    schedule(
        'reports.tasks.generate_critical_alerts',
        name='hourly_critical_alerts',
        schedule_type=Schedule.HOURLY,
        next_run=timezone.now().replace(minute=0, second=0, microsecond=0)
    )
    
    logger.info("Tâches planifiées configurées avec succès")

def trigger_manual_calculation(depot='Principal'):
    """Déclenche un calcul manuel"""
    task_id = async_task(
        'reports.tasks.daily_reorder_calculation',
        depot,
        task_name='manual_reorder_calculation'
    )
    return task_id

def trigger_manual_cleanup(days_to_keep=90):
    """Déclenche manuellement le nettoyage des anciennes analyses"""
    return async_task('reports.tasks.cleanup_old_analyses', days_to_keep=days_to_keep)
