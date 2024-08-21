import os

from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE',
                      'sample_project.config.settings')

app = Celery('sample_project.config')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.autodiscover_tasks()
