from rest_framework.permissions import AllowAny
from rest_framework.response import Response
from rest_framework.viewsets import ModelViewSet
from rest_framework.views import APIView
from django.shortcuts import render

from .models import Truck
from .serializers import TruckSerializer

def home(request):
    """return home page"""
    return render(request, 'trucks/home.html')

class ListTrucksView(ModelViewSet):
    permission_classes = (AllowAny,)
    queryset = Truck.objects.all()
    serializer_class = TruckSerializer
    lookup_field = 'id'


class CheckTruckActive(APIView):
    """
    Check if there are Trucks active to receive orders
    """
    permission_classes = [AllowAny]

    def get(self, request, *args, **kwargs):
        """return True if there are any truck active else False"""
        trucks = Truck.objects.all().filter(isActive=True)
        if len(trucks) == 0:
            return Response(False)
        else:
            return Response(True)
