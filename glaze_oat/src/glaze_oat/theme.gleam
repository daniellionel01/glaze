import gleam/list
import lustre/element
import lustre/element/html

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
}

pub opaque type Theme {
  Theme(
    background: String,
    foreground: String,
    card: String,
    card_foreground: String,
    primary: String,
    primary_foreground: String,
    secondary: String,
    secondary_foreground: String,
    muted: String,
    muted_foreground: String,
    faint: String,
    faint_foreground: String,
    accent: String,
    danger: String,
    danger_foreground: String,
    success: String,
    success_foreground: String,
    warning: String,
    warning_foreground: String,
    border: String,
    input: String,
    ring: String,
    // === === ===
    space_1: String,
    space_2: String,
    space_3: String,
    space_4: String,
    space_5: String,
    space_6: String,
    space_8: String,
    space_10: String,
    space_12: String,
    space_14: String,
    space_16: String,
    space_18: String,
    //
    radius_small: String,
    radius_medium: String,
    radius_large: String,
    radius_full: String,
    //
    bar_height: String,
    //
    font_sans: String,
    font_mono: String,
  )
}

pub fn default_theme() -> Theme {
  Theme(
    background: "#fff",
    foreground: "#09090b",
    card: "#fff",
    card_foreground: "#09090b",
    primary: "#574747",
    primary_foreground: "#fafafa",
    secondary: "#f4f4f5",
    secondary_foreground: "#574747",
    muted: "#f4f4f5",
    muted_foreground: "#71717a",
    faint: "#fafafa",
    faint_foreground: "#a1a1aa",
    accent: "#f4f4f5",
    danger: "#df514c",
    danger_foreground: "#fafafa",
    success: "#4caf50",
    success_foreground: "#fafafa",
    warning: "#ff8c00",
    warning_foreground: "#09090b",
    border: "#d4d4d8",
    input: "#d4d4d8",
    ring: "#574747",
    // === === ===
    space_1: todo,
    space_2: todo,
    space_3: todo,
    space_4: todo,
    space_5: todo,
    space_6: todo,
    space_8: todo,
    space_10: todo,
    space_12: todo,
    space_14: todo,
    space_16: todo,
    space_18: todo,
    //
    radius_small: todo,
    radius_medium: todo,
    radius_large: todo,
    radius_full: todo,
    //
    bar_height: todo,
    //
    font_sans: todo,
    font_mono: todo,
  )
}

pub fn style_tag(theme: Theme, color_schema: String) -> element.Element(a) {
  html.style(
    [],
    ":root { color-schema: "
      <> color_schema
      <> "; "
      <> theme_to_css_variables(theme)
      <> "}",
  )
}

fn theme_to_css_variables(theme: Theme) -> String {
  let Theme(
    background:,
    foreground:,
    card:,
    card_foreground:,
    primary:,
    primary_foreground:,
    secondary:,
    secondary_foreground:,
    muted:,
    muted_foreground:,
    faint:,
    faint_foreground:,
    accent:,
    danger:,
    danger_foreground:,
    success:,
    success_foreground:,
    warning:,
    warning_foreground:,
    border:,
    input:,
    ring:,
    space_1:,
    space_2:,
    space_3:,
    space_4:,
    space_5:,
    space_6:,
    space_8:,
    space_10:,
    space_12:,
    space_14:,
    space_16:,
    space_18:,
    radius_small:,
    radius_medium:,
    radius_large:,
    radius_full:,
    bar_height:,
    font_sans:,
    font_mono:,
  ) = theme
  [
    #("--background", background),
    #("--foreground", foreground),
    #("--card", card),
    #("--card_foreground", card_foreground),
    #("--primary", primary),
    #("--primary_foreground", primary_foreground),
    #("--secondary", secondary),
    #("--secondary_foreground", secondary_foreground),
    #("--muted", muted),
    #("--muted_foreground", muted_foreground),
    #("--faint", faint),
    #("--faint-foreground", faint_foreground),
    #("--accent", accent),
    #("--danger", danger),
    #("--danger_foreground", danger_foreground),
    #("--success", success),
    #("--success_foreground", success_foreground),
    #("--warning", warning),
    #("--warning_foreground", warning_foreground),
    #("--border", border),
    #("--input", input),
    #("--ring", ring),
    #("--space-1", space_1),
    #("--space-2", space_2),
    #("--space-3", space_3),
    #("--space-4", space_4),
    #("--space-5", space_5),
    #("--space-6", space_6),
    #("--space-8", space_8),
    #("--space-10", space_10),
    #("--space-12", space_12),
    #("--space-14", space_14),
    #("--space-16", space_16),
    #("--space-18", space_18),
    #("--radius-small", radius_small),
    #("--radius-medium", radius_medium),
    #("--radius-large", radius_large),
    #("--radius-full", radius_full),
    #("--bar-height", bar_height),
    #("--font-sans", font_sans),
    #("--font-mono", font_mono),
  ]
  |> list.fold("", fn(acc, cur) {
    let #(label, color) = cur
    acc <> "\n" <> label <> ": " <> color <> ";"
  })
}
