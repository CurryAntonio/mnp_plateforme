import os
import subprocess
import shutil
from datetime import datetime
from django.conf import settings
from django.core.mail import send_mail
import logging

logger = logging.getLogger(__name__)

def find_pg_dump():
    """Trouve le chemin vers pg_dump sur Windows"""
    # Chemins pour PostgreSQL 17
    possible_paths = [
        r"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe",
        r"C:\Program Files (x86)\PostgreSQL\17\bin\pg_dump.exe",
        # Autres versions au cas où
        r"C:\Program Files\PostgreSQL\16\bin\pg_dump.exe",
        r"C:\Program Files\PostgreSQL\15\bin\pg_dump.exe",
    ]
    
    # Vérifier si pg_dump est dans le PATH
    if shutil.which("pg_dump"):
        return "pg_dump"
    
    # Vérifier les chemins courants
    for path in possible_paths:
        if os.path.exists(path):
            return path
    
    return None

def backup_database():
    """Sauvegarde la base de données PostgreSQL avec gestion d'erreurs améliorée"""
    date = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file = os.path.join(settings.BACKUP_DIR, f"backup_{date}.sql")
    
    try:
        # Vérifier que le répertoire existe
        os.makedirs(settings.BACKUP_DIR, exist_ok=True)
        
        # Trouver pg_dump sur Windows
        pg_dump_path = find_pg_dump()
        if not pg_dump_path:
            raise Exception(
                "PostgreSQL n'est pas installé ou pg_dump est introuvable. "
                "Vérifiez que C:\\Program Files\\PostgreSQL\\17\\bin est dans votre PATH."
            )
        
        # Utiliser les variables d'environnement pour PostgreSQL
        env = os.environ.copy()
        env['PGPASSWORD'] = settings.DB_BACKUP_CONFIG['password']
        
        cmd = [
            pg_dump_path,
            "-U", settings.DB_BACKUP_CONFIG['user'],
            "-h", settings.DB_BACKUP_CONFIG['host'],
            "-p", str(settings.DB_BACKUP_CONFIG['port']),
            "--no-password",
            "--verbose",
            "--clean",
            "--if-exists",
            settings.DB_BACKUP_CONFIG['database']
        ]
        
        logger.info(f"Démarrage de la sauvegarde: {backup_file}")
        logger.info(f"Utilisation de pg_dump: {pg_dump_path}")
        
        with open(backup_file, "w", encoding='utf-8') as f:
            result = subprocess.run(cmd, stdout=f, stderr=subprocess.PIPE, 
                                  env=env, check=True, text=True)
        
        # Vérifier la taille du fichier
        file_size = os.path.getsize(backup_file)
        if file_size < 1024:  # Moins de 1KB, probablement une erreur
            logger.error(f"Fichier de sauvegarde trop petit: {file_size} bytes")
            if os.path.exists(backup_file):
                os.remove(backup_file)
            raise Exception(f"Fichier de sauvegarde trop petit: {file_size} bytes")
        
        message = f"Sauvegarde réussie : {backup_file} ({file_size} bytes)"
        logger.info(message)
        
        # Nettoyer les anciennes sauvegardes (garder les 10 dernières)
        cleanup_old_backups()
        
        return message
        
    except subprocess.CalledProcessError as e:
        error_msg = f"Erreur pg_dump: {e.stderr if e.stderr else str(e)}"
        logger.error(error_msg)
        if os.path.exists(backup_file):
            os.remove(backup_file)
        raise Exception(error_msg)
    except Exception as e:
        error_msg = f"Erreur lors de la sauvegarde: {str(e)}"
        logger.error(error_msg)
        if os.path.exists(backup_file):
            os.remove(backup_file)
        raise Exception(error_msg)

def restore_database(backup_file):
    """Restaure la base de données à partir d'un fichier SQL"""
    try:
        if not os.path.exists(backup_file):
            raise FileNotFoundError(f"Fichier de sauvegarde introuvable: {backup_file}")
        
        env = os.environ.copy()
        env['PGPASSWORD'] = settings.DB_BACKUP_CONFIG['password']
        
        cmd = [
            "psql",
            "-U", settings.DB_BACKUP_CONFIG['user'],
            "-h", settings.DB_BACKUP_CONFIG['host'],
            "-p", settings.DB_BACKUP_CONFIG['port'],
            "--no-password",
            settings.DB_BACKUP_CONFIG['database']
        ]
        
        with open(backup_file, "r", encoding='utf-8') as f:
            result = subprocess.run(cmd, stdin=f, stderr=subprocess.PIPE,
                                  env=env, check=True, text=True)
        
        message = f"Restauration réussie depuis {backup_file}"
        logger.info(message)
        return message
        
    except subprocess.CalledProcessError as e:
        error_msg = f"Erreur psql : {e.stderr}"
        logger.error(error_msg)
        return error_msg
    except Exception as e:
        error_msg = f"Erreur de restauration : {str(e)}"
        logger.error(error_msg)
        return error_msg

def cleanup_old_backups(keep_count=10):
    """Supprime les anciennes sauvegardes, garde les plus récentes"""
    try:
        backup_files = []
        for filename in os.listdir(settings.BACKUP_DIR):
            if filename.startswith('backup_') and filename.endswith('.sql'):
                filepath = os.path.join(settings.BACKUP_DIR, filename)
                backup_files.append((filepath, os.path.getctime(filepath)))
        
        # Trier par date de création (plus récent en premier)
        backup_files.sort(key=lambda x: x[1], reverse=True)
        
        # Supprimer les fichiers en excès
        for filepath, _ in backup_files[keep_count:]:
            os.remove(filepath)
            logger.info(f"Ancienne sauvegarde supprimée: {filepath}")
            
    except Exception as e:
        logger.error(f"Erreur lors du nettoyage: {str(e)}")

def scheduled_backup():
    """Tâche de sauvegarde programmée"""
    result = backup_database()
    
    # Envoyer un email de notification (optionnel)
    try:
        send_mail(
            'Sauvegarde automatique - Plateforme MNP',
            f'Résultat de la sauvegarde automatique:\n\n{result}',
            settings.DEFAULT_FROM_EMAIL,
            ['aromain310@gmail.com'],  # Remplacer par l'email admin
            fail_silently=True,
        )
    except Exception as e:
        logger.error(f"Erreur envoi email: {str(e)}")
    
    return result