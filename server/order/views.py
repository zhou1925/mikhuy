import json
from django.shortcuts import get_object_or_404
from django.db.utils import IntegrityError
from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.exceptions import NotAcceptable, ValidationError, PermissionDenied
from rest_framework.generics import RetrieveUpdateDestroyAPIView

from users.models import User
from cart.models import Cart
from products.models import Product

from .models import Order
from .serializers import DetailedOrderSerializer, OrderUpdateSerializer


class CheckoutView(RetrieveUpdateDestroyAPIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        profile_id = request.data.get("profile_id")
        user = User.objects.get(id=profile_id)

        if profile_id == None:
            return Response({'error': 'Profile Id Not Found'}, status=400)

        name = request.data.get('name')
        address_line_1 = request.data.get('address_line_1')
        address_line_2 = request.data.get('address_line_2')
        note = request.data.get('note')
        # list of carts of the user
        carts = Cart.objects.filter(user=user)
        # set last cart of the user
        cart = carts.last()

        try:
            order = Order.objects.create(
                user=user,
                name=name,
                address_line_1=address_line_1,
                address_line_2=address_line_2,
                note=note,
                cart=cart,
                status='created'
            )
        except IntegrityError as err:
            return Response({"error": "Insufficient Data"}, status=400)

        orders = Order.objects.filter(user=user)
        order_obj = orders.last()
        done = order_obj.mark_used_cart()

        if not done:
            return Response({'error': 'Unable To mark used cart'}, status=500)

        return Response(DetailedOrderSerializer(order_obj).data)
    
    def update(self, request, *args, **kwargs):
        status = request.data["status"]

        try:
            order = get_object_or_404(Order, pk=request.data["order_id"])
            order.status = status
            order.save()
        except Exception as e:
            raise ValidationError("Please, input vaild data")

        serializer = OrderUpdateSerializer(order, data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)