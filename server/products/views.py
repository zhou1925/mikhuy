from django.shortcuts import get_object_or_404
from rest_framework import authentication, permissions
from rest_framework.permissions import AllowAny, IsAdminUser
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.viewsets import ModelViewSet

from .models import Product, Tag
from .serializers import ProductSerializer, CategorySerializer


class CategoryViewSet(ModelViewSet):
    """
    Return products by Tag, Category 
    """
    permission_classes = (permissions.AllowAny,)
    queryset = Tag.objects.all().filter(active=True)
    serializer_class = CategorySerializer
    lookup_field = 'id'


class ProductViewSet(ModelViewSet):
    """
    Product Viewset return list of products
    """
    serializer_class = ProductSerializer
    lookup_field = 'slug'

    def get_queryset(self):
        max_price = self.request.GET.get('max_price')
        min_price = self.request.GET.get('min_price')
        sort = self.request.GET.get('sort')
        keyword = self.request.GET.get('keyword')
        return Product.objects.filter_products(keyword, sort, min_price, max_price)

    def get_permissions(self):
        """
        Instance and returns the list of permissions that this view requires.
        """
        if self.action == 'list' or self.action == 'retrieve':
            permission_classes = [AllowAny]
        else:
            permission_classes = [IsAdminUser]
        return [permission() for permission in permission_classes]


class RelatedProductView(APIView):
    """
    Return related products of one product if not return nothing
    """
    permission_classes = [permissions.AllowAny]

    def get(self, request, id, *args, **kwargs):
        product_id = id  # request.data.get("product_id")
        if not product_id:
            return Response({"error": "Product Id Not Found"}, status=400)
        product = get_object_or_404(Product, id=product_id)
        products_serialized = ProductSerializer(
            product.get_related_products(), many=True, context={'request': request})
        return Response(products_serialized.data)

    @classmethod
    def get_extra_actions(cls):
        return []
