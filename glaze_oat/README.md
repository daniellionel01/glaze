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

```sh
gleam add glaze_oat
```

There are various ways of loading the CSS and JavaScript for the Oat components into your website.

Your approach will depend on wether you use the [Lustre dev tools](https://github.com/lustre-labs/dev-tools), other build tools (Bun / Vite), or want to load everything via a CDN.

### Lustre SPA / Dev Tools

If you are using the [Lustre dev tools](https://github.com/lustre-labs/dev-tools/), you can setup Oat in two ways:

You can link the CSS and JavaScript in the `[tools.lustre.html]` in your `gleam.toml`:

```toml
[tools.lustre.html]
stylesheets = [{ href = "https://unpkg.com/@knadh/oat@0.4.1/oat.min.css" }]
scripts = [{ src = "https://unpkg.com/@knadh/oat@0.4.1/oat.min.js" }]
```

If you are using Tailwind CSS with the Lustre dev tools, you can also import Oat like this:

```sh
curl -L https://unpkg.com/@knadh/oat@0.4.1/oat.min.css \
  -o src/oat.css
```

```css
/* src/app.css */
@import "tailwindcss";
@import "./oat.css";
```

Do not forget the JavaScript:

```toml
[tools.lustre.html]
scripts = [{ src = "https://unpkg.com/@knadh/oat@0.4.1/oat.min.js" }]
```

### Server Application

If your generating the HTML on the server, you can register the CDN with `oat.register`.

```gleam
import glaze/oat
import glaze/oat/theme
import lustre/element/html

pub fn layout() {
  html.html([], [
    html.head([], [
      // ...
      
      oat.register(oat.version),
      theme.style_tag(theme.default_theme()),
    ]),
    html.body([], [
      // ...
    ])
  ])
}
```

## Theming

```gleam
import glaze/oat/theme

let custom_theme =
  theme.default_theme()
  |> theme.set(theme.Primary, "oklch(0.205 0 0)")
```

For a full overview of all available theme variables, take a look at <https://github.com/knadh/oat/blob/master/src/css/01-theme.css>.

## FAQs

### Tailwind?

[Oat](https://oat.ink/) does not use or need [Tailwind](https://tailwindcss.com/). However it does not clash with it in anyway, so you can use it alongside this library with no problems!

### Client vs Server?

This library constructs HTML elements the same way on the client or on the server, so it is compatible in both environments.

## Development

There is a `dev` module that constructs a demo with all available elements and writes it to the GitHub Pages artifact at `docs/glaze_oat/index.html`.

```sh
gleam dev
open ../docs/glaze_oat/index.html
```
