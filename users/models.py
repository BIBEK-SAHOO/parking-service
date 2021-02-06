from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager
from django.db import models


class UserManager(BaseUserManager):
    def create_user(self, phone, password=None, is_active=True, is_staff=False, is_admin=False):
        if not phone:
            raise ValueError("User must have a phone number")
        if not password:
            raise ValueError("User must have a password")

        user_obj = self.model(
            phone=phone
        )
        user_obj.set_password(password)
        user_obj.is_staff = is_staff
        user_obj.is_admin = is_admin
        user_obj.is_active = is_active
        user_obj.save(using=self._db)
        return user_obj

    def create_staffuser(self, phone, password=None):
        user = self.create_user(
            phone,
            password=password,
            is_staff=True
        )
        return user

    def create_superuser(self, phone, password=None):
        user = self.create_user(
            phone,
            password=password,
            is_staff=True,
            is_admin=True
        )
        return user


class User(AbstractBaseUser):
    first_name = models.CharField(max_length=250, default=None, null=True, blank=True)
    last_name = models.CharField(max_length=250, default=None, null=True, blank=True)
    email = models.EmailField(max_length=250, default=None, null=True, blank=True)
    phone = models.CharField(max_length=30, unique=True)
    password = models.CharField(max_length=1024, null=True, blank=True)
    creation_time = models.DateTimeField(auto_now_add=True)
    last_modification_time = models.DateTimeField(auto_now=True)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    is_admin = models.BooleanField(default=False)

    USERNAME_FIELD = 'phone'
    REQUIRED_FIELDS = []

    objects = UserManager()

    def has_perm(self, perm, obj=None):
        """Does the user have a specific permission?"""
        # Simplest possible answer: Yes, always
        return True

    def has_module_perms(self, app_label):
        """Does the user have permissions to view the app `app_label`?"""
        # Simplest possible answer: Yes, always
        return True


class Phone(models.Model):
    Mobile = models.BigIntegerField(blank=False)
    isVerified = models.BooleanField(blank=False, default=False)
    counter = models.IntegerField(default=0, blank=False)

    def __str__(self):
        return str(self.Mobile)





