from django.views import View
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseBadRequest, JsonResponse
from django.core.exceptions import ObjectDoesNotExist

from api.models import UserSession
from api.utils.common import token_expires_delta, create_auth_token,\
        get_now
from api.utils.auth import authenticated

class LoginView(View):
    def post(self, request):
        username = request.POST.get('username', None)
        password = request.POST.get('password', None)

        if not username or not password:
            return HttpResponseBadRequest("Username and password are required!")

        user = authenticate(request, username=username, password=password)

        if not user:
            try:
                user = User.objects.get(username=username)
                msg = "Invalid password."
            except ObjectDoesNotExist:
                msg = "User does not exist."
            return HttpResponse("Unauthorized: " + msg, status=401)

        # get existing token or remove old one
        try:
            session = UserSession.objects.get(user_id=user.id, expires__gte=get_now())
        except ObjectDoesNotExist:
            date_to = get_now() + token_expires_delta()
            token = create_auth_token()
            session = UserSession.objects.create(user_id=user, token=token, expires=date_to)
            session.save()

        return JsonResponse({'token': str(session.token)})

class LogoutView(View):
    @authenticated()
    def post(self, request):
        token = request.headers.get('x-auth-observatory', None)
        session = UserSession.objects.get(token=token)
        session.expires = get_now()
        session.save()
        return HttpResponse()
