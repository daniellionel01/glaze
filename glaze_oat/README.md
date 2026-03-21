# 🍩 Glaze Oat

[![Package Version](https://img.shields.io/hexpm/v/glaze_oat)](https://hex.pm/packages/glaze_oat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_oat/)

> This package is part of a larger monorepository with other UI library bindings: <https://github.com/daniellionel01/glaze>

This is a collection of Lustre components mapped from [Oat UI](https://oat.ink/).

It follows [Semantic HTML](https://www.w3schools.com/html/html5_semantic_elements.asp), is very small (~8KB CSS and JS) and themable.

For a full list of components, take a look at <https://hexdocs.pm/glaze_oat> or <https://oat.ink/components/>

Latest supported version is [Oat v0.4.1](https://github.com/knadh/oat/releases/tag/v0.4.1). This library will be updated for future versions when they get released.

GitHub Pages Demo: <https://daniellionel01.github.io/glaze/glaze_oat/>

Example projects:
- [Lustre SPA](https://github.com/daniellionel01/glaze/blob/oat-v3.0.0/examples/lustre_spa/)
- [Wisp server](https://github.com/daniellionel01/glaze/blob/oat-v3.0.0/examples/wisper_server/)

## Getting Started

### Step 1: Installation

```sh
gleam add glaze_oat
```

### Step 2: Register `<style>` and `<script>` tags

```gleam
glaze_oat.register(glaze_oat.version)
```

### Step 3: Register your theme

```gleam
import glaze/oat/theme

let my_theme = theme.default_theme()
theme.style_tag(my_theme)
```

For a full overview of all available theme variables, take a look at <https://github.com/knadh/oat/blob/master/src/css/01-theme.css>.

## Example

In a real project this might look like this:

```gleam
import glaze/oat
import glaze/oat/theme

pub fn layout() {
  html.html([
    html.head([
      // ...
      
      oat.register(oat.version),
      theme.style_tag(theme.default_theme()),
    ]),
    html.body([
      // ...
    ])
  ])
}
```

You can find the full documentation here: <https://hexdocs.pm/glaze_oat>.

Take a look at the [dev module](https://github.com/daniellionel01/glaze/blob/oat-v3.0.0/dev/glaze_oat_dev.gleam) for a kitchen sink of all components and how you might use them!

## FAQs

### Tailwind?

[Oat](https://oat.ink/) does not use or need [Tailwind](https://tailwindcss.com/). However it does not clash with it in anyway, so you can use it along this library with no problems!

### Client vs Server?

This library constructs HTML elements the same way on the client or on the server, so it is compatible in both environments.

## Development

There is a `dev` module that constructs a demo with all available elements and writes it to the GitHub Pages artifact at `docs/glaze_oat/index.html`.

```sh
gleam dev
open ../docs/glaze_oat/index.html
```
