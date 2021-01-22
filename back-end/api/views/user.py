from django.views import View
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

from api.utils.auth import authenticated, validate_credentials_format, \
        get_or_create_session

class UserView(View):
    @authenticated(superuser=True)
    def post(self, request, admin, username, password):
        credentials_error = validate_credentials_format(username, password)
        if credentials_error != None:
            return HttpResponse(credentials_error, status=400)

        user = User.objects.get_or_create(username=username)[0]
        user.set_password(password)
        user.save()

        session = get_or_create_session(user)
        return JsonResponse({'token': str(session.token)})

    @authenticated()
    def get(self, request, user, username):
        # if admin, retrieve whatever they want
        if user.is_superuser:
            try:
                req_user = User.objects.get(username=username)
            except ObjectDoesNotExist:
                return HttpResponse("No Data: User does not exist.", status=402)
        else:
            if user.username != username:
                return HttpResponse("Unauthorized. You are not that user.", status=401)
            req_user = user

        session = get_or_create_session(req_user)
        return JsonResponse({'username': req_user.username,
            'token': str(session.token)})
