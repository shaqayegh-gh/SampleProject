#!/usr/bin/env bash

exec poetry run celery -A core.config worker -l INFO