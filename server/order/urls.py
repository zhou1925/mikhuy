from django.urls import path

from .views import CheckoutView

urlpatterns = [
    path("checkout/", CheckoutView.as_view()),
    # path("", OrderView.as_view()),
]