from django.views import View
from django.http import JsonResponse

from api.utils.common import produce_csv_response

class SystemView(View):
    def get(self, request):
        return JsonResponse({})

    def post(self, request):
        # Uploaded csv file is first read into a byte-like object.
        # Then, it is decoded into a string and split at every newline.
        updfile = request.FILES['file'].read().decode('utf-8').split("\n")

        # Now, each row of the resulting file forms a list. The list contains
        # all of its elements seperated by commas. Each element is stripped of
        # whitespaces and quotation marks.
        data = []
        for index, row in enumerate (updfile):
            if row.strip() != '':
                data.append([word.strip('" ') for word in row.split(',')])
        return produce_csv_response(data)

    def delete(self, request):
        return JsonResponse({})
