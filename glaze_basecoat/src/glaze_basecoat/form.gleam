//// Basecoat documentation: <https://basecoatui.com/components/form/>
////
//// Form layout helpers.
////
//// Use these helpers to style a `<form>` and to create consistent spacing and
//// grouping around controls.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/form
//// import glaze_basecoat/input
//// import glaze_basecoat/button
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
//// ## References
////
//// - MDN `<form>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/form>

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
