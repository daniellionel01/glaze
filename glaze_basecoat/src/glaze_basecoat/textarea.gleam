//// Basecoat documentation: <https://basecoatui.com/components/textarea/>
////
//// Textarea helpers for multi-line text input.
////
//// Use `textarea` when the input is expected to span multiple lines (notes,
//// descriptions, messages).
////
//// ## Recipe
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
////
//// ## References
////
//// - MDN `<textarea>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/textarea>
//// - MDN `aria-invalid`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn textarea(attrs: List(Attribute(msg)), content: String) -> Element(msg) {
  html.textarea([attribute.class("textarea"), ..attrs], content)
}

pub fn invalid() -> Attribute(msg) {
  attribute.aria_invalid("true")
}

pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

pub fn placeholder(text: String) -> Attribute(msg) {
  attribute.placeholder(text)
}

pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}

pub fn rows(n: Int) -> Attribute(msg) {
  attribute.rows(n)
}
