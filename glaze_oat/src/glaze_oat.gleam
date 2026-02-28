import glaze_oat/theme.{type Theme, theme_to_css_style_tag}
import lustre/attribute.{type Attribute, attribute}
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

pub type Variant {
  Default
  Success
  Warning
  Error
  Danger
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Default -> ""
    Success -> "success"
    Warning -> "warning"
    Error -> "error"
    Danger -> "danger"
  }
}

/// Oat documentation: https://oat.ink/components/alert
///
pub fn alert(
  variant: Variant,
  attrs: List(Attribute(a)),
  children: List(Element(a)),
) -> Element(a) {
  // In case the variant is `Default` we do not want the `data-variant` attribute set at all
  // to avoid the borderless css that it in the `alert.css` (https://github.com/knadh/oat/blob/master/src/css/alert.css)
  let attrs = case variant {
    Default -> attrs
    _ -> [attribute.data("variant", variant_to_string(variant)), ..attrs]
  }
  html.div([attribute.role("alert"), ..attrs], children)
}
