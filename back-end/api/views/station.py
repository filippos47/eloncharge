import datetime

from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest, HttpResponse
from django.core.exceptions import ObjectDoesNotExist

from api.utils.common import produce_csv_response, get_now,\
        datetime_from_string, datetime_to_string
from api.utils.auth import authenticated
from api.models import Station, Point, ChargeSession

class StationView(View):
    @authenticated()
    def get(self, request, user, station_id, date_from, date_to):
        requested_format = self.request.GET.get('format', 'json')

        try:
            start = datetime_from_string(date_from)
            end = datetime_from_string(date_to) + datetime.timedelta(milliseconds=999)
        except ValueError:
            return HttpResponseBadRequest("Invalid date format.")

        try:
            station = Station.objects.get(id=station_id)
        except ObjectDoesNotExist:
            return HttpResponseBadRequest("Station does not exist.")
        except ValueError:
            return HttpResponseBadRequest("Invalid station id")

        if station.operator != user:
            return HttpResponse("Unauthorized. Station does not belong to you.", status=401)

        points = Point.objects.filter(station_id=station)

        resp = {
            "StationID": station.id,
            "Operator": station.operator.username,
            "RequestTimestamp": datetime_to_string(get_now()),
            "PeriodFrom": datetime_to_string(start),
            "PeriodTo": datetime_to_string(end),
            "TotalEnergyDelivered": 0,
            "NumberOfChargingSessions": 0,
            "NumberOfActivePoints": 0,
            "SessionsSummaryList": []
        }

        for point in points:
            sessions = ChargeSession.objects.filter(point_id=point,
                    start__gte=start, end__lte=end).order_by('start')
            if len(sessions):
                energy_delivered = sum([x.energy_delivered for x in sessions])
                resp['NumberOfChargingSessions'] += len(sessions)
                resp['NumberOfActivePoints'] += 1
                resp["SessionsSummaryList"].append({
                    "PointID": point.id,
                    "PointSessions": len(sessions),
                    "EnergyDelivered": energy_delivered
                })
                resp['TotalEnergyDelivered'] += energy_delivered

        if requested_format == 'csv':
            # TODO: proper csv response
            data = [['StationID', 'PeriodFrom', 'PeriodTo'],
                    [station_id, date_from, date_to]]
            return produce_csv_response(data)
        elif requested_format == "json":
            return JsonResponse(resp)
        else:
            return HttpResponseBadRequest("Invalid format.")
