from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated
from rest_framework import status
from rest_framework.exceptions import NotAcceptable, ValidationError, PermissionDenied
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.generics import RetrieveUpdateDestroyAPIView


from products.models import Product

from .models import Cart, CartItem
from .serializers import CartItemSerializer, CartSerializer, CartItemUpdateSerializer


class CartAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        """Retrieve cart for current authenticated user"""
        return self.queryset.filter(user=self.request.user)

    def get(self, request, *args, **kwargs):
        cart_obj, _ = Cart.objects.get_existing_or_new(request)
        context = {'request': request}
        serializer = CartSerializer(cart_obj, context=context)

        return Response(serializer.data)

    def post(self, request, *args, **kwargs):
        # Request Data
        product_id = request.data.get("id")
        quantity = int(request.data.get("quantity", 1))

        # Get Product Obj and Cart Obj
        product_obj = get_object_or_404(Product, pk=product_id)
        cart_obj, _ = Cart.objects.get_existing_or_new(request)

        if quantity <= 0:
            cart_item_qs = CartItem.objects.filter(
                cart=cart_obj, product=product_obj)
            if cart_item_qs.count != 0:
                cart_item_qs.first().delete()
        else:
            cart_item_obj, created = CartItem.objects.get_or_create(
                product=product_obj, cart=cart_obj)
            cart_item_obj.quantity = quantity
            cart_item_obj.save()

        serializer = CartSerializer(cart_obj, context={'request': request})
        return Response(serializer.data)
    
    


class CheckProductInCart(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, product_id, **kwargs):
        product_obj = get_object_or_404(Product, pk=product_id)
        cart_obj, created = Cart.objects.get_existing_or_new(request)
        return Response(not created and CartItem.objects.filter(cart=cart_obj, product=product_obj).exists())



class CartItemView(RetrieveUpdateDestroyAPIView):
    serializer_class = CartItemSerializer
    queryset = CartItem.objects.all()

    def update(self, request, *args, **kwargs):
        cart_item = self.get_object()
        product = get_object_or_404(Product, pk=request.data["product"])

        if cart_item.cart.user != request.user:
            raise PermissionDenied("Sorry this cart not belong to you")

        try:
            quantity = int(request.data["quantity"])
        except Exception as e:
            raise ValidationError("Please, input vaild quantity")

        serializer = CartItemUpdateSerializer(cart_item, data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(serializer.data)

    def destroy(self, request, *args, **kwargs):
        cart_item = self.get_object()
        if cart_item.cart.user != request.user:
            raise PermissionDenied("Sorry this cart not belong to you")
        cart_item.delete()

        return Response(
            {"detail": "your item has been deleted."},
            status=status.HTTP_204_NO_CONTENT,
        )