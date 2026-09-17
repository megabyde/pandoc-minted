# pandoc-minted

[![CI](https://github.com/megabyde/pandoc-minted/actions/workflows/main.yml/badge.svg)](https://github.com/megabyde/pandoc-minted/actions/workflows/main.yml)

## Overview

A [pandoc](http://pandoc.org) filter to use [minted](https://www.ctan.org/pkg/minted)
for typesetting code in the LaTeX and Beamer modes.

[View the rendered example](https://megabyde.github.io/pandoc-minted/).

## Requirements

- [Pandoc](https://pandoc.org/)
- A LaTeX distribution with [minted](https://ctan.org/pkg/minted)
- Python 3.10 or later
- [uv](https://docs.astral.sh/uv/)

## Installation

```shell
git clone https://github.com/megabyde/pandoc-minted.git
cd pandoc-minted
uv sync --frozen --no-dev
```

## Usage

> [!IMPORTANT]
> Ensure the LaTeX preamble loads minted by adding this to your Markdown YAML
> header:
>
> ```markdown
> ---
> header-includes:
>   - \usepackage{minted}
> ---
> ```

Generate a PDF directly:

```shell
uv run --frozen --no-dev pandoc example.md \
  --standalone \
  --filter ./pandoc_minted.py \
  --pdf-engine-opt=--shell-escape \
  --output example.pdf
```

Pass `--to beamer` to generate Beamer slides. The filter forwards the code language and
key-value attributes to minted; see [`example.md`](./example.md) for inline and block examples.

> [!WARNING]
> `--shell-escape` allows LaTeX to execute external commands. Compile only trusted documents.

To inspect the generated LaTeX or work around older Pandoc and minted combinations that cannot
compile directly ([pandoc #4721](https://github.com/jgm/pandoc/issues/4721)), use the two-step flow:

```shell
uv run --frozen --no-dev pandoc example.md \
  --standalone \
  --filter ./pandoc_minted.py \
  --output example.tex
pdflatex --shell-escape -interaction=batchmode example.tex
pdflatex --shell-escape -interaction=batchmode example.tex
```

## Development

```shell
make check
make all
make clean
```

Set `MODE=beamer` when building the example to exercise Beamer output.

## License

- Portions of this project are derived from [pandoc-minted](https://github.com/nick-ulle/pandoc-minted)
  by Nick Ulle, licensed under the ISC License.
- Modifications and additions are licensed under the MIT License.

See the [LICENSE](./LICENSE.txt) file for details.
