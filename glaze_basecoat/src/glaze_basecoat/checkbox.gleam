//// Basecoat documentation: <https://basecoatui.com/components/checkbox/>
////
//// Checkbox helpers for boolean selections.
////
//// Use [`checkbox`](#checkbox) for the input itself, or the convenience helpers
//// for common label/description layouts.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/checkbox
//// import lustre/attribute
//// import lustre/element/html
////
//// fn terms_checkbox() {
////   checkbox.with_label("terms", "Accept terms", [
////     attribute.checked(True),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn checkbox(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.type_("checkbox"), attribute.class("input"), ..attrs])
}

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

pub fn checked() -> Attribute(msg) {
  attribute.checked(True)
}

pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

pub fn value(v: String) -> Attribute(msg) {
  attribute.value(v)
}

pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}
