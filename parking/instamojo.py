from parking_service.settings import INSTAMOJO_DETAILS
import requests
import json


def generate_payment_link(amount, reservation_id, user_obj):
    """Requesting Instamojo for Payment link."""
    try:
        data_to_generate = {"amount": amount,
                            "purpose": "Testing",
                            "email": user_obj.email,
                            "phone": user_obj.phone,
                            "buyer_name": user_obj.first_name,
                            "redirect_url": "http://localhost:8000/api/v1/update_payment_details/?id="+str(reservation_id)
                            }
        headers = {"X-Api-Key": INSTAMOJO_DETAILS.get("api_key"), "X-Auth-Token": INSTAMOJO_DETAILS.get("auth_token")}
        instamojo_response = requests.post(INSTAMOJO_DETAILS.get("url"), data=data_to_generate, headers=headers)
        instamojo_response = json.loads(instamojo_response.text)

        return instamojo_response
    except Exception as e:
        return str(e)
