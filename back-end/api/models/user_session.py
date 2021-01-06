import datetime

from django.db import models
from django.contrib.auth.models import User

from api.utils.common import get_now

class UserSession(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    token = models.CharField(max_length=255, unique=True)
    expires = models.DateTimeField(null=True)

    def has_expired(self):
        if self.expires < get_now():
            return True
        return False
