import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class PointView(View):

    def get(self, request, point_id, date_from, date_to):

        return JsonResponse({'Point': point_id, 'PeriodFrom': date_from,
            'PeriodTo': date_to})
