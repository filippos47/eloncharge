import re

from django.http import HttpResponse, HttpResponseBadRequest
from django.core.exceptions import ObjectDoesNotExist

from api.models import UserSession
from .common import get_now, token_expires_delta, create_auth_token

def authenticated(superuser=False):
    def func(f):
        def check(self, request, *args, **kwargs):
            token = request.headers.get('x-auth-observatory', None)

            if not token:
                return HttpResponse("Unauthorized: An access token is required.", status=401)

            try:
                session = UserSession.objects.get(token=token)
            except ObjectDoesNotExist:
                return HttpResponse("Unauthorized: Non-existent session.", status=401)

            try:
                session = UserSession.objects.get(token=token, expires__gte=get_now())
            except ObjectDoesNotExist:
                return HttpResponse("Unauthorized: Expired session. Renew token!", status=401)

            if superuser and not session.user_id.is_superuser:
                return HttpResponse("Unauthorized: Requires admin access", status=401)

            return f(self, request, session.user_id, *args, **kwargs)
        return check
    return func

def get_or_create_session(user):
    try:
        session = UserSession.objects.get(user_id=user.id, expires__gte=get_now())
    except ObjectDoesNotExist:
        date_to = get_now() + token_expires_delta()
        token = create_auth_token()
        session = UserSession.objects.create(user_id=user, token=token, expires=date_to)
        session.save()
    return session

def validate_credentials_format(username, password):
    error = None
    if re.match('^[a-zA-Z0-9]+$', username) == None:
        error = "Bad Request: Username must only contain alphanumeric characters."
    elif " " in password:
        error = "Bad Request: Password must not contain whitespaces!"
    return error
