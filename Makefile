CHECK_DIRECTORIES ?= .
TARGETS := example.pdf
FILTER := ./pandoc_minted.py

.PHONY: all
all: $(TARGETS)

.PHONY: check
check:
	uv run ruff format --check $(CHECK_DIRECTORIES)
	uv run ruff check $(CHECK_DIRECTORIES)

.PHONY: format
format:
	uv run ruff format $(CHECK_DIRECTORIES)
	uv run ruff check --fix $(CHECK_DIRECTORIES)

%.tex: %.md $(FILTER)
	pandoc $< -s --filter $(FILTER) -o $@

%.pdf: %.tex
	pdflatex --shell-escape -interaction=batchmode $<
	# Run a second time to resolve cross-references
	pdflatex --shell-escape -interaction=batchmode $<

.PHONY: clean
clean:
	rm -rf *.tex *.pdf *.aux *.log *.out _minted-*
