from django.db import models
from django.contrib.auth.models import User

class UserSession(models.Model):
    user_id = models.ForeignKey(User, on_delete=models.CASCADE)
    # create tokens with base64.b64encode(os.urandom(64))
    token = models.CharField(max_length=255)
    expires = models.DateTimeField(null=True)
