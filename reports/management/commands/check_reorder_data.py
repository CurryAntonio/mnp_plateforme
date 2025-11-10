from django.core.management.base import BaseCommand
from django.utils import timezone
from datetime import timedelta
from products.models import Produit
from journal.models import Mouvement
from reports.models import ReorderAnalysis, ReorderMonitoring
from django_q.models import Schedule, Task

class Command(BaseCommand):
    help = 'Vérifie les données nécessaires pour les calculs de recommandations'
    
    def handle(self, *args, **options):
        self.stdout.write("=== VÉRIFICATION DES DONNÉES POUR RECOMMANDATIONS ===")
        
        # 1. Vérifier les produits
        produits_count = Produit.objects.count()
        self.stdout.write(f"Produits: {produits_count}")
        
        if produits_count == 0:
            self.stdout.write(self.style.ERROR("AUCUN PRODUIT TROUVÉ!"))
            return
        
        # 2. Vérifier les mouvements
        end_date = timezone.now()
        start_date = end_date - timedelta(days=90)
        
        mouvements_count = Mouvement.objects.filter(
            mouvement='Sortie',
            date__gte=start_date
        ).count()
        
        self.stdout.write(f"Mouvements de sortie (90 derniers jours): {mouvements_count}")
        
        if mouvements_count < 10:
            self.stdout.write(self.style.WARNING(
                "ATTENTION: Moins de 10 mouvements de sortie dans les 90 derniers jours!"
            ))
        
        # 3. Vérifier les tâches planifiées
        scheduled_tasks = Schedule.objects.filter(
            name__in=['daily_reorder_calculation', 'weekly_cleanup', 'hourly_critical_alerts']
        )
        
        self.stdout.write(f"Tâches planifiées: {scheduled_tasks.count()}/3")
        
        for task in scheduled_tasks:
            self.stdout.write(f"  - {task.name}: {task.next_run}")
        
        # 4. Vérifier les analyses existantes
        analyses_count = ReorderAnalysis.objects.count()
        self.stdout.write(f"Analyses existantes: {analyses_count}")
        
        # 5. Vérifier les tâches en erreur
        failed_tasks = Task.objects.filter(
            success=False,
            func='reports.tasks.daily_reorder_calculation'
        ).order_by('-started')[:5]
        
        if failed_tasks.exists():
            self.stdout.write(self.style.ERROR("TÂCHES EN ERREUR:"))
            for task in failed_tasks:
                self.stdout.write(f"  - {task.started}: {task.result}")
        
        self.stdout.write("=== FIN VÉRIFICATION ===")