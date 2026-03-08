# Glaze Basecoat

[![Package Version](https://img.shields.io/hexpm/v/glaze_basecoat)](https://hex.pm/packages/glaze_basecoat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_basecoat/)

This is a collection of Lustre components mapped from [Basecoat UI](https://basecoatui.com/).

Basecoat UI is a Tailwind CSS-based component library inspired by shadcn/ui that works with any web stack.

For a full list of components, take a look at <https://hexdocs.pm/glaze_basecoat> or <https://basecoatui.com/components/>

Latest supported version is [Basecoat v0.3.11](https://github.com/hunvreus/basecoat).

GitHub Pages Demo: <https://daniellionel01.github.io/glaze/glaze_basecoat/>

Example Projects: [lustre SPA](./examples/lustre_spa_cdn/), [wisp server](./examples/wisp_server/)

*This package is part of a larger monorepository with other UI library bindings: <https://github.com/daniellionel01/glaze>*

## Getting Started

```sh
gleam add glaze_basecoat@3
```

There are various ways of loading the CSS and JavaScript into .

Your approach will depend on wether you use the [lustre dev tools](https://github.com/lustre-labs/dev-tools), other build tools (Bun / Vite),
or want to insert everything via a CDN.

### Package Manager

```sh
npm/pnpm/bun add basecoat-css
```

```css
/* src/app.css */
@import "tailwindcss";
@import "basecoat-css";
```

```gleam
// src/app.gleam

import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import lustre
import lustre/attribute
import lustre/element
import lustre/element/html

pub fn main() {
  let app = lustre.element(view())
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub fn view() {
  element.fragment([
    // Don't forget about the javascript!
    basecoat.inject_element(basecoat.cdn_script(basecoat.version)),

    html.div([attribute.class("p-10")], [
      card.card([], [
        card.header([], [
          card.title([], [html.text("Welcome")]),
          card.description([], [html.text("Hello!")]),
        ]),
        card.content([], [
          button.button([], [html.text("Get Started")]),
        ]),
      ]),
    ]),
  ])
}
```

[`basecoat.inject_element`](./glaze/basecoat.html#inject_element) is a very handy function, that will append any element to the `<head>` of your document.
In this case we need to load the Basecoat JavaScript.

### Lustre Dev Tools TOML

**This approach is discouraged and will lead to incorrect theming of Basecoat!**

As documented in the [TOML reference](https://hexdocs.pm/lustre_dev_tools/toml-reference.html) for the lustre dev tools, you can provide stylesheets and scripts
that will be included in your `<head>` automatically. You can also statically link the Basecoat CSS and JavaScript files there.

However the interactions between the Tailwind CLI and the ordering of the `<style>` tags seem to mess up the theming of Basecoat and removes a lot of the styling and depth of some of the components.

You can still try this out yourself, but I recommend using [`basecoat.inject_element`](./glaze/basecoat.html#inject_element) or installing the package directly.

```toml
[tools.lustre.html]
stylesheets = [{ href = "https://cdn.jsdelivr.net/npm/basecoat-css@0.3.11/dist/basecoat.cdn.min.css" }]
scripts = [{ src = "https://cdn.jsdelivr.net/npm/basecoat-css@0.3.11/dist/js/all.min.js" }]
```

### Installation via CDN

If you are not using any build tools or client bundling, you can always fallback to direct CDN imports for Tailwind and all Basecoat CSS and JavaScript.

```gleam
import glaze/basecoat
import glaze/basecoat/icon
import glaze/basecoat/theme
import glaze/basecoat/theme_switcher
import lustre/element/html

html.head([], [
  // (Optional) Register Tailwind (if not already coming from your build-tool)
  
  html.script(
    [attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")],
    "",
  ),
  
  // Register Basecoat CSS and JavaScript
  basecoat.register(basecoat.version),
  
  // Register your theme
  theme.style_tag(theme.default_theme()),
  
  // (Optional) Init theme switcher
  theme_switcher.init_script(),
])
```

There are example gleam projects for [lustre spa cdn](./examples/lustre_spa_cdn/) and [wisp server](./examples/wisp_server/) to see a fully fledged setup on server or client.

You can find the full documentation here: <https://hexdocs.pm/glaze_basecoat>.

Take a look at the [dev module](./dev/glaze_basecoat_dev.gleam) for a kitchen sink of all components and how you might use them!

## Theming

Basecoat uses shadcn/ui compatible CSS variables:

```gleam
import glaze/basecoat/theme

let custom_theme =
  theme.default_theme()
  |> theme.set(theme.Primary, "oklch(0.205 0 0)")
  |> theme.set(theme.Radius, "0.5rem")
```

You can find curated themes at [ui.shadcn.com/themes](https://ui.shadcn.com/themes).

You can also use tools like <https://tweakcn.com/editor/theme>!

## FAQs

### What about Icons?

Not strictly necessary, but Basecoat recommends using [Lucide icons](https://lucide.dev).

Lucide docs: <https://lucide.dev/guide/packages/lucide>

### Client vs Server?

This library constructs HTML elements the same way on a client or on a server, so it is compatible in both environments.

## Development

There is a `dev` module that constructs a Demo with all available elements and writes it to a `.html` file:
```sh
gleam dev
open ../docs/glaze_basecoat/index.html
```
