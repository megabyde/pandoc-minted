CHECK_DIRECTORIES ?= .

.PHONY: all
all: check

.PHONY: check
check:
	poetry check -v
	poetry run ruff format --check $(CHECK_DIRECTORIES)
	poetry run ruff check $(CHECK_DIRECTORIES)

.PHONY: format
format:
	poetry run ruff format $(CHECK_DIRECTORIES)
	poetry run ruff check --fix $(CHECK_DIRECTORIES)
