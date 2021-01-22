from django.views import View
from django.contrib.auth import authenticate
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseBadRequest, JsonResponse
from django.core.exceptions import ObjectDoesNotExist

from api.models import UserSession
from api.utils.common import get_now
from api.utils.auth import authenticated, get_or_create_session

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

        session = get_or_create_session(user)

        return JsonResponse({'token': str(session.token)})

class LogoutView(View):
    @authenticated()
    def post(self, request, user):
        token = request.headers.get('x-auth-observatory', None)
        session = UserSession.objects.get(token=token)
        session.expires = get_now()
        session.save()
        return HttpResponse()
