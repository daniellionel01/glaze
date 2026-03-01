//// Oat documentation: <https://oat.ink/components/alert/>
////
//// The [`alert`](#alert) element, sometimes called a "callout", is used to draw
//// attention to important information without interrupting page flow.
////
//// ## Anatomy
////
//// An alert is usually a container with short, high-signal text.
//// Most uses combine a `title` for the main message and an optional `message`
//// for supporting detail.
////
//// ## Recipes
////
//// ### A title-only success alert
////
//// ```gleam
//// import glaze/oat/alert
//// import lustre/element/html
////
//// fn saved_notice() {
////   alert.alert([alert.success()], [
////     alert.title([], [html.text("Changes saved.")]),
////   ])
//// }
//// ```
////
//// ### A warning alert with title and message
////
//// ```gleam
//// import glaze/oat/alert
//// import lustre/element/html
////
//// fn warning_notice() {
////   alert.alert([alert.warning()], [
////     alert.title([], [html.text("Storage nearly full")]),
////     alert.message([], [
////       html.text("Delete unused files or upgrade your plan."),
////     ]),
////   ])
//// }
//// ```
////
//// ## Variants
////
//// - [`success`](#success)
//// - [`warning`](#warning)
//// - [`error`](#error)
//// - [`danger`](#danger)
////
//// ## References
////
//// - MDN ARIA `alert` role:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/alert_role>
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render an alert container as a `<div>`.
///
/// This is a convenience wrapper around [`instance`](#instance) using `html.div`.
/// The element includes `role="alert"` for accessible announcement behavior.
///
pub fn alert(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.div, attrs, children)
}

/// Render an alert using a custom container element.
///
/// This is useful when you want semantic alternatives such as `html.section`
/// while keeping the same alert role behavior.
///
/// The returned element always includes `role="alert"`.
///
pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.role("alert"), ..attrs], children)
}

/// Render alert title content using `<strong>`.
///
/// Use this for short, high-signal summary text at the start of the alert.
///
pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.strong(attrs, children)
}

/// Render alert supporting content using `<span>`.
///
/// Use this for additional detail or explanation beneath/alongside the title.
///
pub fn message(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span(attrs, children)
}

/// Set `data-variant="success"` on an alert.
///
/// Intended for positive confirmations such as completed actions.
///
pub fn success() -> Attribute(msg) {
  attribute.data("variant", "success")
}

/// Set `data-variant="warning"` on an alert.
///
/// Intended for cautionary states that may need user attention.
///
pub fn warning() -> Attribute(msg) {
  attribute.data("variant", "warning")
}

/// Set `data-variant="error"` on an alert.
///
/// Intended for failures or invalid states.
///
pub fn error() -> Attribute(msg) {
  attribute.data("variant", "error")
}

/// Set `data-variant="danger"` on an alert.
///
/// Intended for destructive or high-severity states.
///
pub fn danger() -> Attribute(msg) {
  attribute.data("variant", "danger")
}
