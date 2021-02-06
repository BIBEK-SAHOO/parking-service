from rest_framework.test import APITestCase
from django.urls import reverse
from faker import Faker
from random import randint
fake = Faker()


class TestSetUp(APITestCase):

    def setUp(self):
        self.parking_spot_url = reverse('parkingspot-list')
        self.parking_spot_price_url = reverse('parkingspot-check-price')
        self.reservation_url = reverse('reservation-list')

        self.location = {
            "lng": float(fake.longitude()),
            "lat": float(fake.latitude()),
            "radius": randint(500, 10000)
        }
        return super().setUp()

    def tearDown(self):
        return super().tearDown()
