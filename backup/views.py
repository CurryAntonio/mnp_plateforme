import os
from django.http import JsonResponse
from django.conf import settings
from django.views.decorators.http import require_http_methods
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
from django_q.tasks import async_task, result
from django_q.models import Task
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from .tasks import backup_database, restore_database
from .permissions import CanManageBackups
import json
from datetime import datetime
import logging

logger = logging.getLogger(__name__)

@api_view(['POST'])
@permission_classes([IsAuthenticated, CanManageBackups])
def sauvegarde_view(request):
    """Lancer une sauvegarde asynchrone - Accessible aux responsables"""
    try:
        # Log de l'action pour traçabilité
        logger.info(f"Sauvegarde initiée par {request.user.email} ({request.user.nom} {request.user.prenom})")
        
        task_id = async_task('backup.tasks.backup_database')
        return Response({
            "status": "success",
            "message": "Sauvegarde en cours...",
            "task_id": task_id,
            "initiated_by": f"{request.user.prenom} {request.user.nom}" if request.user.prenom else request.user.email
        }, status=status.HTTP_202_ACCEPTED)
    except Exception as e:
        logger.error(f"Erreur lors du lancement de la sauvegarde par {request.user.email}: {str(e)}")
        return Response({
            "status": "error",
            "message": f"Erreur lors du lancement de la sauvegarde: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['POST'])
@permission_classes([IsAuthenticated, CanManageBackups])
def restauration_view(request):
    """Restaure la base à partir du dernier fichier ou d'un fichier spécifique - Accessible aux responsables"""
    try:
        backup_filename = request.data.get('backup_file')
        
        # Log de l'action pour traçabilité
        logger.warning(f"Restauration initiée par {request.user.email} ({request.user.nom} {request.user.prenom}) - Fichier: {backup_filename or 'dernier fichier'}")
        
        if backup_filename:
            backup_file = os.path.join(settings.BACKUP_DIR, backup_filename)
            if not os.path.exists(backup_file):
                return Response({
                    "status": "error",
                    "message": "Fichier de sauvegarde introuvable"
                }, status=status.HTTP_404_NOT_FOUND)
        else:
            # Utiliser le dernier fichier de sauvegarde
            try:
                fichiers = [f for f in os.listdir(settings.BACKUP_DIR) 
                           if f.startswith('backup_') and f.endswith('.sql')]
                if not fichiers:
                    return Response({
                        "status": "error",
                        "message": "Aucune sauvegarde trouvée"
                    }, status=status.HTTP_404_NOT_FOUND)
                
                fichiers.sort()
                backup_file = os.path.join(settings.BACKUP_DIR, fichiers[-1])
            except Exception as e:
                return Response({
                    "status": "error",
                    "message": f"Erreur lors de la recherche des sauvegardes: {str(e)}"
                }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        task_id = async_task('backup.tasks.restore_database', backup_file)
        return Response({
            "status": "success",
            "message": f"Restauration en cours depuis {os.path.basename(backup_file)}",
            "task_id": task_id,
            "initiated_by": f"{request.user.prenom} {request.user.nom}" if request.user.prenom else request.user.email
        }, status=status.HTTP_202_ACCEPTED)
        
    except Exception as e:
        logger.error(f"Erreur lors du lancement de la restauration par {request.user.email}: {str(e)}")
        return Response({
            "status": "error",
            "message": f"Erreur lors du lancement de la restauration: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticated, CanManageBackups])
def liste_sauvegardes_view(request):
    """Liste toutes les sauvegardes disponibles - Accessible aux responsables"""
    try:
        # ✅ CORRECTION: Vérifier que le répertoire existe
        if not os.path.exists(settings.BACKUP_DIR):
            logger.warning(f"Répertoire de sauvegarde inexistant: {settings.BACKUP_DIR}")
            os.makedirs(settings.BACKUP_DIR, exist_ok=True)
            return Response({
                "status": "success",
                "sauvegardes": [],
                "total_count": 0,
                "message": "Répertoire de sauvegarde créé"
            })
        
        sauvegardes = []
        for filename in os.listdir(settings.BACKUP_DIR):
            if filename.startswith('backup_') and filename.endswith('.sql'):
                filepath = os.path.join(settings.BACKUP_DIR, filename)
                try:
                    stat = os.stat(filepath)
                    sauvegardes.append({
                        'filename': filename,
                        'size': stat.st_size,
                        'size_mb': round(stat.st_size / (1024 * 1024), 2),
                        'size_formatted': f"{round(stat.st_size / (1024 * 1024), 2)} MB" if stat.st_size > 1024*1024 else f"{round(stat.st_size / 1024, 2)} KB",
                        'created_at': datetime.fromtimestamp(stat.st_ctime).isoformat(),
                        'modified_at': datetime.fromtimestamp(stat.st_mtime).isoformat(),
                        'created_at_formatted': datetime.fromtimestamp(stat.st_ctime).strftime('%d/%m/%Y %H:%M:%S')
                    })
                except OSError as e:
                    logger.warning(f"Erreur lors de la lecture du fichier {filename}: {e}")
                    continue
        
        # Trier par date de création (plus récent en premier)
        sauvegardes.sort(key=lambda x: x['created_at'], reverse=True)
        
        logger.info(f"Liste des sauvegardes récupérée: {len(sauvegardes)} fichiers trouvés")
        
        return Response({
            "status": "success",
            "sauvegardes": sauvegardes,
            "total_count": len(sauvegardes),
            "backup_directory": settings.BACKUP_DIR
        })
        
    except Exception as e:
        logger.error(f"Erreur lors de la récupération des sauvegardes: {str(e)}")
        return Response({
            "status": "error",
            "message": f"Erreur lors de la récupération des sauvegardes: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticated, CanManageBackups])
def statut_tache_view(request, task_id):
    """Vérifie le statut d'une tâche - Accessible aux responsables"""
    try:
        task = Task.objects.get(id=task_id)
        return Response({
            "status": "success",
            "task_status": task.success,
            "result": task.result if task.success is not None else "En cours...",
            "started": task.started.isoformat() if task.started else None,
            "stopped": task.stopped.isoformat() if task.stopped else None
        })
    except Task.DoesNotExist:
        # Tâche pas encore créée ou en attente dans la file
        task_result = result(task_id)
        return Response({
            "status": "pending" if task_result is None else "success",
            "task_status": None if task_result is None else True,
            "result": "En cours..." if task_result is None else task_result,
            "started": None,
            "stopped": None
        }, status=status.HTTP_200_OK)
    except Exception as e:
        return Response({
            "status": "error",
            "message": f"Erreur lors de la vérification du statut: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['DELETE'])
@permission_classes([IsAuthenticated, CanManageBackups])
def supprimer_sauvegarde_view(request, filename):
    """Supprime une sauvegarde spécifique - Accessible aux responsables"""
    try:
        # Vérification de sécurité pour éviter la suppression de fichiers système
        if not filename.startswith('backup_') or not filename.endswith('.sql'):
            return Response({
                "status": "error",
                "message": "Nom de fichier invalide"
            }, status=status.HTTP_400_BAD_REQUEST)
        
        filepath = os.path.join(settings.BACKUP_DIR, filename)
        
        if not os.path.exists(filepath):
            return Response({
                "status": "error",
                "message": "Fichier de sauvegarde introuvable"
            }, status=status.HTTP_404_NOT_FOUND)
        
        os.remove(filepath)
        logger.info(f"Sauvegarde supprimée par {request.user.email}: {filename}")
        
        return Response({
            "status": "success",
            "message": f"Sauvegarde {filename} supprimée avec succès"
        })
        
    except Exception as e:
        logger.error(f"Erreur lors de la suppression de la sauvegarde {filename}: {str(e)}")
        return Response({
            "status": "error",
            "message": f"Erreur lors de la suppression: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticated, CanManageBackups])
def informations_stockage_view(request):
    """Retourne les informations de stockage des sauvegardes"""
    try:
        logger.info(f"Demande d'informations de stockage par {request.user.email}")
        
        if not os.path.exists(settings.BACKUP_DIR):
            logger.warning(f"Répertoire de sauvegarde inexistant: {settings.BACKUP_DIR}")
            os.makedirs(settings.BACKUP_DIR, exist_ok=True)
            return Response({
                "status": "success",
                "usedSpace": "0 MB",
                "lastBackup": None,
                "totalFiles": 0
            })
        
        total_size = 0
        last_backup = None
        file_count = 0
        
        for filename in os.listdir(settings.BACKUP_DIR):
            if filename.startswith('backup_') and filename.endswith('.sql'):
                filepath = os.path.join(settings.BACKUP_DIR, filename)
                try:
                    stat = os.stat(filepath)
                    total_size += stat.st_size
                    file_count += 1
                    
                    # Trouver la dernière sauvegarde
                    if last_backup is None or stat.st_mtime > last_backup['timestamp']:
                        last_backup = {
                            'filename': filename,
                            'timestamp': stat.st_mtime,
                            'date': datetime.fromtimestamp(stat.st_mtime).isoformat()  # Format ISO pour JavaScript
                        }
                except OSError as e:
                    logger.error(f"Erreur lors de la lecture du fichier {filename}: {e}")
                    continue
        
        # Formater la taille
        if total_size > 1024 * 1024 * 1024:  # GB
            used_space = f"{round(total_size / (1024 * 1024 * 1024), 2)} GB"
        elif total_size > 1024 * 1024:  # MB
            used_space = f"{round(total_size / (1024 * 1024), 2)} MB"
        else:  # KB
            used_space = f"{round(total_size / 1024, 2)} KB"
        
        result = {
            "status": "success",
            "usedSpace": used_space,
            "lastBackup": last_backup['date'] if last_backup else None,  # Retourner la date ISO
            "totalFiles": file_count,
            "totalSizeBytes": total_size
        }
        
        logger.info(f"Résultat final: {result}")
        return Response(result)
        
    except Exception as e:
        logger.error(f"Erreur lors de la récupération des informations de stockage: {str(e)}")
        return Response({
            "status": "error",
            "message": f"Erreur lors de la récupération des informations de stockage: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET'])
@permission_classes([IsAuthenticated, CanManageBackups])
def parametres_sauvegarde_view(request):
    """Retourne les paramètres de configuration des sauvegardes"""
    try:
        return Response({
            "status": "success",
            "parametres": {
                "backup_directory": settings.BACKUP_DIR,
                "database_name": settings.DB_BACKUP_CONFIG['database'],
                "user_permissions": {
                    "can_backup": True,
                    "can_restore": True,
                    "can_delete": True,
                    "is_staff": request.user.is_staff,
                    "is_superuser": request.user.is_superuser
                }
            }
        })
    except Exception as e:
        return Response({
            "status": "error",
            "message": f"Erreur lors de la récupération des paramètres: {str(e)}"
        }, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
