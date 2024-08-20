FROM docker.io/python:3.12.2-slim-bookworm as python

WORKDIR /opt/project

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=.
ENV THENEWBOSTON_SETTING_IN_DOCKER=true

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && pip install pip==22.0.2 \
    && pip install virtualenvwrapper poetry==1.8.3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ["README.md", "Makefile", "./"]

COPY ["poetry.lock", "pyproject.toml", "./"]
RUN poetry install --no-root

COPY scripts/run-django.sh ./
RUN chmod a+x ./run-django.sh

COPY scripts/run-celery.sh ./
RUN chmod a+x ./run-celery.sh

COPY scripts/run-celery-beat.sh ./
RUN chmod a+x ./run-celery-beat.sh

COPY core core