from rest_framework.permissions import BasePermission

class CanManageBackups(BasePermission):
    """
    Permission personnalisée pour gérer les sauvegardes.
    Permet à tous les utilisateurs authentifiés d'accéder aux fonctionnalités de sauvegarde.
    """
    
    def has_permission(self, request, view):
        # L'utilisateur doit être authentifié
        if not request.user or not request.user.is_authenticated:
            return False
        
        # Permettre à tous les utilisateurs authentifiés
        return True
    
    message = "Vous devez être connecté pour accéder à cette fonctionnalité."