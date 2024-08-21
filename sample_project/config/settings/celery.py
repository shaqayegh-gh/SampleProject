from typing import Dict

CELERY_RESULT_BACKEND = 'amqp://guest:guest@rabbitmq:5672'
CELERY_BROKER_URL = 'amqp://guest:guest@rabbitmq:5672'
CELERY_BROKER_CONNECTION_RETRY_ON_STARTUP = True
CELERY_RESULT_EXPIRES = 3600
CELERY_BEAT_SCHEDULE: Dict[str, str] = {}
