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
import lustre/element.{type Element}
import lustre/element/html

/// Render a loading spinner.
///
pub fn spinner(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div([attribute.class("spinner"), ..attrs], [])
}

/// Small spinner size.
///
pub fn small() -> Attribute(msg) {
  attribute.class("spinner-sm")
}

/// Large spinner size.
///
pub fn large() -> Attribute(msg) {
  attribute.class("spinner-lg")
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
