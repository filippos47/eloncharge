import datetime

from django.db import models
from django.contrib.auth.models import User

from api.utils.common import token_expires_delta

class UserSession(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    token = models.CharField(max_length=255, unique=True)
    expires = models.DateTimeField(null=True)

    def has_expired(self):
        if self.expires < token_expires_delta(past=True):
            return True
        return False
