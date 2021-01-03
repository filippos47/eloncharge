import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class EVView(View):

    def get(self, request, vehicle_id, date_from, date_to):
        # json is the default format.
        requested_format = self.request.GET.get('format', 'json')

        # If the requested format is not json|csv, we could either return json
        # or some kind of error. Here the first approach is selected.
        if requested_format == 'csv':
            csv_response = HttpResponse(content_type='text/csv')
            csv_response['Content-Disposition'] = 'attachment; filename="out.csv"'
            writer = csv.writer(csv_response)
            writer.writerow([vehicle_id, date_from, date_to])
            return csv_response
        else:
            return JsonResponse({'VehicleID': vehicle_id,
                                 'PeriodFrom': date_from,
                                 'PeriodTo': date_to})
