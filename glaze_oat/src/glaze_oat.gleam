import gleam/list
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html

pub const version = "0.4.1"

pub type Theme {
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
  )
}

pub const default_theme = Theme(
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
)

pub fn theme_to_css(theme: Theme) -> String {
  let Theme(
    background: background,
    foreground: foreground,
    card: card,
    card_foreground: card_foreground,
    primary: primary,
    primary_foreground: primary_foreground,
    secondary: secondary,
    secondary_foreground: secondary_foreground,
    muted: muted,
    muted_foreground: muted_foreground,
    faint: faint,
    accent: accent,
    danger: danger,
    danger_foreground: danger_foreground,
    success: success,
    success_foreground: success_foreground,
    warning: warning,
    warning_foreground: warning_foreground,
    border: border,
    input: input,
    ring: ring,
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
  ]
  |> list.fold("", fn(acc, cur) { acc <> "\n" <> cur.0 <> ": " <> cur.1 <> ";" })
}

pub fn setup(version: String, theme: Theme) {
  element.fragment([
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://unpkg.com/@knadh/oat@" <> version <> "/oat.min.css",
      ),
    ]),
    html.script(
      [
        attribute("defer", "defer"),
        attribute.src(
          "https://unpkg.com/@knadh/oat@" <> version <> "/oat.min.js",
        ),
      ],
      "",
    ),
    html.style([], theme_to_css(theme)),
  ])
}
