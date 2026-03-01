//// Basecoat documentation: <https://basecoatui.com/components/spinner/>
////
//// The [`spinner`](#spinner) helpers display loading spinners.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/spinner
////
//// fn loading() {
////   spinner.spinner([])
//// }
//// ```

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}
import lustre/element/html

/// Render a loading spinner.
///
pub fn spinner(attrs: List(Attribute(msg))) -> Element(msg) {
  element(
    "svg",
    [
      attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute.attribute("width", "24"),
      attribute.attribute("height", "24"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("fill", "none"),
      attribute.attribute("stroke", "currentColor"),
      attribute.attribute("stroke-width", "2"),
      attribute.attribute("stroke-linecap", "round"),
      attribute.attribute("stroke-linejoin", "round"),
      attribute.role("status"),
      attribute("aria-label", "Loading"),
      attribute.class("animate-spin size-4"),
      ..attrs
    ],
    [
      element(
        "path",
        [attribute.attribute("d", "M21 12a9 9 0 1 1-6.219-8.56")],
        [],
      ),
    ],
  )
}

/// Small spinner size.
///
pub fn small() -> Attribute(msg) {
  attribute.class("size-3")
}

/// Large spinner size.
///
pub fn large() -> Attribute(msg) {
  attribute.class("size-8")
}

/// Spinner with overlay.
///
/// Use this to overlay a loading state on content.
///
pub fn overlay(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [attribute.class("relative"), attribute("aria-busy", "true"), ..attrs],
    [
      html.div(
        [
          attribute.class(
            "absolute inset-0 flex items-center justify-center bg-background/80",
          ),
        ],
        [
          spinner([]),
        ],
      ),
      html.div([attribute.class("opacity-50 pointer-events-none")], children),
    ],
  )
}
