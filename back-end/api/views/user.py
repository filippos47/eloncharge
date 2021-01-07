from django.views import View
from django.http import HttpResponse, JsonResponse
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

from api.utils.auth import authenticated

class UserView(View):
    @authenticated(superuser=True)
    def post(self, request, admin, username, password):
        user = User.objects.get_or_create(username=username)[0]

        user.set_password(password)
        user.save()
        return HttpResponse(status=200)

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

        return JsonResponse({'username': req_user.username})
