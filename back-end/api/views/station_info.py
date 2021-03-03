from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest
from django.core.exceptions import ObjectDoesNotExist

from api.utils.auth import authenticated
from api.models import Station, Point

class StationInfoView(View):
    @authenticated()
    def get(self, request, user):
        try:
            stations = Station.objects.filter(operator=user)
        except ObjectDoesNotExist:
            return HttpResponseBadRequest("Station does not exist.")

        resp = {}
        for station in stations:
            points = Point.objects.filter(station_id=station)
            resp[station.id] = {
                    "id": station.id,
                    "latitude": station.latitude,
                    "longtitude": station.longtitude,
                    "address": station.address,
                    "number": station.number,
                    "zipcode": station.zipcode,
                    "city": station.city,
                    "region": station.region,
                    "country": station.country,
                    "points": {}
            }
            for point in points:
                resp[station.id]["points"][point.id] = {
                        "id": point.id,
                        "charges": {}
                    }

        return JsonResponse(resp)
