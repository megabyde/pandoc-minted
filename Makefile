CHECK_DIRECTORIES ?= .

.PHONY: all
all: check

.PHONY: check
check:
	poetry check -v
	poetry run black --check $(CHECK_DIRECTORIES)
	poetry run isort -c $(CHECK_DIRECTORIES)
	poetry run flake8 $(CHECK_DIRECTORIES)

.PHONY: format
format:
	poetry run black $(CHECK_DIRECTORIES)
	poetry run isort $(CHECK_DIRECTORIES)
