//// Basecoat documentation: <https://basecoatui.com/components/field/>
////
//// The [`field`](#field) helpers display form field wrappers with labels and descriptions.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/field
//// import glaze_basecoat/input
////
//// fn email_field() {
////   field.field([], [
////     field.label([], [html.text("Email")]),
////     field.description([], [html.text("Enter your email address.")]),
////     input.email([input.placeholder("you@example.com")]),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a form field container.
///
pub fn field(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-3"), ..attrs], children)
}

/// Render a field label.
///
pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label([attribute.class("label"), ..attrs], children)
}

/// Render a field description.
///
pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p([attribute.class("text-muted-foreground text-sm"), ..attrs], children)
}

/// Render a field error message.
///
pub fn error(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p([attribute.class("text-destructive text-sm"), ..attrs], children)
}

/// Render a complete field with label, input, and description.
///
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

/// Render a complete field with label, description, and input.
///
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
