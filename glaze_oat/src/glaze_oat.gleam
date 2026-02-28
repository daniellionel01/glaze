import glaze_oat/theme.{type Theme, theme_to_css_style_tag}
import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html

pub const version = "0.4.1"

pub fn head(version: String, theme: Theme) -> Element(a) {
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
    theme_to_css_style_tag(theme),
  ])
}
