from rest_framework.test import APITestCase
from django.urls import reverse
from faker import Faker
from random import randint
fake = Faker()


class TestSetUp(APITestCase):

    def setUp(self):
        self.sign_up_url = reverse('user-list')
        self.login = reverse('login')

        self.user_data = {
            "phone": randint(7000000000, 8000000000),
            "password": fake.name()
        }
        return super().setUp()

    def tearDown(self):
        return super().tearDown()
