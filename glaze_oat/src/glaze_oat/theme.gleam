import gleam/list
import lustre/element
import lustre/element/html

pub opaque type Theme {
  SingleTheme(
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
  )
  LightDarkTheme(
    background: #(String, String),
    foreground: #(String, String),
    card: #(String, String),
    card_foreground: #(String, String),
    primary: #(String, String),
    primary_foreground: #(String, String),
    secondary: #(String, String),
    secondary_foreground: #(String, String),
    muted: #(String, String),
    muted_foreground: #(String, String),
    faint: #(String, String),
    faint_foreground: #(String, String),
    accent: #(String, String),
    danger: #(String, String),
    danger_foreground: #(String, String),
    success: #(String, String),
    success_foreground: #(String, String),
    warning: #(String, String),
    warning_foreground: #(String, String),
    border: #(String, String),
    input: #(String, String),
    ring: #(String, String),
  )
}

pub const default_theme = LightDarkTheme(
  background: #("#fff", "#09090b"),
  foreground: #("#09090b", "#fafafa"),
  card: #("#fff", "#18181b"),
  card_foreground: #("#09090b", "#fafafa"),
  primary: #("#574747", "#fafafa"),
  primary_foreground: #("#fafafa", "#18181b"),
  secondary: #("#f4f4f5", "#27272a"),
  secondary_foreground: #("#574747", "#fafafa"),
  muted: #("#f4f4f5", "#27272a"),
  muted_foreground: #("#71717a", "#a1a1aa"),
  faint: #("#fafafa", "#1e1e21"),
  faint_foreground: #("#a1a1aa", "#71717a"),
  accent: #("#f4f4f5", "#27272a"),
  danger: #("#df514c", "#f4807b"),
  danger_foreground: #("#fafafa", "#18181b"),
  success: #("#4caf50", "#6cc070"),
  success_foreground: #("#fafafa", "#18181b"),
  warning: #("#ff8c00", "#f0a030"),
  warning_foreground: #("#09090b", "#09090b"),
  border: #("#d4d4d8", "#52525b"),
  input: #("#d4d4d8", "#52525b"),
  ring: #("#574747", "#d4d4d8"),
)

pub fn theme_to_css_style_tag(theme: Theme) -> element.Element(a) {
  case theme {
    SingleTheme(
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
    ) -> {
      html.style([], ":root { " <> theme_to_css_variables(theme) <> "}")
    }
    LightDarkTheme(
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
      _,
    ) -> {
      html.style(
        [],
        ":root { color-scheme: light dark; "
          <> theme_to_css_variables(theme)
          <> "}",
      )
    }
  }
}

fn theme_to_css_variables(theme: Theme) -> String {
  case theme {
    SingleTheme(
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
    ) -> {
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
      ]
      |> list.fold("", fn(acc, cur) {
        let #(label, color) = cur
        acc <> "\n" <> label <> ": " <> color <> ";"
      })
    }
    LightDarkTheme(
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
    ) -> {
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
        #("--faint_foreground", faint_foreground),
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
      |> list.fold("", fn(acc, cur) {
        let #(label, color) = cur
        let color = "light-dark(" <> color.0 <> ", " <> color.1 <> ")"
        acc <> "\n" <> label <> ": " <> color <> ";"
      })
    }
  }
}
