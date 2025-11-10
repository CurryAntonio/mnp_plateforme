from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin

User = get_user_model()

class UserAdmin(BaseUserAdmin):
    list_display = ('email', 'nom', 'prenom', 'is_staff', 'date_creation')
    list_filter = ('is_staff', 'is_superuser', 'is_active', 'date_creation')
    search_fields = ('email', 'nom', 'prenom')
    ordering = ('email',)
    
    fieldsets = (
        (None, {'fields': ('email', 'password')}),
        ('Informations personnelles', {'fields': ('nom', 'prenom')}),
        ('Permissions', {'fields': ('is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Dates importantes', {'fields': ('last_login', 'date_joined')}),
    )
    
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('email', 'password1', 'password2', 'nom', 'prenom'),
        }),
    )

admin.site.register(User, UserAdmin)
# Register your models here.
