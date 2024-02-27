from django.db import models
from datetime import datetime

# model of todo list
class Task(models.Model):
    title = models.CharField(max_length=100)
    description = models.CharField(max_length=200)
    completed = models.BooleanField(default=False, blank=True, null=True)
    created = models.DateTimeField(default=datetime.now, blank=True)
    updated = models.DateTimeField(default=datetime.now, blank=True)
    objects = models.Manager()
    def __str__(self):
        return self.title