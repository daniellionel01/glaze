# glaze_oat

[![Package Version](https://img.shields.io/hexpm/v/glaze_oat)](https://hex.pm/packages/glaze_oat)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/glaze_oat/)

```sh
gleam add glaze_oat@1
```

## Getting Started

- **Step 1:** `glaze_oat.register(glaze_oat.version)`
- **Step 2:** `theme.style_tag(YOUR_THEME)`
- **Step 3:** Done!

In a real project this might look like this:

```gleam
import glaze_oat
import glaze_oat/theme

pub fn layout() {
  html.html([
    html.head([
      // ...
      
      glaze_oat.register(glaze_oat.version),
      theme.style_tag(theme.default_theme),
    ]),
    html.body([
      // ...
    ])
  ])
}
```

Further documentation can be found at <https://hexdocs.pm/glaze_oat>.

## Development

There is a `dev` module, that constructs a Demo with all available elements and writes it to a `.html` file, that you can simply open in your browser and inspect.

```sh
gleam dev
open oat.html
```
