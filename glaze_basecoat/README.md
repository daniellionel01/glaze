# Glaze Basecoat

[![Package Version](https://img.shields.io/hexpm/v/glaze_basecoat)](https://hex.pm/packages/glaze_basecoat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_basecoat/)

> This package is part of a larger monorepository with other UI library bindings: <https://github.com/daniellionel01/glaze>

This is a collection of Lustre components mapped from [Basecoat UI](https://basecoatui.com/).

Basecoat UI is a Tailwind CSS-based component library inspired by shadcn/ui that works with any web stack.

For a full list of components, take a look at either:
- <https://hexdocs.pm/glaze_basecoat>
- <https://basecoatui.com/components/>

Latest supported version is [Basecoat v0.3.11](https://github.com/hunvreus/basecoat).

GitHub Pages Demo: <https://daniellionel01.github.io/glaze/glaze_basecoat/>

Example projects:
- [Lustre SPA](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/examples/lustre_spa/)
- [Wisp server (w/ CDN imports)](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/examples/wisper_server_cdn/)
- [Wisp server (w/ Tailwind CLI)](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/examples/wisper_server_tw_cli/)

## Getting Started

```sh
gleam add glaze_basecoat
```

There are various ways of loading the CSS and JavaScript for the Basecoat components into your website.

Your approach will depend on wether you use the [Lustre dev tools](https://github.com/lustre-labs/dev-tools), other build tools (Bun / Vite), or want to load everything via a CDN.

### Lustre SPA / Dev Tools

If you are using the [Lustre dev tools](https://github.com/lustre-labs/dev-tools/) and are using the built-in tailwind support, you can setup Basecoat in two ways:

You can install the `basecoat-css` package:
```sh
npm/pnpm/bun add basecoat-css
```

And import it in your application css file:
```css
/* src/app.css */
@import "tailwindcss";
@import "basecoat-css";
```

If you install the package, you can create an additional css file to configure your theme: <https://basecoatui.com/installation/#install-theming>

Or create a `src/basecoat.css` file and put the contents of the [basecoat.css](https://cdn.jsdelivr.net/npm/basecoat-css@0.3.11/dist/basecoat.css) and import it in your main css file.

```sh
curl -L https://cdn.jsdelivr.net/npm/basecoat-css@0.3.11/dist/basecoat.css \
  -o src/basecoat.css
```

```css
/* src/app.css */
@import "tailwindcss";
@import "./basecoat.css";

/* optional */
@import "./theme.css";
```

As for the JavaScript, you can link that in the `[tools.lustre.html]` in your `gleam.toml`:

```toml
[tools.lustre.html]
scripts = [{ src = "https://cdn.jsdelivr.net/npm/basecoat-css@0.3.11/dist/js/all.min.js" }]
```

After that you can freely use any Basecoat components:

```gleam
// src/app.gleam

import glaze/basecoat/button
import glaze/basecoat/card
import lustre
import lustre/attribute
import lustre/element/html

pub fn main() {
  let app = lustre.element(view())
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub fn view() {
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
  ])
}
```

#### Note on `[tools.lustre.html]`

*Putting the basecoat.css file in the `[tools.lustre.html]` as a stylesheet will not work with the Tailwind CLI because it bundles everything in `app.css`.*

### Installation via CDN

If you are generating the HTML on the server or provide the layout for your SPA there (f.e. a wisp proxy for your Lustre SPA), you can always fall back to CDN imports for Tailwind or the Basecoat CSS and JavaScript.

```gleam
import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/theme
import lustre/attribute.{attribute}
import lustre/element/html

pub fn page() {
  html.html([], [
    html.head([], [
      html.title([], "Basecoat x Gleam"),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),

      // optional: if you are not using any build tool for working with tailwind
      html.script([attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")], ""),

      basecoat.register(basecoat.version),
      theme.style_tag(theme.default_theme()),
      
      // optional: init built-in theme switcher
      theme_switcher.init_script()
    ]),
    html.body([], [
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
    ]),
  ])
}
```

You can find the full documentation here: <https://hexdocs.pm/glaze_basecoat>.

Take a look at the [dev module](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/dev/glaze_basecoat_dev.gleam) for a kitchen sink of all components and how you might use them!

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

If you are not using the built-in theme module to configure your theme, you can find more documentation on it here: <https://basecoatui.com/installation/#install-theming>.

## FAQs

### What about Icons?

Not strictly necessary, but Basecoat recommends using [Lucide icons](https://lucide.dev).

Lucide docs: <https://lucide.dev/guide/packages/lucide>

### Client vs Server?

This library constructs HTML elements the same way on a client or on a server, so it is compatible in both environments.

Example projects:
- [Lustre SPA](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/examples/lustre_spa/)
- [Wisp server (w/ CDN imports)](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/examples/wisper_server_cdn/)
- [Wisp server (w/ Tailwind CLI)](https://github.com/daniellionel01/glaze/blob/basecoat-v3.0.0/examples/wisper_server_tw_cli/)

## Development

There is a `dev` module that constructs a Demo with all available elements and writes it to a `.html` file:
```sh
gleam dev
open ../docs/glaze_basecoat/index.html
```
