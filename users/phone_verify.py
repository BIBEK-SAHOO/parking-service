from datetime import datetime
from django.core.exceptions import ObjectDoesNotExist
import pyotp
from rest_framework.response import Response
from rest_framework.views import APIView
from .models import Phone
from rest_framework import permissions, status
import base64

from twilio.rest import Client
from twilio.base.exceptions import TwilioRestException
from parking_service.settings import TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, SMS_FROM_NO


# This class returns the string needed to generate the key
class generateKey:
    @staticmethod
    def returnValue(phone):
        return str(phone) + str(datetime.date(datetime.now())) + "Some Random Secret Key"


class getPhoneNumberRegistered(APIView):
    permission_classes = [permissions.AllowAny]
    # Get to Create a call for OTP

    @staticmethod
    def get(request, phone):
        try:
            try:
                Mobile = Phone.objects.get(Mobile=phone)  # if Mobile already exists the take this else create New One
            except ObjectDoesNotExist:
                Phone.objects.create(
                    Mobile=phone,
                )
                Mobile = Phone.objects.get(Mobile=phone)  # user Newly created Model
            Mobile.counter += 1  # Update Counter At every Call
            Mobile.save()  # Save the data
            keygen = generateKey()
            key = base64.b32encode(keygen.returnValue(phone).encode())  # Key is generated
            OTP = pyotp.HOTP(key)  # HOTP Model for OTP is created
            print(OTP.at(Mobile.counter))

            # Your Account Sid and Auth Token from twilio.com/console
            client = Client(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)

            message = client.messages \
                .create(
                body='OTP for Parking Service is '+OTP.at(Mobile.counter),
                from_=SMS_FROM_NO,
                to='+91'+phone
            )

            print(message.sid)

            # Using Multi-Threading send the OTP Using Messaging Services like Twilio or Fast2sms
            # return Response({"OTP": OTP.at(Mobile.counter)}, status=200)  # Just for demonstration
            return Response({"message": "OTP Sent."}, status=status.HTTP_200_OK)
        except TwilioRestException:
            return Response({"message": "Trial Twilio accounts cannot send messages to unverified numbers.", "OTP": OTP.at(Mobile.counter)}, status=status.HTTP_200_OK)  # Just for demonstration
        except Exception as e:
            return Response({"Error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


    # This Method verifies the OTP
    @staticmethod
    def post(request, phone):
        try:
            Mobile = Phone.objects.get(Mobile=phone)
        except ObjectDoesNotExist:
            return Response("User does not exist", status=404)  # False Call

        keygen = generateKey()
        key = base64.b32encode(keygen.returnValue(phone).encode())  # Generating Key
        OTP = pyotp.HOTP(key)  # HOTP Model
        if OTP.verify(request.data["otp"], Mobile.counter):  # Verifying the OTP
            Mobile.isVerified = True
            Mobile.save()
            return Response("You are authorised", status=200)
        return Response("OTP is wrong", status=400)