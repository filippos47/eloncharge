from django.http import HttpResponse, HttpResponseBadRequest
from django.core.exceptions import ObjectDoesNotExist

from api.models import UserSession
from .common import get_now

def authenticated(superuser=False):
    def func(f):
        def check(self, request, *args, **kwargs):
            token = request.headers.get('x-auth-observatory', None)

            if not token:
                return HttpResponse("Unauthorized: An access token is required.", status=401)

            try:
                session = UserSession.objects.get(token=token, expires__gte=get_now())
            except ObjectDoesNotExist:
                return HttpResponse("Unauthorized: Expired session. Renew token!", status=401)

            if superuser and not session.user_id.is_superuser:
                return HttpResponse("Unauthorized: Requires admin access", status=401)

            return f(self, request, session.user_id, *args, **kwargs)
        return check
    return func
