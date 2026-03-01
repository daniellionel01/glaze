//// Basecoat documentation: <https://basecoatui.com/components/alert/>
////
//// The [`alert`](#alert) helpers build callout components for user attention.
////
//// ## Variants
////
//// - Default (info style)
//// - [`destructive`](#destructive) - Error/danger alert
////
//// ## Recipes
////
//// ### Success alert
////
//// ```gleam
//// import glaze_basecoat/alert
//// import lustre/element/html
////
//// fn success_alert() {
////   alert.alert([], [
////     alert.title([], [html.text("Success!")]),
////     alert.description([], [html.text("Your changes have been saved.")]),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render an alert container.
///
pub fn alert(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("alert"), ..attrs], children)
}

/// Render a destructive/error alert container.
///
pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("alert-destructive"), ..attrs], children)
}

/// Render an alert icon.
///
/// Note: You should provide your own icon element.
///
pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(attrs, children)
}

/// Render an alert title.
///
pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h2(attrs, children)
}

/// Render an alert description.
///
pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}
