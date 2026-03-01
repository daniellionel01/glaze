//// Basecoat documentation: <https://basecoatui.com/components/field/>
////
//// Form field layout helpers for labels, descriptions, and errors.
////
//// These helpers don't replace your input components; they provide a consistent
//// wrapper structure around them.
////
//// ## Anatomy
////
//// A typical field has a `label`, optional `description` or `error`, and an
//// input element (from `glaze_basecoat/input`, `glaze_basecoat/select`, etc.).
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/field
//// import glaze_basecoat/input
//// import lustre/attribute
//// import lustre/element/html
////
//// fn email_field() {
////   field.field([], [
////     field.label([attribute.for("email")], [html.text("Email")]),
////     field.description([], [html.text("Enter your email address.")]),
////     input.email([
////       attribute.id("email"),
////       input.placeholder("you@example.com"),
////     ]),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `<label>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/label>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn field(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-3"), ..attrs], children)
}

pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label([attribute.class("label"), ..attrs], children)
}

pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p([attribute.class("text-muted-foreground text-sm"), ..attrs], children)
}

pub fn error(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p([attribute.class("text-destructive text-sm"), ..attrs], children)
}

pub fn with_label(
  id: String,
  label_text: String,
  input_element: Element(msg),
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-3"), ..attrs], [
    label([attribute.for(id)], [html.text(label_text)]),
    input_element,
  ])
}

pub fn with_description(
  id: String,
  label_text: String,
  description_text: String,
  input_element: Element(msg),
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-3"), ..attrs], [
    label([attribute.for(id)], [html.text(label_text)]),
    input_element,
    html.p([attribute.class("text-muted-foreground text-sm")], [
      html.text(description_text),
    ]),
  ])
}
