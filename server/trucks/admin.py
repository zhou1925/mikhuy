from django.contrib import admin
from .models import Truck, TruckLocation


@admin.register(Truck)
class TruckAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'picUrl', 'isActive']
    list_editable = ['isActive']


@admin.register(TruckLocation)
class TruckLocationAdmin(admin.ModelAdmin):
    list_display = ['truck', 'latitude', 'longitude']