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

### Decision Matrix

| Scenario | CSS | JS | Use these functions |
| --- | --- | --- | --- |
| Quick start (no Tailwind setup) | Basecoat compiled CSS via CDN (`basecoat.cdn.min.css`) | All Basecoat JS via CDN (`all.min.js`) | `glaze_basecoat.register(version)` + `theme.style_tag(...)` |
| Use Tailwind Play CDN in the browser | Tailwind Play CDN + Basecoat CSS via CDN | All Basecoat JS via CDN | Tailwind `<script ...@tailwindcss/browser@4>` + `glaze_basecoat.register(version)` + `theme.style_tag(...)` + `theme.tailwind_v4_bridge_style_tag()` |
| You have build-time Tailwind (Tailwind CLI/PostCSS/Vite) | Your Tailwind build output (with `@import "basecoat-css"`) | Basecoat JS via CDN | `glaze_basecoat.register_js(version)` (or `register_component(version, "tabs")`) + `theme.style_tag(...)` |
| You want to manage CSS/JS separately (still CDN) | Basecoat compiled CSS via CDN | Only specific JS components via CDN | `glaze_basecoat.register_css(version)` + `glaze_basecoat.register_component(version, "popover")` |

### CDN

Use `glaze_basecoat.register()` to include everything via CDN.

### Tailwind CDN

If you use Tailwind's CDN (<https://tailwindcss.com/docs/installation/play-cdn>), you also need Basecoat's Tailwind v4
`@theme` mapping so utilities like `bg-accent` exist.

If you have a build-time Tailwind setup, you do not need this bridge (it comes from `@import "basecoat-css"`).

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

If you have a build-time Tailwind setup (Tailwind CLI/PostCSS/Vite/etc) and you install Basecoat from npm, you can import Basecoat directly in your Tailwind entry CSS.

```sh
npm install basecoat-css
```

```css
@import "tailwindcss";
@import "basecoat-css";
```

In this case you should not use `glaze_basecoat.register()`, since it also includes Basecoat's CSS from the CDN.
Use `glaze_basecoat.register_js()` (or `glaze_basecoat.register_component()`) to only include the JavaScript and let your Tailwind build produce the CSS.

```gleam
import glaze_basecoat
import glaze_basecoat/theme
import lustre/attribute.{attribute}
import lustre/element/html

html.head([], [
  glaze_basecoat.register_js(glaze_basecoat.version),
  theme.style_tag(theme.default_theme()),
])
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

You can also use tools like <https://tweakcn.com/editor/theme>!

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
gleam dev
open ../docs/glaze_basecoat/index.html
```
