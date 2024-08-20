#!/usr/bin/env bash

exec poetry run celery -A core.config beat -l INFO