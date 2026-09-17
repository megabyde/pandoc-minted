---
title: pandoc-minted example
header-includes:
  - \usepackage{minted}
---

# Inline code

Inline code can specify its language: `print("Hello, world!")`{.python}.

# Code blocks

Code-block attributes are passed to minted as options:

```{.python linenos=true breaklines=true}
def greet(name: str) -> None:
    print(f"Hello, {name}!")


greet("world")
```
