from django.urls import path
from django.urls.conf import include
from rest_framework import routers
from .views import UserViewset


router = routers.DefaultRouter()
router.register(r'', UserViewset)

urlpatterns = [
    path('', include(router.urls)),
    
]