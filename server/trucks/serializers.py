from rest_framework import serializers

from .models import Truck, TruckLocation


class TruckSerializer(serializers.ModelSerializer):
    """
    Serialize Truck model
    """
    class Meta:
        model = Truck
        fields = ['id','name', 'picUrl', 'isActive']
