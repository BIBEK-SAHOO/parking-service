from .test_setup import TestSetUp
from ..models import Phone


class TestViews(TestSetUp):
    def test_registration_without_data(self):
        response = self.client.post(self.sign_up_url)
        self.assertEqual(response.status_code, 400)

    def test_registration_without_phone_verification(self):
        response = self.client.post(self.sign_up_url, self.user_data, format="json")
        self.assertEqual(response.status_code, 400)

    def test_registration_with_phone_verification(self):
        Phone.objects.create(Mobile=self.user_data.get("phone"), isVerified=True)
        response = self.client.post(self.sign_up_url, self.user_data, format="json")
        self.assertEqual(response.status_code, 201)

    def test_login_without_data(self):
        response = self.client.post(self.login)
        self.assertEqual(response.status_code, 400)

    def test_login_with_data(self):
        Phone.objects.create(Mobile=self.user_data.get("phone"), isVerified=True)
        self.client.post(self.sign_up_url, self.user_data, format="json")
        response = self.client.post(self.login, self.user_data, format="json")
        self.assertEqual(response.status_code, 200)
