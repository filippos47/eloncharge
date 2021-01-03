import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class SystemView(View):

    def get(self, request):

        return JsonResponse({})

    def post(self, request):

        updfile = request.data.get('file')
        response = HttpResponse(content_type='text/csv')
        writer = csv.writer(response)

        with open(updfile) as csv_file:
            reader = csv.reader(csv_file)
            for row in reader:
                writer.writerow(row)

        return response

    def delete(self, request):

        return JsonResponse({})
