from rest_framework import permissions, views, status, viewsets
from .serializers import ReservationSerializer, ParkingSpotSerializer
from parking.models import ParkingSpot, Reservation
from rest_framework.response import Response
from datetime import datetime
from rest_framework.decorators import action
from users.permissions import IsUserForReservation
import math
from rest_framework.decorators import api_view, permission_classes
from .instamojo import generate_payment_link


def calculate_price(from_date_time, to_date_time, parking_spot_id):
    """
    Function to calculate total price of a Parking Spot for given time duration.
    """
    try:
        seconds_in_day = 24 * 60 * 60
        hour_difference = ((to_date_time - from_date_time).days * seconds_in_day + (to_date_time - from_date_time).seconds) / (60 * 60)
        hour_round_off = math.ceil(hour_difference)

        parking_obj = ParkingSpot.objects.get(id=parking_spot_id)

        total_price = hour_round_off * parking_obj.price
        return total_price
    except Exception as e:
        print(str(e))
        return None


class ParkingSpotViewSet(viewsets.ModelViewSet):
    """
        API endpoint that allows to view, create, edit and delete Parking Spots.
    """
    queryset = ParkingSpot.objects.all()
    serializer_class = ParkingSpotSerializer

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = (permissions.AllowAny,)
        elif self.request.method in ['POST', 'PATCH', 'PUT', 'DELETE']:
            self.permission_classes = (permissions.IsAdminUser,)

        return super(ParkingSpotViewSet, self).get_permissions()

    def list(self, request, *args, **kwargs):
        try:
            input_lng = self.request.query_params.get('lng')
            input_lat = self.request.query_params.get('lat')
            radius = self.request.query_params.get('radius')  # radius in meter.
            queryset = self.get_queryset()

            if input_lng and input_lat and radius:
                input_lng = float(input_lng)
                input_lat = float(input_lat)
                radius = float(radius)/1000  # radius converted to KM.

                filter_dict = {
                    'input_lng': input_lng,
                    'input_lat': input_lat,
                    'radius': radius
                }
                # Query to find coordinates in the given radius.
                # The query result will include a calculated column distance and also will sort the result by distance.
                query = """
                            SELECT
                              *, (
                                6371 * acos (
                                  cos ( radians(%(input_lat)s) )
                                  * cos( radians( latitude ) )
                                  * cos( radians( longitude ) - radians(%(input_lng)s) )
                                  + sin ( radians(%(input_lat)s) )
                                  * sin( radians( latitude ) )
                                )
                              )*1000 AS distance
                            FROM parking_parkingspot
                            HAVING distance < %(radius)s*1000
                            ORDER BY distance;
                        """
                queryset = self.get_queryset().raw(query, filter_dict)

            page = self.paginate_queryset(queryset)
            if page is not None:
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)

            serializer = self.get_serializer(queryset, many=True)

            return Response(serializer.data)
        except Exception as e:
            return Response({"Error: ": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    @action(detail=False, methods=["GET"])
    def check_price(self, request):
        try:
            # converting string to datetime.
            from_date_time = datetime.strptime(request.query_params.get("fromDateTime"), '%Y-%m-%dT%H:%M:%S.%fZ') \
                if request.query_params.get("fromDateTime") else None
            to_date_time = datetime.strptime(request.query_params.get("toDateTime"), '%Y-%m-%dT%H:%M:%S.%fZ') \
                if request.query_params.get("fromDateTime") else None
            parking_spot_id = request.query_params.get("parkingSpotId")

            total_price = calculate_price(from_date_time, to_date_time, parking_spot_id)

            return Response({"total_price": total_price})
        except Exception as e:
            return Response({"Error: ": str(e)}, status=status.HTTP_400_BAD_REQUEST)


class ReservationViewSet(viewsets.ModelViewSet):
    """
        API endpoint that allows to viewe, create, edit and delete Reservations.
    """
    queryset = Reservation.objects.all()
    serializer_class = ReservationSerializer

    def get_permissions(self):
        if self.request.method == 'GET':
            self.permission_classes = (permissions.AllowAny,)
        elif self.request.method in ['PATCH', 'PUT']:
            self.permission_classes = (permissions.IsAuthenticated, IsUserForReservation,)
        elif self.request.method == 'DELETE':
            self.permission_classes = (permissions.IsAdminUser,)

        return super(ReservationViewSet, self).get_permissions()

    def list(self, request, *args, **kwargs):
        try:
            parking_spot_id = self.request.query_params.get('parkingSpotId')
            queryset = self.get_queryset()
            if parking_spot_id:
                queryset = queryset.filter(parking_spot__id=parking_spot_id)
            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        except Exception as e:
            return Response({"Error: ": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def create(self, request, *args, **kwargs):
        try:
            data = request.data
            # converting string to datetime.
            data["from_timestamp"] = datetime.strptime(data.get("from_timestamp"), '%Y-%m-%dT%H:%M:%S.%fZ') \
                if data.get("from_timestamp") else None
            data["to_timestamp"] = datetime.strptime(data.get("to_timestamp"), '%Y-%m-%dT%H:%M:%S.%fZ') \
                if data.get("to_timestamp") else None
            if not (data.get("from_timestamp") and data.get("to_timestamp") and data.get("parking_spot")):
                raise ValueError("Invalid or missing input values.")
            if data["from_timestamp"] >= data["to_timestamp"]:
                raise ValueError("Invalid input dates. To time must be greater than from time.")

            # Checking for reservation overlaps/duplicate reservations.
            try:
                overlap_reservations = Reservation.objects.get(parking_spot=data["parking_spot"],
                                                               from_timestamp__lte=data["from_timestamp"],
                                                               to_timestamp__gte=data["from_timestamp"],
                                                               booking_status=True)

                raise ValueError("Reservation Overlapping with other bookings.")
            except Reservation.DoesNotExist:
                pass
            try:
                overlap_reservations = Reservation.objects.get(parking_spot=data["parking_spot"],
                                                               from_timestamp__lte=data["to_timestamp"],
                                                               to_timestamp__gte=data["to_timestamp"],
                                                               booking_status=True)

                raise ValueError("Reservation Overlapping with other bookings.")
            except Reservation.DoesNotExist:
                pass
            try:
                overlap_reservations = Reservation.objects.filter(parking_spot=data["parking_spot"],
                                                                  from_timestamp__gte=data["from_timestamp"],
                                                                  to_timestamp__lte=data["to_timestamp"],
                                                                  booking_status=True)

                if overlap_reservations:
                    raise ValueError("Reservation Overlapping with other bookings.")
            except Reservation.DoesNotExist:
                pass

            total_price = calculate_price(data["from_timestamp"], data["to_timestamp"], data["parking_spot"])

            data.update({"user": request.user.id, "total_price": total_price})

            serializer = self.get_serializer(data=data)
            if serializer.is_valid():
                reservation_data = serializer.save()
                payment_link = generate_payment_link(reservation_data.total_price, reservation_data.id, request.user)
                return Response({"reservation_data": serializer.data, "payment_link": payment_link},
                                status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except ValueError as e:
            return Response({"message": str(e)}, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({"message": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def update(self, request, *args, **kwargs):
        try:
            data_to_update = {key: request.data.get(key) for key in request.data if key in ["booking_status"]}
            instance = self.get_object()
            serializer = self.get_serializer(instance, data=data_to_update, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_202_ACCEPTED)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            return Response({"message": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
@permission_classes([permissions.AllowAny])
def update_payment_details(request):
    try:
        reservation_id = int(request.query_params.get("id"))
        payment_id = request.query_params.get("payment_id")
        payment_status = request.query_params.get("payment_status")

        reservation_obj = Reservation.objects.get(id=reservation_id)
        reservation_obj.payment_transaction_id = payment_id
        reservation_obj.payment_status = payment_status
        reservation_obj.save()

        return Response({"message": "Payment Details Saved"})
    except Exception as e:
        return Response({"Error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)








