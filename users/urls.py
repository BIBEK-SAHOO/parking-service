from rest_framework import routers
from .views import UserViewSet, login_view
from django.urls import path


from .phone_verify import getPhoneNumberRegistered

users_router = routers.SimpleRouter()
users_router.register(r'users', UserViewSet)
urlpatterns = users_router.urls


urlpatterns += [
    path('login/', login_view, name="login"),
    path('verify/<phone>/', getPhoneNumberRegistered.as_view()),
]
