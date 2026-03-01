//// Basecoat documentation: <https://basecoatui.com/components/input/>
////
//// Input helpers for common text-like controls.
////
//// These helpers style native `<input>` elements and provide small attribute
//// helpers for common patterns.
////
//// ## Anatomy
////
//// Choose an input constructor (`input`, `email`, `password`, ...) and pass
//// native attributes from `lustre/attribute` plus any helpers in this module.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/input
//// import lustre/attribute
////
//// fn email_field() {
////   input.input([
////     attribute.id("email"),
////     attribute.type_("email"),
////     attribute.placeholder("Email"),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `<input>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input>
//// - MDN `aria-invalid`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn input(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("text"), ..attrs])
}

pub fn email(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("email"), ..attrs])
}

pub fn password(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("password"), ..attrs])
}

pub fn number(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("number"), ..attrs])
}

pub fn search(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("search"), ..attrs])
}

pub fn url(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("url"), ..attrs])
}

pub fn date(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("date"), ..attrs])
}

pub fn time(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.class("input"), attribute.type_("time"), ..attrs])
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

pub fn value(text: String) -> Attribute(msg) {
  attribute.value(text)
}

pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}
