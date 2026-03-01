# Glaze Basecoat

[![Package Version](https://img.shields.io/hexpm/v/glaze_basecoat)](https://hex.pm/packages/glaze_basecoat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_basecoat/)

This is a collection of Lustre components mapped from [Basecoat UI](https://basecoatui.com/).

Basecoat UI is a Tailwind CSS-based component library inspired by shadcn/ui that works with any web stack.

For a full list of components, take a look at <https://hexdocs.pm/glaze_basecoat> or <https://basecoatui.com/components/>

Latest supported version is [Basecoat v0.3.11](https://github.com/hunvreus/basecoat).

GitHub Pages Demo: <https://daniellionel01.github.io/glaze/glaze_basecoat/>

## Getting Started

### Step 1: Installation

```sh
gleam add glaze_basecoat@1
```

### Step 2: Register CSS and JavaScript

```gleam
import glaze_basecoat
html.head([], [
  glaze_basecoat.register(glaze_basecoat.version),
])
```

### Step 3: Register your theme

```gleam
import glaze_basecoat/theme

let my_theme = theme.default_theme()
theme.style_tag(my_theme)
```

## Example

In a real project this might look like this:

```gleam
import glaze_basecoat
import glaze_basecoat/button
import glaze_basecoat/card
import glaze_basecoat/theme
import lustre/element/html
pub fn layout() {
  html.html([], [
    html.head([], [
      glaze_basecoat.register(glaze_basecoat.version),
      theme.style_tag(theme.default_theme()),
    ]),
    html.body([], [
      card.card([], [
        card.header([], [
          card.title([], [html.text("Welcome")]),
          card.description([], [html.text("Hello from Glaze Basecoat!")]),
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

## Tailwind CSS

Basecoat UI is built on Tailwind CSS. You can use Basecoat via CDN or with your own Tailwind configuration.

### CDN

Use `glaze_basecoat.register()` to include everything via CDN.

Note: Basecoat's CDN includes the component classes (like `btn`, `card`, `input`, etc).
Some patterns in Basecoat's docs (like Skeleton) are intentionally just Tailwind utilities.
If you want those utility-only patterns, you must also include Tailwind.

### Tailwind Play CDN

If you use Tailwind's Play CDN (`@tailwindcss/browser`), you also need Basecoat's Tailwind v4
`@theme` mapping so utilities like `bg-accent` exist.

```gleam
import glaze_basecoat
import glaze_basecoat/theme
import lustre/attribute.{attribute}
import lustre/element/html

html.head([], [
  html.script(
    [attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")],
    "",
  ),
  glaze_basecoat.register(glaze_basecoat.version),
  theme.style_tag(theme.default_theme()),
  theme.tailwind_v4_bridge_style_tag(),
])
```

### With Your Tailwind Setup

Use `glaze_basecoat.register_js()` to only include the JavaScript and configure Tailwind yourself.
```css
@import "tailwindcss";
@import "basecoat-css";
```

## Theming

Basecoat uses shadcn/ui compatible CSS variables. You can customize the theme:

```gleam
import glaze_basecoat/theme
let custom_theme =
  theme.default_theme()
  |> theme.set(theme.Primary, "oklch(0.205 0 0)")
  |> theme.set(theme.Radius, "0.5rem")
```

Browse available themes at [ui.shadcn.com/themes](https://ui.shadcn.com/themes).

## Icons

Basecoat uses [Lucide icons](https://lucide.dev). Install lucide and use the icon helper:

```gleam
import glaze_basecoat/icon
// Initialize Lucide
html.head([], [
  icon.init(),
])
// Use icons
icon.plus([])
icon.search([])
```

## FAQs

### Client vs Server?

This library constructs HTML elements the same way on a client or on a server, so it is compatible in both environments.

## Development

There is a `dev` module that constructs a Demo with all available elements and writes it to a `.html` file:
```sh
gleam run -m glaze_basecoat_dev
open basecoat.html
```
