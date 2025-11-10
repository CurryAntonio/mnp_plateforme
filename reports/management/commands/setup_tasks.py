from django.core.management.base import BaseCommand
from reports.tasks import setup_scheduled_tasks

class Command(BaseCommand):
    help = 'Configure les tâches planifiées Django-Q'
    
    def handle(self, *args, **options):
        try:
            setup_scheduled_tasks()
            self.stdout.write(
                self.style.SUCCESS('Tâches planifiées configurées avec succès!')
            )
        except Exception as e:
            self.stdout.write(
                self.style.ERROR(f'Erreur lors de la configuration: {str(e)}')
            )