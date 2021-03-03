import datetime

from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest, HttpResponse
from django.core.exceptions import ObjectDoesNotExist

from api.utils.common import produce_csv_response, get_now,\
        datetime_from_string, datetime_to_string
from api.utils.auth import authenticated
from api.models import Point, ChargeSession

class PointView(View):
    @authenticated()
    def get(self, request, user, point_id, date_from, date_to):
        requested_format = self.request.GET.get('format', 'json')

        try:
            start = datetime_from_string(date_from)
            end = datetime_from_string(date_to) + datetime.timedelta(milliseconds=999)
        except ValueError:
            return HttpResponseBadRequest("Invalid date format.")

        try:
            point = Point.objects.get(id=point_id)
        except ObjectDoesNotExist:
            return HttpResponseBadRequest("Point does not exist.")
        except ValueError:
            return HttpResponseBadRequest("Invalid point id")

        if point.station_id.operator != user:
            return HttpResponse("Unauthorized. Point does not belong to you.", status=401)

        sessions = ChargeSession.objects.filter(point_id=point,
                start__gte=start, end__lte=end).order_by('start')

        resp = {
            "Point": point.id,
            "PointOperator": point.station_id.operator.username,
            "RequestTimestamp": datetime_to_string(get_now()),
            "PeriodFrom": datetime_to_string(start),
            "PeriodTo": datetime_to_string(end),
            "NumberOfChargingSessions": len(sessions),
            "ChargingSessionsList": []
        }

        for idx, session in enumerate(sessions, start=1):
            item = {
                "SessionIndex": idx,
                "SessionID": session.id,
                "StartedOn": datetime_to_string(session.start),
                "FinishedOn": datetime_to_string(session.end),
                "Protocol": session.protocol,
                "EnergyDelivered": session.energy_delivered,
                "Payment": session.payment,
                "SessionCost": session.total_cost
            }
            if session.car_id:
                item["VehicleType"] = session.car_id.type

            resp["ChargingSessionsList"].append(item)

        if requested_format == 'csv':
            root_keys = ["Point", "PointOperator", "RequestTimestamp", "PeriodFrom", "PeriodTo",
                    "NumberOfChargingSessions"]
            lst_keys = ["SessionIndex", "SessionID", "StartedOn", "FinishedOn", "Protocol",
                    "EnergyDelivered", "Payment", "VehicleType"]
            return produce_csv_response(resp, root_keys, lst_keys, "ChargingSessionsList")
        elif requested_format == "json":
            return JsonResponse(resp)
        else:
            return HttpResponseBadRequest("Invalid format.")
