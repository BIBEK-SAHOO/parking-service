from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import Phone

UserModel = get_user_model()


class UserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(write_only=True)

    class Meta:
        model = UserModel
        fields = "__all__"

    def create(self, validated_data):
        try:
            phone_obj = Phone.objects.get(Mobile=validated_data['phone'])
            if not phone_obj.isVerified:
                raise serializers.ValidationError("Phone Number Validation Incomplete.")
        except Phone.DoesNotExist:
            raise serializers.ValidationError("Phone Number not validated.")

        user = UserModel.objects.create(
            phone=validated_data['phone']
        )
        user.set_password(validated_data['password'])
        user.save()

        return user

    def update(self, instance, validated_data):
        for attr, value in validated_data.items():
            if attr == 'password':
                instance.set_password(value)
            else:
                setattr(instance, attr, value)
        instance.save()
        return instance

