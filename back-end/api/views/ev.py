import datetime

from django.views import View
from django.http import JsonResponse, HttpResponseBadRequest, HttpResponse
from django.core.exceptions import ObjectDoesNotExist

from api.utils.common import produce_csv_response, get_now,\
        datetime_from_string, datetime_to_string
from api.utils.auth import authenticated
from api.models import Car, ChargeSession

class EVView(View):
    @authenticated()
    def get(self, request, user, vehicle_id, date_from, date_to):
        requested_format = self.request.GET.get('format', 'json')

        try:
            start = datetime_from_string(date_from)
            end = datetime_from_string(date_to) + datetime.timedelta(milliseconds=999)
        except ValueError:
            return HttpResponseBadRequest("Invalid date format.")

        try:
            car = Car.objects.get(licence=vehicle_id)
        except ObjectDoesNotExist:
            return HttpResponseBadRequest("EV does not exist.")

        if car.user_id != user:
            return HttpResponse("Unauthorized. Vehicle does not belong to you.", status=401)

        sessions = ChargeSession.objects.filter(car_id=car,
                start__gte=start, end__lte=end).order_by('start')

        resp = {
            "VehicleID": car.licence,
            "RequestTimestamp": datetime_to_string(get_now()),
            "PeriodFrom": datetime_to_string(start),
            "PeriodTo": datetime_to_string(end),
            "TotalEnergyConsumed": 0,
            "NumberOfVisitedPoints": 0,
            "NumberOfVehicleChargingSessions": len(sessions),
            "VehicleChargingSessionsList": []
        }

        visited_points = set()
        for idx, session in enumerate(sessions, start=1):
            resp["VehicleChargingSessionsList"].append({
                "SessionIndex": idx,
                "SessionID": session.id,
                "EnergyProvider": None,
                "StartedOn": datetime_to_string(session.start),
                "FinishedOn": datetime_to_string(session.end),
                "EnergyDelivered": session.energy_delivered,
                "PricePolicyRef": session.pricing_id.description,
                "CostPerKWh": session.pricing_id.price,
                "SessionCost": session.total_cost
            })
            resp["TotalEnergyConsumed"] += session.energy_delivered
            visited_points.add(session.point_id.id)

        resp["NumberOfVisitedPoints"] = len(visited_points)


        if requested_format == 'csv':
            root_keys = ["VehicleID", "RequestTimestamp", "PeriodFrom", "PeriodTo",
                    "TotalEnergyConsumed", "NumberOfVisitedPoints", "NumberOfVehicleChargingSessions"]
            lst_keys = ["SessionIndex", "SessionID", "EnergyProvider", "StartedOn", "FinishedOn",
                    "EnergyDelivered", "PricePolicyRef", "CostPerKWh", "SessionCost"]
            return produce_csv_response(resp, root_keys, lst_keys, "VehicleChargingSessionsList")
        elif requested_format == "json":
            return JsonResponse(resp)
        else:
            return HttpResponseBadRequest("Invalid format.")
