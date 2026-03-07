# glaze_lumen

[![Package Version](https://img.shields.io/hexpm/v/glaze_lumen)](https://hex.pm/packages/glaze_lumen)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_lumen/)

GitHub Pages Demo: <https://daniellionel01.github.io/glaze/glaze_lumen/>

## Getting Started

### Step 1: Installation

```sh
gleam add glaze_lumen@1
```

## Example

In a real project this might look like this:

```gleam
```

You can find the full documentation here: <https://hexdocs.pm/glaze_lumen>.

Take a look at the [dev module](./dev/glaze_lumen_dev.gleam) for a kitchen sink of all components and how you might use them!

## FAQs

### Client vs Server?

This library constructs HTML elements the same way on the client or on the server, so it is compatible in both environments.

## Development

There is a `dev` module that constructs a demo with all available elements and writes it to the GitHub Pages artifact at `docs/glaze_lumen/index.html`.

```sh
gleam dev
open ../docs/glaze_lumen/index.html
```
