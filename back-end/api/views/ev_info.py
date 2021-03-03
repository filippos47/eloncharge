from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest
from django.core.exceptions import ObjectDoesNotExist

from api.utils.auth import authenticated
from api.models import Car

class EVInfoView(View):
    @authenticated(superuser=False)
    def get(self, request, user):
        requested_format = self.request.GET.get('format', 'json')

        try:
            cars = Car.objects.filter(user_id=user)
        except ObjectDoesNotExist as e:
            print (e)
            cars = []
        except Exception as e:
            print (e)

        resp = {}
        for car in cars:
            name = car.brand + " " + car.model
            resp[car.licence] = {
                "id": car.licence,
                "name": name
            }

        return JsonResponse(resp)
