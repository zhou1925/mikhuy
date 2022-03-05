from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, \
                                        PermissionsMixin
from django.core.validators import MinValueValidator


class UserMananager(BaseUserManager):

    def create_user(self, phone, password=None, **extra_fields):
        """Create and save a new user"""
        if not phone:
            raise ValueError('Users must be have a phone ')
        user = self.model(phone=phone, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user
    
    def create_superuser(self, phone, password, **extra_fields):
        """ Create super user and save """
        user = self.create_user(phone=phone, password=password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user 
    

class User(AbstractBaseUser, PermissionsMixin):
    """Custom user model that supports using phone instead of username"""
    phone = models.CharField(max_length=9, unique=True)
    # name = models.CharField(max_length=255)
    # last_name = models.CharField(max_length=255)
    # address = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_driver = models.BooleanField(default=False)

    objects = UserMananager()

    USERNAME_FIELD = 'phone'
