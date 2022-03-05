from rest_framework.decorators import action
from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.authentication import TokenAuthentication

from rest_framework.permissions import AllowAny, IsAuthenticated, IsAuthenticatedOrReadOnly
from .serializers import UserSerializer, ChangePasswordSerializer
from django.contrib.auth import get_user_model


User = get_user_model()

class UserViewset(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    authentication_classes = (TokenAuthentication,)
    permission_classes = (AllowAny,)

    @action(methods=['PUT'], detail=True, serializer_class=ChangePasswordSerializer, permission_classes=[IsAuthenticated])
    def change_password(self, request, pk):

        user = User.objects.get(pk=pk)
        serializer = ChangePasswordSerializer(data=request.data)
        if serializer.is_valid():
            if not user.check_password(serializer.data.get('old_password')):
                return Response(
                    {'message': 'Wrong old password'},
                    status=status.HTTP_400_BAD_REQUEST
                    )
            user.set_password(serializer.data.get('new_password'))
            user.save()
            return Response({'message': 'Password Updated'}, status=status.HTTP_200_OK)
        else:
            return Response({'message': 'missing data'},
                            status=status.HTTP_400_BAD_REQUEST)


class CustomObtainAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        response = super(CustomObtainAuthToken, self).post(request, *args, **kwargs)
        token = Token.objects.get(key=response.data['token'])
        user = User.objects.get(id=token.user_id)
        userserializer = UserSerializer(user, many=False)
        return Response({'token': token.key, 'user': userserializer.data})

