//// Theme tokens and <style> generation for Oat UI.
////
//// ### Example
////
//// ```gleam
//// import glaze_oat
//// import glaze_oat/theme
////
//// let my_theme =
////   theme.default_theme()
////   |> theme.set(theme.Primary, "light-dark(#334155, #e2e8f0)")
////   |> theme.set(theme.RadiusLarge, "0.875rem")
////
//// html.head([], [
////   glaze_oat.register(glaze_oat.version),
////   theme.style_tag(my_theme),
//// ])
//// ```
////
//// ## CSS values
////
//// Any valid CSS value may be used (`#hex`, `rgb()`, `var(...)`, `clamp(...)`,
//// `light-dark(...)`, unit values such as `rem`, etc).
////

import gleam/dict
import gleam/list
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
  Primary
  PrimaryForeground
  Secondary
  SecondaryForeground
  Muted
  MutedForeground
  Faint
  FaintForeground
  Accent
  Danger
  DangerForeground
  Success
  SuccessForeground
  Warning
  WarningForeground
  Border
  Input
  Ring
  Space1
  Space2
  Space3
  Space4
  Space5
  Space6
  Space8
  Space10
  Space12
  Space14
  Space16
  Space18
  RadiusSmall
  RadiusMedium
  RadiusLarge
  RadiusFull
  BarHeight
  FontSans
  FontMono
  Text1
  Text2
  Text3
  Text4
  Text5
  Text6
  Text7
  Text8
  TextRegular
  LeadingNormal
  FontNormal
  FontMedium
  FontSemibold
  FontBold
  ShadowSmall
  ShadowMedium
  ShadowLarge
  TransitionFast
  Transition
  ZDropdown
  ZModal
}

/// A mapping from `Token` to CSS value.
///
pub opaque type Theme {
  Theme(values: dict.Dict(Token, String))
}

/// Returns Oats default theme.
///
/// This includes sensible defaults for spacing, radius, typography, shadows, transitions, and z-index values.
///
/// Start with this, even if you want to later change all of the colors.
///
pub fn default_theme() -> Theme {
  [
    #(Background, "light-dark(#fff, #09090b)"),
    #(Foreground, "light-dark(#09090b, #fafafa)"),
    #(Card, "light-dark(#fff, #18181b)"),
    #(CardForeground, "light-dark(#09090b, #fafafa)"),
    #(Primary, "light-dark(#574747, #fafafa)"),
    #(PrimaryForeground, "light-dark(#fafafa, #18181b)"),
    #(Secondary, "light-dark(#f4f4f5, #27272a)"),
    #(SecondaryForeground, "light-dark(#574747, #fafafa)"),
    #(Muted, "light-dark(#f4f4f5, #27272a)"),
    #(MutedForeground, "light-dark(#71717a, #a1a1aa)"),
    #(Faint, "light-dark(#fafafa, #1e1e21)"),
    #(FaintForeground, "light-dark(#a1a1aa, #71717a)"),
    #(Accent, "light-dark(#f4f4f5, #27272a)"),
    #(Danger, "light-dark(#d32f2f, #f4807b)"),
    #(DangerForeground, "light-dark(#fafafa, #18181b)"),
    #(Success, "light-dark(#008032, #6cc070)"),
    #(SuccessForeground, "light-dark(#fafafa, #18181b)"),
    #(Warning, "light-dark(#a65b00, #f0a030)"),
    #(WarningForeground, "#09090b"),
    #(Border, "light-dark(#d4d4d8, #52525b)"),
    #(Input, "light-dark(#d4d4d8, #52525b)"),
    #(Ring, "light-dark(#574747, #d4d4d8)"),
    #(Space1, "0.25rem"),
    #(Space2, "0.5rem"),
    #(Space3, "0.75rem"),
    #(Space4, "1rem"),
    #(Space5, "1.25rem"),
    #(Space6, "1.5rem"),
    #(Space8, "2rem"),
    #(Space10, "2.5rem"),
    #(Space12, "3rem"),
    #(Space14, "3.5rem"),
    #(Space16, "4rem"),
    #(Space18, "4.5rem"),
    #(RadiusSmall, "0.125rem"),
    #(RadiusMedium, "0.375rem"),
    #(RadiusLarge, "0.75rem"),
    #(RadiusFull, "9999px"),
    #(BarHeight, "0.5rem"),
    #(FontSans, "system-ui, sans-serif"),
    #(FontMono, "ui-monospace, Consolas, monospace"),
    #(Text1, "clamp(1.75rem, 1.5rem + 1.1vw, 2.25rem)"),
    #(Text2, "clamp(1.5rem, 1.3rem + 0.8vw, 1.875rem)"),
    #(Text3, "clamp(1.25rem, 1.1rem + 0.5vw, 1.5rem)"),
    #(Text4, "clamp(1.125rem, 1.05rem + 0.3vw, 1.25rem)"),
    #(Text5, "1.125rem"),
    #(Text6, "1rem"),
    #(Text7, "0.875rem"),
    #(Text8, "0.75rem"),
    #(TextRegular, "var(--text-6)"),
    #(LeadingNormal, "1.5"),
    #(FontNormal, "400"),
    #(FontMedium, "500"),
    #(FontSemibold, "600"),
    #(FontBold, "600"),
    #(ShadowSmall, "0 1px 2px 0 rgb(0 0 0 / 0.05)"),
    #(
      ShadowMedium,
      "0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1)",
    ),
    #(
      ShadowLarge,
      "0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1)",
    ),
    #(TransitionFast, "120ms cubic-bezier(0.4, 0, 0.2, 1)"),
    #(Transition, "200ms cubic-bezier(0.4, 0, 0.2, 1)"),
    #(ZDropdown, "50"),
    #(ZModal, "200"),
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

pub fn get(theme: Theme, token: Token) -> String {
  let Theme(values:) = theme
  case dict.get(values, token) {
    Ok(value) -> value
    Error(_) -> ""
  }
}

pub fn set(theme: Theme, token: Token, value: String) -> Theme {
  let Theme(values:) = theme
  Theme(values: dict.insert(values, token, value))
}

pub fn set_many(theme: Theme, updates: List(#(Token, String))) -> Theme {
  list.fold(updates, theme, fn(acc, cur) {
    let #(token, value) = cur
    set(acc, token, value)
  })
}

/// Function to update all color-related tokens in one call.
///
/// This is useful when defining a complete palette while keeping spacing,
/// typography, and motion defaults unchanged.
///
/// ### Example
///
/// ```gleam
/// let palette =
///   theme.default_theme()
///   |> theme.set_colors(
///     background: "light-dark(#ffffff, #09090b)",
///     foreground: "light-dark(#09090b, #fafafa)",
///     card: "light-dark(#ffffff, #18181b)",
///     card_foreground: "light-dark(#09090b, #fafafa)",
///     primary: "light-dark(#334155, #e2e8f0)",
///     primary_foreground: "light-dark(#ffffff, #0f172a)",
///     secondary: "light-dark(#f1f5f9, #1f2937)",
///     secondary_foreground: "light-dark(#0f172a, #f8fafc)",
///     muted: "light-dark(#f8fafc, #27272a)",
///     muted_foreground: "light-dark(#64748b, #a1a1aa)",
///     faint: "light-dark(#fafafa, #1e1e21)",
///     faint_foreground: "light-dark(#a1a1aa, #71717a)",
///     accent: "light-dark(#e2e8f0, #334155)",
///     danger: "light-dark(#d32f2f, #f4807b)",
///     danger_foreground: "light-dark(#fafafa, #18181b)",
///     success: "light-dark(#008032, #6cc070)",
///     success_foreground: "light-dark(#fafafa, #18181b)",
///     warning: "light-dark(#a65b00, #f0a030)",
///     warning_foreground: "#09090b",
///     border: "light-dark(#d4d4d8, #52525b)",
///     input: "light-dark(#d4d4d8, #52525b)",
///     ring: "light-dark(#574747, #d4d4d8)",
///   )
/// ```
///
pub fn set_colors(
  on theme: Theme,
  background background: String,
  foreground foreground: String,
  card card: String,
  card_foreground card_foreground: String,
  primary primary: String,
  primary_foreground primary_foreground: String,
  secondary secondary: String,
  secondary_foreground secondary_foreground: String,
  muted muted: String,
  muted_foreground muted_foreground: String,
  faint faint: String,
  faint_foreground faint_foreground: String,
  accent accent: String,
  danger danger: String,
  danger_foreground danger_foreground: String,
  success success: String,
  success_foreground success_foreground: String,
  warning warning: String,
  warning_foreground warning_foreground: String,
  border border: String,
  input input: String,
  ring ring: String,
) -> Theme {
  set_many(theme, [
    #(Background, background),
    #(Foreground, foreground),
    #(Card, card),
    #(CardForeground, card_foreground),
    #(Primary, primary),
    #(PrimaryForeground, primary_foreground),
    #(Secondary, secondary),
    #(SecondaryForeground, secondary_foreground),
    #(Muted, muted),
    #(MutedForeground, muted_foreground),
    #(Faint, faint),
    #(FaintForeground, faint_foreground),
    #(Accent, accent),
    #(Danger, danger),
    #(DangerForeground, danger_foreground),
    #(Success, success),
    #(SuccessForeground, success_foreground),
    #(Warning, warning),
    #(WarningForeground, warning_foreground),
    #(Border, border),
    #(Input, input),
    #(Ring, ring),
  ])
}

/// Render a `<style>` tag that sets all CSS variables from the theme.
///
pub fn style_tag(theme: Theme) -> element.Element(a) {
  style_tag_with_color_scheme(theme, "light dark")
}

/// Render a `<style>` tag that sets all CSS variables from the theme with a custom `color-scheme`.
///
/// For a full list of options for `color_scheme` refer to https://developer.mozilla.org/en-US/docs/Web/CSS/Reference/Properties/color-scheme
///
/// ### Example
///
/// ```gleam
/// theme.style_tag_with_color_scheme(light_theme, "light")
/// theme.style_tag_with_color_scheme(dark_theme, "dark")
/// ```
///
pub fn style_tag_with_color_scheme(
  theme: Theme,
  color_scheme: String,
) -> element.Element(a) {
  html.style(
    [],
    ":root { color-scheme: "
      <> color_scheme
      <> "; "
      <> theme_to_css_variables(theme)
      <> "}",
  )
}

fn theme_to_css_variables(theme: Theme) -> String {
  let Theme(values:) = theme
  values
  |> dict.to_list
  |> list.fold("", fn(acc, cur) {
    let #(token, value) = cur
    case value {
      "" -> acc
      _ -> acc <> "\n" <> token_css_var(token) <> ": " <> value <> ";"
    }
  })
}

fn token_css_var(token: Token) -> String {
  case token {
    Background -> "--background"
    Foreground -> "--foreground"
    Card -> "--card"
    CardForeground -> "--card-foreground"
    Primary -> "--primary"
    PrimaryForeground -> "--primary-foreground"
    Secondary -> "--secondary"
    SecondaryForeground -> "--secondary-foreground"
    Muted -> "--muted"
    MutedForeground -> "--muted-foreground"
    Faint -> "--faint"
    FaintForeground -> "--faint-foreground"
    Accent -> "--accent"
    Danger -> "--danger"
    DangerForeground -> "--danger-foreground"
    Success -> "--success"
    SuccessForeground -> "--success-foreground"
    Warning -> "--warning"
    WarningForeground -> "--warning-foreground"
    Border -> "--border"
    Input -> "--input"
    Ring -> "--ring"
    Space1 -> "--space-1"
    Space2 -> "--space-2"
    Space3 -> "--space-3"
    Space4 -> "--space-4"
    Space5 -> "--space-5"
    Space6 -> "--space-6"
    Space8 -> "--space-8"
    Space10 -> "--space-10"
    Space12 -> "--space-12"
    Space14 -> "--space-14"
    Space16 -> "--space-16"
    Space18 -> "--space-18"
    RadiusSmall -> "--radius-small"
    RadiusMedium -> "--radius-medium"
    RadiusLarge -> "--radius-large"
    RadiusFull -> "--radius-full"
    BarHeight -> "--bar-height"
    FontSans -> "--font-sans"
    FontMono -> "--font-mono"
    Text1 -> "--text-1"
    Text2 -> "--text-2"
    Text3 -> "--text-3"
    Text4 -> "--text-4"
    Text5 -> "--text-5"
    Text6 -> "--text-6"
    Text7 -> "--text-7"
    Text8 -> "--text-8"
    TextRegular -> "--text-regular"
    LeadingNormal -> "--leading-normal"
    FontNormal -> "--font-normal"
    FontMedium -> "--font-medium"
    FontSemibold -> "--font-semibold"
    FontBold -> "--font-bold"
    ShadowSmall -> "--shadow-small"
    ShadowMedium -> "--shadow-medium"
    ShadowLarge -> "--shadow-large"
    TransitionFast -> "--transition-fast"
    Transition -> "--transition"
    ZDropdown -> "--z-dropdown"
    ZModal -> "--z-modal"
  }
}
