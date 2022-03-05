from django.urls import path

from .views import ListTrucksView, CheckTruckActive

urlpatterns = [
    path("", ListTrucksView.as_view({'get': 'list'})),
    path("<id>/", ListTrucksView.as_view({'get': 'retrieve'})),
    path("active", CheckTruckActive.as_view()),
]