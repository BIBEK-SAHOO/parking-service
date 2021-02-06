from rest_framework import permissions, views, status, viewsets
from django.contrib.auth import get_user_model, authenticate, login
from .serializers import UserSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view, permission_classes
from rest_framework.authtoken.models import Token
from parking.models import Reservation
from parking.serializers import ReservationSerializer
from rest_framework.decorators import action
from functools import partial
from users.permissions import IsUserForReservation, UserIsOwner


class UserViewSet(viewsets.ModelViewSet):
    """
        API endpoint that allows to view, create, edit and delete Users.
    """
    queryset = get_user_model().objects
    serializer_class = UserSerializer

    def get_permissions(self):
        if self.request.method == 'POST':
            self.permission_classes = (permissions.AllowAny,)
        elif self.action in ['list', 'destroy']:
            self.permission_classes = (permissions.IsAdminUser,)
        elif self.action in ['retrieve', 'update', 'partial_update']:
            self.permission_classes = (permissions.IsAuthenticated, UserIsOwner,)

        return super(UserViewSet, self).get_permissions()

    @action(detail=False, methods=['GET'])
    def reserved_spots(self, request):
        try:
            reservation_queryset = Reservation.objects.filter(user=request.user)
            reservation_serializer = ReservationSerializer(reservation_queryset, many=True)
            return Response(reservation_serializer.data)
        except Exception as e:
            return Response({"Error: ": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['POST'])
@permission_classes([permissions.AllowAny])
def login_view(request):
    """
        API endpoint for user login.
    """
    try:
        data = request.data
        phone = data.get('phone')
        password = data.get('password')
        if not (phone and password):
            raise ValueError("Phone and Password required.")
        user = authenticate(phone=phone, password=password)
        response_data = {}

        if user and user.is_active:
            login(request, user)

            token, created = Token.objects.get_or_create(user=user)
            response_data['token'] = token.key

            return Response(response_data, status=status.HTTP_200_OK)
        else:
            return Response({"message": "login failed."}, status=status.HTTP_401_UNAUTHORIZED)
    except ValueError as e:
        return Response({"message": str(e)}, status=status.HTTP_400_BAD_REQUEST)
    except Exception as e:
        return Response({"message": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)