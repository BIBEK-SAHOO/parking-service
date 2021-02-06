from .test_setup import TestSetUp


class TestViews(TestSetUp):
    def test_get_parking_spots(self):
        response = self.client.get(self.parking_spot_url)
        self.assertEqual(response.status_code, 200)

    def test_get_parking_spots_by_loc(self):
        response = self.client.get(self.parking_spot_url, self.location)
        self.assertEqual(response.status_code, 200)


