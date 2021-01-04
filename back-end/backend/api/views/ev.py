from django.views import View
from django.http import JsonResponse

from api.utils import produce_csv_response

class EVView(View):

    def get(self, request, vehicle_id, date_from, date_to):
        # json is the default format.
        requested_format = self.request.GET.get('format', 'json')

        # If the requested format is not json|csv, we could either return json
        # or some kind of error. Here the first approach is selected.
        if requested_format == 'csv':
            data = [['VehicleID', 'PeriodFrom', 'PeriodTo'],
                    [vehicle_id, date_from, date_to]]
            return produce_csv_response(data)
        else:
            return JsonResponse({'VehicleID': vehicle_id,
                                 'PeriodFrom': date_from,
                                 'PeriodTo': date_to})
