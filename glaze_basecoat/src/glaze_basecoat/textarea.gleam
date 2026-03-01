//// Basecoat documentation: <https://basecoatui.com/components/textarea/>
////
//// The [`textarea`](#textarea) helpers display multi-line text input fields.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/textarea
//// import lustre/attribute
////
//// fn message_field() {
////   textarea.textarea([
////     attribute.placeholder("Type your message here"),
////   ], "")
//// }
//// ```

import gleam/int
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a textarea.
///
pub fn textarea(attrs: List(Attribute(msg)), content: String) -> Element(msg) {
  html.textarea([attribute.class("textarea"), ..attrs], content)
}

/// Mark textarea as invalid.
///
pub fn invalid() -> Attribute(msg) {
  attribute("aria-invalid", "true")
}

/// Mark textarea as disabled.
///
pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

/// Set placeholder text.
///
pub fn placeholder(text: String) -> Attribute(msg) {
  attribute.placeholder(text)
}

/// Set the textarea name.
///
pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

/// Set the textarea id.
///
pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}

/// Set number of visible rows.
///
pub fn rows(n: Int) -> Attribute(msg) {
  attribute.attribute("rows", int.to_string(n))
}
