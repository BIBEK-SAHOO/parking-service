from rest_framework.permissions import BasePermission


class IsUserForReservation(BasePermission):
    """
    Permission class to check the user is owner of the reservation object or not.
    """

    message = 'You are not allowed to perform this task'

    def has_object_permission(self, request, view, object):

        return object.is_booked_by(request.user)


class UserIsOwner(BasePermission):
    """
    Permission class to check the request user is owner of the user object to be modified or not.
    """

    message = 'You are not allowed to perform this task'

    def has_object_permission(self, request, view, object):

        return object.id == request.user.id


