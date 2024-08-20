.PHONY: run-server
run-server:
	poetry run python -m core.manage runserver


.PHONY: migrate
migrate:
	poetry run python -m core.manage migrate

.PHONY: migrations
migrations:
	poetry run python -m core.manage makemigrations

.PHONY: superuser
superuser:
	poetry run python -m core.manage createsuperuser

.PHONY: install
install:
	poetry install

.PHONY: install-pre-commit
install-pre-commit:
	poetry run pre-commit uninstall; poetry run pre-commit install


.PHONY: lint
lint:
	poetry run pre-commit run --all-files

.PHONY: run-celery
run-celery:
	poetry run celery -A thenewboston.project worker -l INFO


.PHONY: run-celery-beat
run-celery-beat:
	poetry run celery -A thenewboston.project beat -l INFO

.PHONY: shell
shell:
	poetry run python -m thenewboston.manage shell

.PHONY: dbshell
dbshell:
	poetry run python -m thenewboston.manage dbshell

.PHONY: update
update: install migrate install-pre-commit ;
