from django.urls import path

from .views import CartAPIView, CheckProductInCart, CartItemView
# from .views import CartItemAPIView, CartItemView

urlpatterns = [
    path('', CartAPIView.as_view()),
    path('cart-item/<int:pk>/', CartItemView.as_view()),
    path('<product_id>/', CheckProductInCart.as_view()),
    # path("", CartItemAPIView.as_view()),
    # path("cart-item/<int:pk>/", CartItemView.as_view()),
]