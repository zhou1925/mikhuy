from rest_framework import serializers
from rest_framework.authtoken.models import Token
from django.contrib.auth import get_user_model


User = get_user_model()

class ChangePasswordSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'phone', 'password', 'is_driver')
        extra_kwargs = {'password': { 'write_only': True, 'required': False}}
    
    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        user.set_password(validated_data['password'])
        user.save()
        return user