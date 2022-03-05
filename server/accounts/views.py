from django.shortcuts import get_object_or_404
from rest_framework.permissions import IsAuthenticated, IsAuthenticatedOrReadOnly
from rest_framework.authentication import TokenAuthentication
from rest_framework.response import Response
from rest_framework.views import APIView

from order.models import Order
from order.serializers import DetailedOrderSerializer, OrderSerializer


class UserOrderList(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        orders = Order.objects.filter(user=request.user).all().order_by('-id')
        return Response(OrderSerializer(orders, many=True).data)
    
    # def perform_create(self, serializer):
    #     """Create a new object"""
    #     serializer.save(user=self.request.user)

    # def get_queryset(self):
    #     """Retrieve recipes for current authenticated user"""
    #     return self.queryset.filter(user=self.request.user)


class OrderDetail(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, order_code, **kwargs):
        order_obj: Order = get_object_or_404(Order, order_code=order_code)
        if order_obj.user != request.user:
            return Response(status=401)
        return Response(DetailedOrderSerializer(order_obj).data)
