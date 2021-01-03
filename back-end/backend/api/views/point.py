import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class PointView(View):

    def get(self, request, point_id, date_from, date_to):
        requested_format = self.request.GET.get('format', 'json')

        if requested_format == 'csv':
            csv_response = HttpResponse(content_type='text/csv')
            csv_response['Content-Disposition'] = 'attachment; filename="out.csv"'
            writer = csv.writer(csv_response)
            writer.writerow([point_id, date_from, date_to])
            return csv_response
        else:
            return JsonResponse({'PointID': point_id,
                                 'PeriodFrom': date_from,
                                 'PeriodTo': date_to})
