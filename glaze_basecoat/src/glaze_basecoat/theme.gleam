//// Theme tokens and \<style\> generation for Basecoat UI.
////
//// Basecoat uses shadcn/ui compatible CSS variables for theming.
//// This module provides typed tokens and helpers to generate theme styles.
////
//// ## Example
////
//// ```gleam
//// import glaze_basecoat
//// import glaze_basecoat/theme
////
//// let my_theme =
////   theme.default_theme()
////   |> theme.set(theme.Primary, "oklch(0.205 0 0)")
////   |> theme.set(theme.Radius, "0.5rem")
////
//// html.head([], [
////   glaze_basecoat.register(glaze_basecoat.version),
////   theme.style_tag(my_theme),
//// ])
//// ```
////
//// ## Theming
////
//// You can use any shadcn/ui theme. Visit [ui.shadcn.com/themes](https://ui.shadcn.com/themes)
//// to browse available themes and copy their CSS variables.
////

import gleam/dict
import gleam/list
import gleam/string
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html

/// A typed design token used as a key in a `Theme`.
///
/// Tokens are converted to CSS custom properties (for example `Background -> --background`)
/// when rendering style output.
///
pub type Token {
  Background
  Foreground
  Card
  CardForeground
  Popover
  PopoverForeground
  Primary
  PrimaryForeground
  Secondary
  SecondaryForeground
  Muted
  MutedForeground
  Accent
  AccentForeground
  Destructive
  DestructiveForeground
  Border
  Input
  Ring
  Radius
  Chart1
  Chart2
  Chart3
  Chart4
  Chart5
  Sidebar
  SidebarForeground
  SidebarPrimary
  SidebarPrimaryForeground
  SidebarAccent
  SidebarAccentForeground
  SidebarBorder
  SidebarRing
}

/// A mapping from `Token` to CSS value.
///
pub opaque type Theme {
  Theme(values: dict.Dict(Token, String))
}

/// Returns Basecoat's default theme (shadcn/ui default theme).
///
/// This includes the default color palette and border radius.
/// Start with this and customize as needed.
///
pub fn default_theme() -> Theme {
  [
    #(Background, "oklch(1 0 0)"),
    #(Foreground, "oklch(0.145 0 0)"),
    #(Card, "oklch(1 0 0)"),
    #(CardForeground, "oklch(0.145 0 0)"),
    #(Popover, "oklch(1 0 0)"),
    #(PopoverForeground, "oklch(0.145 0 0)"),
    #(Primary, "oklch(0.205 0 0)"),
    #(PrimaryForeground, "oklch(0.985 0 0)"),
    #(Secondary, "oklch(0.97 0 0)"),
    #(SecondaryForeground, "oklch(0.205 0 0)"),
    #(Muted, "oklch(0.97 0 0)"),
    #(MutedForeground, "oklch(0.556 0 0)"),
    #(Accent, "oklch(0.97 0 0)"),
    #(AccentForeground, "oklch(0.205 0 0)"),
    #(Destructive, "oklch(0.577 0.245 27.325)"),
    #(DestructiveForeground, "oklch(0.985 0 0)"),
    #(Border, "oklch(0.922 0 0)"),
    #(Input, "oklch(0.922 0 0)"),
    #(Ring, "oklch(0.708 0 0)"),
    #(Radius, "0.5rem"),
    #(Chart1, "oklch(0.646 0.222 41.116)"),
    #(Chart2, "oklch(0.6 0.118 184.704)"),
    #(Chart3, "oklch(0.398 0.07 227.392)"),
    #(Chart4, "oklch(0.828 0.189 84.429)"),
    #(Chart5, "oklch(0.769 0.188 70.08)"),
    #(Sidebar, "oklch(0.985 0 0)"),
    #(SidebarForeground, "oklch(0.145 0 0)"),
    #(SidebarPrimary, "oklch(0.205 0 0)"),
    #(SidebarPrimaryForeground, "oklch(0.985 0 0)"),
    #(SidebarAccent, "oklch(0.97 0 0)"),
    #(SidebarAccentForeground, "oklch(0.205 0 0)"),
    #(SidebarBorder, "oklch(0.922 0 0)"),
    #(SidebarRing, "oklch(0.708 0 0)"),
  ]
  |> from_list
}

/// Returns the dark theme variant.
///
/// Use this for dark mode or combine with `default_theme()` using `light-dark()`.
///
pub fn dark_theme() -> Theme {
  [
    #(Background, "oklch(0.145 0 0)"),
    #(Foreground, "oklch(0.985 0 0)"),
    #(Card, "oklch(0.205 0 0)"),
    #(CardForeground, "oklch(0.985 0 0)"),
    #(Popover, "oklch(0.269 0 0)"),
    #(PopoverForeground, "oklch(0.985 0 0)"),
    #(Primary, "oklch(0.922 0 0)"),
    #(PrimaryForeground, "oklch(0.205 0 0)"),
    #(Secondary, "oklch(0.269 0 0)"),
    #(SecondaryForeground, "oklch(0.985 0 0)"),
    #(Muted, "oklch(0.269 0 0)"),
    #(MutedForeground, "oklch(0.708 0 0)"),
    #(Accent, "oklch(0.371 0 0)"),
    #(AccentForeground, "oklch(0.985 0 0)"),
    #(Destructive, "oklch(0.704 0.191 22.216)"),
    #(DestructiveForeground, "oklch(0.985 0 0)"),
    #(Border, "oklch(1 0 0 / 10%)"),
    #(Input, "oklch(1 0 0 / 15%)"),
    #(Ring, "oklch(0.556 0 0)"),
    #(Radius, "0.5rem"),
    #(Chart1, "oklch(0.488 0.243 264.376)"),
    #(Chart2, "oklch(0.696 0.17 162.48)"),
    #(Chart3, "oklch(0.769 0.188 70.08)"),
    #(Chart4, "oklch(0.627 0.265 303.9)"),
    #(Chart5, "oklch(0.645 0.246 16.439)"),
    #(Sidebar, "oklch(0.205 0 0)"),
    #(SidebarForeground, "oklch(0.985 0 0)"),
    #(SidebarPrimary, "oklch(0.488 0.243 264.376)"),
    #(SidebarPrimaryForeground, "oklch(0.985 0 0)"),
    #(SidebarAccent, "oklch(0.269 0 0)"),
    #(SidebarAccentForeground, "oklch(0.985 0 0)"),
    #(SidebarBorder, "oklch(1 0 0 / 10%)"),
    #(SidebarRing, "oklch(0.439 0 0)"),
  ]
  |> from_list
}

/// Construct a `Theme` from a list of token-value pairs.
///
/// If the same token appears multiple times, the last value overrides previous ones.
///
/// ### Example
///
/// ```gleam
/// let t = theme.from_list([
///   #(theme.Primary, "oklch(0.205 0 0)"),
///   #(theme.PrimaryForeground, "oklch(0.985 0 0)"),
/// ])
/// ```
///
pub fn from_list(tokens: List(#(Token, String))) -> Theme {
  let values =
    list.fold(tokens, dict.new(), fn(acc, cur) {
      let #(token, value) = cur
      dict.insert(acc, token, value)
    })
  Theme(values: values)
}

/// Convert a `Theme` into token-value pairs.
///
pub fn to_list(theme: Theme) -> List(#(Token, String)) {
  let Theme(values:) = theme
  dict.to_list(values)
}

/// Get a token value from a theme.
///
pub fn get(theme: Theme, token: Token) -> String {
  let Theme(values:) = theme
  case dict.get(values, token) {
    Ok(value) -> value
    Error(_) -> ""
  }
}

/// Set a token value in a theme.
///
pub fn set(theme: Theme, token: Token, value: String) -> Theme {
  let Theme(values:) = theme
  Theme(values: dict.insert(values, token, value))
}

/// Set multiple token values in a theme.
///
pub fn set_many(theme: Theme, updates: List(#(Token, String))) -> Theme {
  list.fold(updates, theme, fn(acc, cur) {
    let #(token, value) = cur
    set(acc, token, value)
  })
}

/// Render a `<style>` tag that sets all CSS variables from the theme.
///
pub fn style_tag(theme: Theme) -> element.Element(a) {
  html.style([], ":root {\n" <> theme_to_css_variables(theme) <> "}")
}

/// Render a `<style>` tag with both light and dark theme variants.
///
/// This generates CSS that automatically switches between themes
/// based on the `color-scheme` or `prefers-color-scheme` media query.
///
pub fn style_tag_light_dark(light: Theme, dark: Theme) -> element.Element(a) {
  html.style(
    [],
    ":root {\n"
      <> theme_to_css_variables(light)
      <> "}\n\n"
      <> ".dark {\n"
      <> theme_to_css_variables(dark)
      <> "}",
  )
}

/// Render a `<style type="text/tailwindcss">` tag containing Basecoat's
/// Tailwind v4 `@theme` mapping.
///
/// This is only needed when using Tailwind's Play CDN (`@tailwindcss/browser`).
/// In build-time Tailwind setups (Tailwind CLI/PostCSS/Vite/etc), this mapping
/// comes from `@import "basecoat-css";`.
///
/// Basecoat defines design tokens like `--accent` and Tailwind generates utility
/// classes like `bg-accent` from theme variables like `--color-accent`. This
/// mapping bridges the two.
///
pub fn tailwind_v4_bridge_style_tag() -> element.Element(a) {
  html.style([attribute("type", "text/tailwindcss")], tailwind_v4_bridge_css())
}

/// The Tailwind v4 `@theme` mapping used by Basecoat.
///
/// This matches the `@theme` block in Basecoat's `src/css/basecoat.css`.
///
pub fn tailwind_v4_bridge_css() -> String {
  "@theme {\n"
  <> "  --color-background: var(--background);\n"
  <> "  --color-foreground: var(--foreground);\n"
  <> "  --color-card: var(--card);\n"
  <> "  --color-card-foreground: var(--card-foreground);\n"
  <> "  --color-popover: var(--popover);\n"
  <> "  --color-popover-foreground: var(--popover-foreground);\n"
  <> "  --color-primary: var(--primary);\n"
  <> "  --color-primary-foreground: var(--primary-foreground);\n"
  <> "  --color-secondary: var(--secondary);\n"
  <> "  --color-secondary-foreground: var(--secondary-foreground);\n"
  <> "  --color-muted: var(--muted);\n"
  <> "  --color-muted-foreground: var(--muted-foreground);\n"
  <> "  --color-accent: var(--accent);\n"
  <> "  --color-accent-foreground: var(--accent-foreground);\n"
  <> "  --color-destructive: var(--destructive);\n"
  <> "  --color-border: var(--border);\n"
  <> "  --color-input: var(--input);\n"
  <> "  --color-ring: var(--ring);\n"
  <> "  --color-chart-1: var(--chart-1);\n"
  <> "  --color-chart-2: var(--chart-2);\n"
  <> "  --color-chart-3: var(--chart-3);\n"
  <> "  --color-chart-4: var(--chart-4);\n"
  <> "  --color-chart-5: var(--chart-5);\n"
  <> "  --color-sidebar: var(--sidebar);\n"
  <> "  --color-sidebar-foreground: var(--sidebar-foreground);\n"
  <> "  --color-sidebar-primary: var(--sidebar-primary);\n"
  <> "  --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);\n"
  <> "  --color-sidebar-accent: var(--sidebar-accent);\n"
  <> "  --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);\n"
  <> "  --color-sidebar-border: var(--sidebar-border);\n"
  <> "  --color-sidebar-ring: var(--sidebar-ring);\n"
  <> "}\n"
}

fn theme_to_css_variables(theme: Theme) -> String {
  let Theme(values:) = theme
  values
  |> dict.to_list
  |> list.sort(by: fn(a, b) {
    let #(token_a, _) = a
    let #(token_b, _) = b
    string.compare(token_css_var(token_a), token_css_var(token_b))
  })
  |> list.fold("", fn(acc, cur) {
    let #(token, value) = cur
    case value {
      "" -> acc
      _ -> acc <> "  " <> token_css_var(token) <> ": " <> value <> ";\n"
    }
  })
}

fn token_css_var(token: Token) -> String {
  case token {
    Background -> "--background"
    Foreground -> "--foreground"
    Card -> "--card"
    CardForeground -> "--card-foreground"
    Popover -> "--popover"
    PopoverForeground -> "--popover-foreground"
    Primary -> "--primary"
    PrimaryForeground -> "--primary-foreground"
    Secondary -> "--secondary"
    SecondaryForeground -> "--secondary-foreground"
    Muted -> "--muted"
    MutedForeground -> "--muted-foreground"
    Accent -> "--accent"
    AccentForeground -> "--accent-foreground"
    Destructive -> "--destructive"
    DestructiveForeground -> "--destructive-foreground"
    Border -> "--border"
    Input -> "--input"
    Ring -> "--ring"
    Radius -> "--radius"
    Chart1 -> "--chart-1"
    Chart2 -> "--chart-2"
    Chart3 -> "--chart-3"
    Chart4 -> "--chart-4"
    Chart5 -> "--chart-5"
    Sidebar -> "--sidebar"
    SidebarForeground -> "--sidebar-foreground"
    SidebarPrimary -> "--sidebar-primary"
    SidebarPrimaryForeground -> "--sidebar-primary-foreground"
    SidebarAccent -> "--sidebar-accent"
    SidebarAccentForeground -> "--sidebar-accent-foreground"
    SidebarBorder -> "--sidebar-border"
    SidebarRing -> "--sidebar-ring"
  }
}
