# pandoc-minted

[![CI](https://github.com/megabyde/pandoc-minted/actions/workflows/main.yml/badge.svg)](https://github.com/megabyde/pandoc-minted/actions/workflows/main.yml)

## Overview

A [pandoc](http://pandoc.org) filter to use [minted](https://www.ctan.org/pkg/minted)
for typesetting code in the LaTeX and Beamer modes.

## Requirements

- LaTeX
  - [minted](https://ctan.org/pkg/minted)
- Python 3
  - [pandocfilters](https://pypi.org/project/pandocfilters/)
  - [Pygments](https://pypi.org/project/Pygments/)

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

Due to known issue with Pandoc's temporary file handling (see [#4721](https://github.com/jgm/pandoc/issues/4721)),
it is easiest to generate a TeX file first, then compile it:

```shell
# Generate the TeX file
pandoc example.md -s --filter ./pandoc_minted.py -o example.tex
# Compile with pdflatex (shell escape is required by minted)
pdflatex --shell-escape example.tex
```

## License

- Portions of this project are derived from [pandoc-minted](https://github.com/nick-ulle/pandoc-minted)
  by Nick Ulle, licensed under the ISC License.
- Modifications and additions are licensed under the MIT License.

See the `LICENSE.txt` file for details.
