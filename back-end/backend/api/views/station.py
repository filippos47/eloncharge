import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class StationView(View):

    def get(self, request, station_id, date_from, date_to):

        return JsonResponse({'StationID': station_id, 'PeriodFrom': date_from,
            'PeriodTo': date_to})
