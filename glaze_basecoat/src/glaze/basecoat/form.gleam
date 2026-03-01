//// Basecoat documentation: <https://basecoatui.com/components/form/>
////
//// The [`form`](#form) helpers provide a compact set of primitives for building
//// accessible form layouts with native HTML elements.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/form
//// import glaze/basecoat/input
//// import glaze/basecoat/button
//// import lustre/attribute
//// import lustre/element/html
////
//// fn login_form() {
////   form.form([], [
////     input.email([attribute.placeholder("Email")]),
////     input.password([attribute.placeholder("Password")]),
////     button.button([], [html.text("Login")]),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn form(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form([attribute.class("form"), ..attrs], children)
}

pub fn vertical(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form([attribute.class("form space-y-6"), ..attrs], children)
}

pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-3"), ..attrs], children)
}

pub fn action(url: String) -> Attribute(msg) {
  attribute.action(url)
}

pub fn method(m: String) -> Attribute(msg) {
  attribute.method(m)
}

pub fn post() -> Attribute(msg) {
  attribute.method("post")
}

pub fn get() -> Attribute(msg) {
  attribute.method("get")
}

pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

pub fn fieldset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.fieldset([attribute.class("grid gap-3"), ..attrs], children)
}

pub fn legend(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.legend(attrs, children)
}
