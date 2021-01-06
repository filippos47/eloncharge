from django.views import View
from django.http import JsonResponse
from django.db import connections
from django.db.utils import OperationalError
from django.contrib.auth.models import User

from api.utils.common import produce_csv_response
from api.models import ChargeSession

class SystemView(View):
    def _check_connectivity(self):
        db_conn = connections['default']
        try:
            c = db_conn.cursor()
        except OperationalError:
            return False
        return True

    def get(self, request):
        if self._check_connectivity():
            status = "OK"
        else:
            status = "failed"

        return JsonResponse({"status": status})

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
        # delete all charge session objects
        if self._check_connectivity():
            ChargeSession.objects.all().delete()

            user = User.objects.get_or_create(username="admin")[0]
            user.set_password("petrol4ever")
            user.save()
            status = "OK"
        else:
            status = "failed"

        return JsonResponse({"status": status})
