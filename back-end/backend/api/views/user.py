import csv

from django.views import View
from django.http import JsonResponse, HttpResponse

class UserView(View):

    def post(self, request, username, password):
        return JsonResponse({'username': username, 'password': password})

    def get(self, request, username):
        return JsonResponse({'username': username})
