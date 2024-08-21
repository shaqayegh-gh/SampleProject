.PHONY: run-server
run-server:
	poetry run python -m sample_project.manage runserver


.PHONY: migrate
migrate:
	poetry run python -m sample_project.manage migrate

.PHONY: migrations
migrations:
	poetry run python -m sample_project.manage makemigrations

.PHONY: superuser
superuser:
	poetry run python -m sample_project.manage createsuperuser

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
	poetry run celery -A sample_project.config worker -l INFO


.PHONY: run-celery-beat
run-celery-beat:
	poetry run celery -A sample_project.config beat -l INFO

.PHONY: shell
shell:
	poetry run python -m sample_project.manage shell

.PHONY: dbshell
dbshell:
	poetry run python -m sample_project.manage dbshell

.PHONY: update
update: install migrate install-pre-commit ;


.PHONY: test
test:
	poetry run pytest -v -rs --show-capture=no

.PHONY: test-detailed
test-detailed:
	poetry run pytest -vv -rs -s

.PHONY: lint-and-test
lint-and-test: lint test ;


.PHONY: build
build:
	# We are not building with Docker compose on purpose, so we can have just one image (and probably save disk space)
	docker build . -t sample-project-backend:current --no-cache

.PHONY: update-docker-compose-yaml
update-docker-compose-yaml:
	cp docker-compose.yml ~/

.PHONY: docker-compose-down
docker-compose-down:
	cd; docker compose down

.PHONY: run-production
run-production:  # purposefully do not depend on `build` target
	cd; docker compose up -d --no-build --force-recreate


.PHONY: deploy
deploy: build docker-compose-down update-docker-compose-yaml run-production;

.PHONY: deploy-cleanup
deploy-cleanup:
	docker image prune -f
	docker builder prune -f


.PHONY: run-development
run-development: build
	# docker-compose.yml is inherited and overridden by docker-compose.dev.yml
	docker compose -f docker-compose.yml -f docker-compose.dev.yml up -d --force-recreate
