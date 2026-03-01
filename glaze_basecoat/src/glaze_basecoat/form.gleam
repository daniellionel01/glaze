//// Basecoat documentation: <https://basecoatui.com/components/form/>
////
//// The [`form`](#form) helpers display form containers.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/form
//// import glaze_basecoat/input
//// import glaze_basecoat/button
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

/// Render a form container.
///
pub fn form(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form([attribute.class("form"), ..attrs], children)
}

/// Render a form with vertical spacing.
///
pub fn vertical(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form([attribute.class("form space-y-6"), ..attrs], children)
}

/// Render a form section/group.
///
pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-3"), ..attrs], children)
}

/// Set the form action URL.
///
pub fn action(url: String) -> Attribute(msg) {
  attribute.action(url)
}

/// Set the form method.
///
pub fn method(m: String) -> Attribute(msg) {
  attribute.method(m)
}

/// Set form to POST method.
///
pub fn post() -> Attribute(msg) {
  attribute.method("post")
}

/// Set form to GET method.
///
pub fn get() -> Attribute(msg) {
  attribute.method("get")
}

/// Set the form name.
///
pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

/// Render a form fieldset.
///
pub fn fieldset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.fieldset([attribute.class("grid gap-3"), ..attrs], children)
}

/// Render a form legend.
///
pub fn legend(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.legend(attrs, children)
}
