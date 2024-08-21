"""
Settings specific to this application only (no Django or third party settings)
"""

IN_DOCKER = False

LOGGING_MIDDLEWARE_SKIPPED_REQUEST_MEDIA_TYPES = ('multipart/form-data', )
LOGGING_MIDDLEWARE_SKIPPED_RESPONSE_MEDIA_TYPES = ('text/html',
                                                   'text/javascript')
