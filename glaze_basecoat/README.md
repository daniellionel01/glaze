# Glaze Basecoat

[![Package Version](https://img.shields.io/hexpm/v/glaze_basecoat)](https://hex.pm/packages/glaze_basecoat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_basecoat/)

This is a collection of Lustre components mapped from [Basecoat UI](https://basecoatui.com/).
Basecoat UI is a Tailwind CSS-based component library inspired by shadcn/ui that works with any web stack.
For a full list of components, take a look at <https://hexdocs.pm/glaze_basecoat> or <https://basecoatui.com/components/>
Latest supported version is [Basecoat v0.3.11](https://github.com/hunvreus/basecoat).
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
### Step 3: Add Theme (Optional)
```gleam
import glaze_basecoat/theme
let my_theme = theme.default_theme()
theme.style_tag(my_theme)
```
## Example
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
## Components
| Component | Status | Documentation |
|-----------|--------|---------------|
| Accordion | ✅ | [Basecoat](https://basecoatui.com/components/accordion) |
| Alert | ✅ | [Basecoat](https://basecoatui.com/components/alert) |
| Alert Dialog | ✅ | [Basecoat](https://basecoatui.com/components/alert-dialog) |
| Avatar | ✅ | [Basecoat](https://basecoatui.com/components/avatar) |
| Badge | ✅ | [Basecoat](https://basecoatui.com/components/badge) |
| Breadcrumb | ✅ | [Basecoat](https://basecoatui.com/components/breadcrumb) |
| Button | ✅ | [Basecoat](https://basecoatui.com/components/button) |
| Button Group | ✅ | [Basecoat](https://basecoatui.com/components/button-group) |
| Card | ✅ | [Basecoat](https://basecoatui.com/components/card) |
| Checkbox | ✅ | [Basecoat](https://basecoatui.com/components/checkbox) |
| Command | ✅ | [Basecoat](https://basecoatui.com/components/command) |
| Dialog | ✅ | [Basecoat](https://basecoatui.com/components/dialog) |
| Dropdown Menu | ✅ | [Basecoat](https://basecoatui.com/components/dropdown-menu) |
| Empty | ✅ | [Basecoat](https://basecoatui.com/components/empty) |
| Field | ✅ | [Basecoat](https://basecoatui.com/components/field) |
| Form | ✅ | [Basecoat](https://basecoatui.com/components/form) |
| Input | ✅ | [Basecoat](https://basecoatui.com/components/input) |
| Item | ✅ | [Basecoat](https://basecoatui.com/components/item) |
| Kbd | ✅ | [Basecoat](https://basecoatui.com/components/kbd) |
| Label | ✅ | [Basecoat](https://basecoatui.com/components/label) |
| Pagination | ✅ | [Basecoat](https://basecoatui.com/components/pagination) |
| Popover | ✅ | [Basecoat](https://basecoatui.com/components/popover) |
| Progress | ✅ | [Basecoat](https://basecoatui.com/components/progress) |
| Radio Group | ✅ | [Basecoat](https://basecoatui.com/components/radio-group) |
| Select | ✅ | [Basecoat](https://basecoatui.com/components/select) |
| Sidebar | ✅ | [Basecoat](https://basecoatui.com/components/sidebar) |
| Skeleton | ✅ | [Basecoat](https://basecoatui.com/components/skeleton) |
| Slider | ✅ | [Basecoat](https://basecoatui.com/components/slider) |
| Spinner | ✅ | [Basecoat](https://basecoatui.com/components/spinner) |
| Switch | ✅ | [Basecoat](https://basecoatui.com/components/switch) |
| Table | ✅ | [Basecoat](https://basecoatui.com/components/table) |
| Tabs | ✅ | [Basecoat](https://basecoatui.com/components/tabs) |
| Textarea | ✅ | [Basecoat](https://basecoatui.com/components/textarea) |
| Theme Switcher | ✅ | [Basecoat](https://basecoatui.com/components/theme-switcher) |
| Toast | ✅ | [Basecoat](https://basecoatui.com/components/toast) |
| Tooltip | ✅ | [Basecoat](https://basecoatui.com/components/tooltip) |
## Tailwind CSS
Basecoat UI is built on Tailwind CSS. You can use Basecoat via CDN (recommended for quick setup) or with your own Tailwind configuration.
### CDN (Recommended)
Use `glaze_basecoat.register()` to include everything via CDN.
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
