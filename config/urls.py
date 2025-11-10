"""
URL configuration for config project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include, re_path
from django.conf import settings
from django.conf.urls.static import static
from django.http import HttpResponse
from django.http import FileResponse, Http404
from django.views.static import serve as static_serve
import os

def home_view(request):
    return HttpResponse("API MNP est en cours d'exécution. Utilisez /api/ pour accéder aux endpoints.")


# Ajouter cette fonction après la ligne 22
def api_health_check(request):
    return HttpResponse("API MNP est opérationnelle", content_type="text/plain")

# Modifier les urlpatterns pour inclure :
# Vue qui sert le fichier SPA index.html depuis back_end/static
def spa_index(request):
    index_path = os.path.join(settings.BASE_DIR, 'static', 'index.html')
    try:
        return FileResponse(open(index_path, 'rb'))
    except FileNotFoundError:
        raise Http404()

# urlpatterns (module-level)
urlpatterns = [
    # Servez directement le SPA sur la base URL
    path('', spa_index, name='home'),
    path('admin/', admin.site.urls),
    path('api/', api_health_check, name='api-health'),
    path('api/auth/', include('users.urls')),
    path('api/', include('products.urls')),
    path('api/groups/', include('products.urls_groups')),
    path('api/journal/', include('journal.urls')),
    path('api/reports/', include('reports.urls')),
    path('api/import-export/', include('import_export.urls')),
    path('api/inventory/', include('inventory.urls')),
    path('api/backup/', include('backup.urls')),
    # Servir les assets générés par Vite à /assets/*
    re_path(r'^assets/(?P<path>.*)$', static_serve, {
        'document_root': os.path.join(settings.BASE_DIR, 'static', 'assets')
    }),

    # Servir les fichiers statiques directs au racine (js, css, images, etc.)
    re_path(r'^(?P<path>.*\.(?:js|css|png|jpg|jpeg|svg|ico|json|txt|map))$', static_serve, {
        'document_root': os.path.join(settings.BASE_DIR, 'static')
    }),

    # Fallback SPA: toute route non-API renvoie index.html
    re_path(r'^(?!api/).*$', spa_index),
]

# Servir les fichiers media en développement
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
