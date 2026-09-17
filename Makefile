CHECK_DIRECTORIES ?= .
FILTER := ./pandoc_minted.py
MODE ?= latex
TARGETS := example.pdf

.PHONY: all
all: $(TARGETS)

.PHONY: check
check:
	uv lock --check
	uv run ruff format --check $(CHECK_DIRECTORIES)
	uv run ruff check $(CHECK_DIRECTORIES)

.PHONY: format
format:
	uv run ruff format $(CHECK_DIRECTORIES)
	uv run ruff check --fix $(CHECK_DIRECTORIES)

%.tex: %.md $(FILTER)
	uv run --frozen --no-dev pandoc $< -s -t $(MODE) --filter $(FILTER) -o $@

%.pdf: %.tex
	uv run --frozen --no-dev pdflatex --shell-escape -interaction=batchmode $<
	# Run a second time to resolve cross-references
	uv run --frozen --no-dev pdflatex --shell-escape -interaction=batchmode $<

.PHONY: clean
clean:
	rm -rf *.aux *.fdb_latexmk *.fls *.log *.nav *.out *.pdf *.snm *.synctex.gz *.tex *.toc *.vrb _minted _minted-* .ruff_cache
