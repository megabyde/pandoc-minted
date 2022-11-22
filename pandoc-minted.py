#!/usr/bin/env python
"""A pandoc filter to use minted for typesetting code in the LaTeX mode."""

from string import Template

from pandocfilters import Header, RawBlock, RawInline, toJSONFilters


def unpack_code(value):
    """Unpack the body and language of a pandoc code element."""
    [[_, classes, attributes], contents] = value

    language = classes[0] if len(classes) > 0 else "text"
    attributes = ", ".join("=".join(x) for x in attributes)

    return {"contents": contents, "language": language, "attributes": attributes}


def fragile(key, value, format, meta):
    """Make headers/frames fragile."""
    if format != "beamer":
        return

    if key == "Header":
        level, meta, contents = value
        # Add the attribute
        meta[1].append("fragile")
        return Header(level, meta, contents)


def minted(key, value, format, meta):
    """Use minted for code in LaTeX."""
    if format != "latex" and format != "beamer":
        return

    if key == "CodeBlock":
        template = Template(
            "\\begin{minted}[$attributes]{$language}\n$contents\n\end{minted}"
        )
        Element = RawBlock
    elif key == "Code":
        template = Template("\\mintinline[$attributes]{$language}{$contents}")
        Element = RawInline
    else:
        return

    text = template.substitute(unpack_code(value))
    return Element("latex", text)


if __name__ == "__main__":
    toJSONFilters([fragile, minted])
