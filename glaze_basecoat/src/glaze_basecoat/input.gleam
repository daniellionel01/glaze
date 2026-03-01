//// Basecoat documentation: <https://basecoatui.com/components/input/>
////
//// The [`input`](#input) helpers display form input fields.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/input
//// import lustre/attribute
////
//// fn email_field() {
////   input.input([
////     attribute.type_("email"),
////     attribute.placeholder("Email"),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a text input field.
///
pub fn input(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("text"), ..attrs])
}

/// Render an email input field.
///
pub fn email(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("email"), ..attrs])
}

/// Render a password input field.
///
pub fn password(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("password"), ..attrs])
}

/// Render a number input field.
///
pub fn number(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("number"), ..attrs])
}

/// Render a search input field.
///
pub fn search(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("search"), ..attrs])
}

/// Render a URL input field.
///
pub fn url(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("url"), ..attrs])
}

/// Render a date input field.
///
pub fn date(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("date"), ..attrs])
}

/// Render a time input field.
///
pub fn time(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("time"), ..attrs])
}

/// Mark input as invalid.
///
pub fn invalid() -> Attribute(msg) {
  attribute.aria_invalid("true")
}

/// Mark input as disabled.
///
pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

/// Set placeholder text.
///
pub fn placeholder(text: String) -> Attribute(msg) {
  attribute.placeholder(text)
}

/// Set the input value.
///
pub fn value(text: String) -> Attribute(msg) {
  attribute.value(text)
}

/// Set the input name.
///
pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

/// Set the input id.
///
pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}
