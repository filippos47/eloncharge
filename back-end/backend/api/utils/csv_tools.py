import csv

from django.http import HttpResponse

def produce_csv_response(data):
    # data: list of lists

    csv_response = HttpResponse(content_type='text.csv')
    csv_response['Content-Disposition'] = 'attachment; filename="out.csv"'
    writer = csv.writer(csv_response)
    writer.writerows(data)

    return csv_response
