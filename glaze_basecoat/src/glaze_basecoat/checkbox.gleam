//// Basecoat documentation: <https://basecoatui.com/components/checkbox/>
////
//// The [`checkbox`](#checkbox) helpers display checkbox inputs.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/checkbox
//// import lustre/attribute
////
//// fn terms_checkbox() {
////   checkbox.checkbox([
////     attribute.id("terms"),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a checkbox input.
///
pub fn checkbox(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.type_("checkbox"), attribute.class("input"), ..attrs])
}

/// Render a checkbox with a label.
///
pub fn with_label(
  id: String,
  label_text: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.label([attribute.class("label gap-3")], [
    checkbox([attribute.id(id), ..attrs]),
    html.text(label_text),
  ])
}

/// Render a checkbox with label and description.
///
pub fn with_description(
  id: String,
  label_text: String,
  description: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div([attribute.class("flex items-start gap-3")], [
    checkbox([attribute.id(id), ..attrs]),
    html.div([attribute.class("grid gap-2")], [
      html.label([attribute.for(id), attribute.class("label")], [
        html.text(label_text),
      ]),
      html.p([attribute.class("text-muted-foreground text-sm")], [
        html.text(description),
      ]),
    ]),
  ])
}

/// Mark checkbox as checked.
///
pub fn checked() -> Attribute(msg) {
  attribute.checked(True)
}

/// Mark checkbox as disabled.
///
pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

/// Set the checkbox name.
///
pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

/// Set the checkbox value.
///
pub fn value(v: String) -> Attribute(msg) {
  attribute.value(v)
}

/// Set the checkbox id.
///
pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}
