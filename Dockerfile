FROM docker.io/python:3.12.2-slim-bookworm

WORKDIR /opt/project

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=.
ENV SAMPLE_PROJECT_SETTING_IN_DOCKER=true

EXPOSE 8000

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && pip install pip==24.2 \
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


COPY sample_project sample_project