from django.db import models
from users.models import User


class ParkingSpot(models.Model):
    name = models.CharField(max_length=250)
    latitude = models.FloatField()
    longitude = models.FloatField()
    price = models.FloatField()  # Price Per Hour.

    class Meta:
        unique_together = ["name", "latitude", "longitude"]

    def __str__(self):
        return self.name


class Reservation(models.Model):
    parking_spot = models.ForeignKey(ParkingSpot, on_delete=models.SET_NULL, null=True)
    user = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    from_timestamp = models.DateTimeField()
    to_timestamp = models.DateTimeField()
    total_price = models.FloatField()
    payment_status = models.CharField(max_length=250, default=None, null=True, blank=True)
    payment_transaction_id = models.CharField(max_length=250, default=None, null=True, blank=True)
    refund_status = models.CharField(max_length=250, default=None, null=True, blank=True)
    refund_transaction_id = models.CharField(max_length=250, default=None, null=True, blank=True)
    booking_status = models.BooleanField(default=True)  # True for Booked/ False for Cancelled.

    def __str__(self):
        return str(self.parking_spot)

    def is_booked_by(self, user):
        if self.user == user:
            return True
        return False

