import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class EVView(View):

    def get(self, request, vehicle_id, date_from, date_to):

        return JsonResponse({'VehicleID': vehicle_id, 'PeriodFrom': date_from,
            'PeriodTo': date_to})
