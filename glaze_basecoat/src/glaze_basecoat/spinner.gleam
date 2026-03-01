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
////

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}
import lustre/element/html

/// Render a loading spinner.
///
pub fn spinner(attrs: List(Attribute(msg))) -> Element(msg) {
  element(
    "svg",
    [
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute("width", "24"),
      attribute("height", "24"),
      attribute("viewBox", "0 0 24 24"),
      attribute("fill", "none"),
      attribute("stroke", "currentColor"),
      attribute("stroke-width", "2"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-linejoin", "round"),
      attribute.role("status"),
      attribute.aria_label("Loading"),
      attribute.class("animate-spin size-4"),
      ..attrs
    ],
    [
      element("path", [attribute("d", "M21 12a9 9 0 1 1-6.219-8.56")], []),
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
