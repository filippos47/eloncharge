import csv
import codecs

from django.views import View
from django.http import HttpResponse, JsonResponse
from django.db import connections
from django.db.utils import OperationalError
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

from api.utils.common import produce_csv_response
from api.utils.auth import authenticated
from api.models import ChargeSession, Car, Point, Pricing

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

    @authenticated(superuser=True)
    def post(self, request, user):
        if not request.POST.get('file', None) and not request.FILES.get('file', None):
            return HttpResponse("No file provided", status=400)

        f = request.POST['file'] if request.POST.get('file') else request.FILES['file']

        cnt_sessions = 0
        cnt_imported = 0

        reader = csv.reader(codecs.iterdecode(f, 'utf-8'), delimiter=",")
        for row in reader:
            cnt_sessions += 1
            # CSV Format: ENERGY_DELIVERED,TOTAL_COST,START,END,PAYMENT,PROTOCOL,CAR_ID,POINT_ID,PRICING_ID
            energy_delivered = row[0]
            total_cost = row[1]
            start = row[2]
            end = row[3]
            payment_type = row[4]
            protocol_type = row[5]
            car_id = row[6]
            point_id = row[7]
            pricing_id = row[8]

            try:
                car = Car.objects.get(id=int(car_id))
                point = Point.objects.get(id=int(point_id))
                pricing = Pricing.objects.get(id=int(pricing_id))
            except ObjectDoesNotExist:
                return HttpResponse("Invalid ids provided", status=400)

            try:
                cs = ChargeSession.objects.get(start=start, end=end, car_id=car, point_id=point)
            except ObjectDoesNotExist:
                cs = ChargeSession.objects.create(
                        car_id=car, point_id=point, pricing_id=pricing,
                        energy_delivered=energy_delivered, total_cost=total_cost,
                        start=start, end=end,
                        payment=payment_type, protocol=protocol_type)
                cs.save()
                cnt_imported += 1

        cnt_all = ChargeSession.objects.all().count()

        return JsonResponse({
            "SessionsInUploadedFile": cnt_sessions,
            "SessionsImported": cnt_imported,
            "TotalSessionsInDatabase": cnt_all})

    def delete(self, request):
        # delete all charge session objects
        if self._check_connectivity():
            ChargeSession.objects.all().delete()
            User.objects.filter(username="admin").delete()

            user = User.objects.create_superuser("admin", \
                                                 password="petrol4ever")
            user.save()
            status = "OK"
        else:
            status = "failed"

        return JsonResponse({"status": status})
