import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class SystemView(View):

    def get(self, request):
        return JsonResponse({})

    def post(self, request):
        updfile = request.FILES['file'].read().decode('utf-8')
        print(updfile)
        updfile_rows = updfile.split("\n")
        print(updfile_rows)

        # This part is not actually needed; we don't have to return the uploaded
        # file. Also, some more formatting work can be done here.
        # https://docs.djangoproject.com/en/3.1/howto/outputting-csv/#using-the-python-csv-library
        csv_response = HttpResponse(content_type='text/csv')
        csv_response['Content-Disposition'] = 'attachment; filename="out.csv"'
        writer = csv.writer(csv_response)
        for index, row in enumerate(updfile_rows):
            writer.writerow([row])

        return csv_response

    def delete(self, request):
        return JsonResponse({})
