#!/usr/bin/env bash

exec poetry run celery -A sample_project.config worker -l INFO