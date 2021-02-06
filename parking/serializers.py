from rest_framework import serializers
from parking.models import Reservation, ParkingSpot


class ParkingSpotSerializer(serializers.ModelSerializer):
    distance = serializers.FloatField(default=None)

    class Meta:
        model = ParkingSpot
        fields = ("id", "name", "longitude", "latitude", "price", "distance")
        read_only_fields = ('distance',)


class ReservationSerializer(serializers.ModelSerializer):

    class Meta:
        model = Reservation
        fields = "__all__"
        read_only_fields = ('payment_status', 'payment_transaction_id', 'refund_status', 'refund_transaction_id')
