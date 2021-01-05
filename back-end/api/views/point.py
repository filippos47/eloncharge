from django.views import View
from django.http import JsonResponse

from api.utils.common import produce_csv_response

class PointView(View):

    def get(self, request, point_id, date_from, date_to):
        requested_format = self.request.GET.get('format', 'json')

        if requested_format == 'csv':
            data = [['PointID', 'PeriodFrom', 'PeriodTo'],
                    [point_id, date_from, date_to]]
            return produce_csv_response(data)
        else:
            return JsonResponse({'PointID': point_id,
                                 'PeriodFrom': date_from,
                                 'PeriodTo': date_to})
