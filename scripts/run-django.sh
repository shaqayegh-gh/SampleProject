#!/usr/bin/env bash

set -e

RUN_MANAGE_PY='poetry run python -m sample_project.manage'

echo 'Collecting static files...'
$RUN_MANAGE_PY collectstatic --no-input

echo 'Running migrations...'
$RUN_MANAGE_PY migrate --no-input

exec poetry run uvicorn sample_project.config.asgi:application --port 8000 --host 0.0.0.0