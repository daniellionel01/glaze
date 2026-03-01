//// Basecoat documentation: <https://basecoatui.com/components/alert/>
////
//// Alert callouts for status, warnings, and short messages.
////
//// Use alerts to draw attention to a change in state or to provide contextual
//// information near a form, list, or page section.
////
//// ## Anatomy
////
//// An alert is typically a container with optional `icon`, `title`, and
//// `description` content.
////
//// ## Recipes
////
//// ### A basic alert
////
//// ```gleam
//// import glaze_basecoat/alert
//// import lustre/element/html
////
//// fn info_alert() {
////   alert.alert([], [
////     alert.title([], [html.text("Heads up")]),
////     alert.description([], [html.text("This setting applies to all projects.")]),
////   ])
//// }
//// ```
////
//// ### A destructive alert
////
//// ```gleam
//// import glaze_basecoat/alert
//// import lustre/element/html
////
//// fn delete_warning() {
////   alert.destructive([], [
////     alert.title([], [html.text("Delete project")]),
////     alert.description([], [html.text("This action cannot be undone.")]),
////   ])
//// }
//// ```
////
//// ## Variants
////
//// - [`destructive`](#destructive)
////
//// ## References
////
//// - MDN ARIA `alert` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/alert_role>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn alert(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("alert"), ..attrs], children)
}

pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("alert-destructive"), ..attrs], children)
}

pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(attrs, children)
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h2(attrs, children)
}

pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}
