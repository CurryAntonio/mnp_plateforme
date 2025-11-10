from rest_framework import serializers
from .models import ImportHistory, ExportHistory

class ImportHistorySerializer(serializers.ModelSerializer):
    user_name = serializers.SerializerMethodField()
    
    class Meta:
        model = ImportHistory
        fields = ['id', 'user', 'user_name', 'file_name', 'import_type', 'status', 
                  'created_at', 'completed_at', 'total_rows', 'processed_rows', 
                  'success_rows', 'error_rows', 'error_details']
        read_only_fields = ['user', 'status', 'created_at', 'completed_at', 
                           'total_rows', 'processed_rows', 'success_rows', 'error_rows']
    
    def get_user_name(self, obj):
        return obj.user.username if obj.user else None

class ExportHistorySerializer(serializers.ModelSerializer):
    user_name = serializers.SerializerMethodField()
    
    class Meta:
        model = ExportHistory
        fields = ['id', 'user', 'user_name', 'file_name', 'export_type', 
                  'created_at', 'filters', 'row_count']
        read_only_fields = ['user', 'created_at', 'row_count']
    
    def get_user_name(self, obj):
        return obj.user.username if obj.user else None