# Glaze Basecoat

[![Package Version](https://img.shields.io/hexpm/v/glaze_basecoat)](https://hex.pm/packages/glaze_basecoat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_basecoat/)

This is a collection of Lustre components mapped from [Basecoat UI](https://basecoatui.com/).

Basecoat UI is a Tailwind CSS-based component library inspired by shadcn/ui that works with any web stack.

For a full list of components, take a look at <https://hexdocs.pm/glaze_basecoat> or <https://basecoatui.com/components/>

Latest supported version is [Basecoat v0.3.11](https://github.com/hunvreus/basecoat).

GitHub Pages Demo: <https://daniellionel01.github.io/glaze/glaze_basecoat/>

*This package is part of a larger monorepository with other UI library bindings: <https://github.com/daniellionel01/glaze>*

## Getting Started

```sh
gleam add glaze_basecoat@1
```

### Build Step

If you are using any kind of build step (Lustre Dev Tools / Tailwind CLI / Vite), you can setup Basecoat by installing it via a package manager.

Don't forget to setup the JavaScript, too!

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
import lustre/element/html


pub fn main() {
  basecoat.append_cdn_script_to_head(basecoat.version)
  
  let app = lustre.element(view())
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil 
}

pub fn view() {
  card.card([], [
    card.header([], [
      card.title([], [html.text("Welcome")]),
      card.description([], [html.text("Hello!")]),
    ]),
    card.content([], [
      button.button([], [html.text("Get Started")]),
    ]),
  ])
}
```

Alternatively you can run a function that hooks into the 

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

### Example

In a real project this might look like this:

```gleam
import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/theme
import lustre/element/html

pub fn layout() {
  html.html([], [
    html.head([], [
      // ...
      
      theme_switcher.init_script(),
      
      html.script(
        [attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")],
        "",
      ),
      theme.tailwind_v4_bridge_style_tag(),
      
      basecoat.register(basecoat.version),
      theme.style_tag(theme.default_theme()),
    ]),
    html.body([], [
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
