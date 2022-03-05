from django.db import models


class Truck(models.Model):
    """
    Truck model to ask if some truck is active
    """
    name = models.CharField(max_length=128, blank=True, null=True)
    picUrl = models.URLField(blank=True, null=True)
    isActive = models.BooleanField(default=True)

    def __str__(self) -> str:
        return f"{self.name}"

class TruckLocation(models.Model):
    """
    Truck location model to expose coordinates
    """
    truck = models.OneToOneField(Truck, related_name='truck_location', on_delete=models.CASCADE)
    latitude = models.CharField(max_length=24)
    longitude = models.CharField(max_length=24)

    def getCurrentLocation(self):
        currentLocation = {
            'latitude': self.latitude,
            'longitude': self.longitude
        }
        return currentLocation
    
    def __str__(self) -> str:
        return "{}".format(self.truck.name)



