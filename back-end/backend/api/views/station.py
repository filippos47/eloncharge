import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class StationView(View):

    def get(self, request, station_id, date_from, date_to):
        requested_format = self.request.GET.get('format', 'json')

        if requested_format == 'csv':
            csv_response = HttpResponse(content_type='text/csv')
            csv_response['Content-Disposition'] = 'attachment; filename="out.csv"'
            writer = csv.writer(csv_response)
            writer.writerow([station_id, date_from, date_to])
            return csv_response
        else:
            return JsonResponse({'StationID': station_id,
                                 'PeriodFrom': date_from,
                                 'PeriodTo': date_to})
