from rest_framework import routers
from .views import ParkingSpotViewSet, ReservationViewSet, update_payment_details
from django.urls import path

parking_router = routers.SimpleRouter()
parking_router.register(r'parking-spot', ParkingSpotViewSet)
parking_router.register(r'reservation', ReservationViewSet)
urlpatterns = parking_router.urls

urlpatterns += [
    path('update_payment_details/', update_payment_details),
]
