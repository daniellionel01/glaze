//// Basecoat documentation: <https://basecoatui.com/components/label/>
////
//// The [`label`](#label) helpers display form labels.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/label
//// import lustre/attribute
////
//// fn email_field() {
////   label.label([attribute.for("email")], [html.text("Email")])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a form label.
///
pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label([attribute.class("label"), ..attrs], children)
}

/// Render a label with an associated input.
///
pub fn with_input(
  id: String,
  label_text: String,
  input_attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div([attribute.class("grid gap-2")], [
    label([attribute.for(id)], [html.text(label_text)]),
    html.input([
      attribute.id(id),
      attribute.type_("text"),
      attribute.class("input"),
      ..input_attrs
    ]),
  ])
}
