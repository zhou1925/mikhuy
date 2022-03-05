from django.urls import path

from .views import OrderDetail, UserOrderList

urlpatterns = [
    path('orders/', UserOrderList.as_view()),
    path('orders/<order_code>', OrderDetail.as_view()),
]