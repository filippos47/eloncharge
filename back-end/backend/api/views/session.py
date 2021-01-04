import csv

from django.views import View
from django.http import JsonResponse

class SessionView(View):

    def post(self, request):
        username = request.POST['username']
        password = request.POST['password']

        return JsonResponse({'username': username, 'password': password})

    def delete(self, request):
        return JsonResponse({})
