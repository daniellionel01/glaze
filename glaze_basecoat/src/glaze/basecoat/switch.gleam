//// Basecoat documentation: <https://basecoatui.com/components/switch/>
////
//// Switch helpers for binary on/off controls.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/switch
//// import lustre/attribute
////
//// fn airplane_mode() {
////   switch.switch([
////     attribute.id("airplane-mode"),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN ARIA `switch` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/switch_role>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn switch(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([
    attribute.type_("checkbox"),
    attribute.class("input"),
    attribute.role("switch"),
    ..attrs
  ])
}

pub fn with_label(
  id: String,
  label_text: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.label([attribute.class("label")], [
    switch([attribute.id(id), ..attrs]),
    html.text(label_text),
  ])
}

pub fn with_description(
  id: String,
  label_text: String,
  description: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class(
        "flex flex-row items-start justify-between rounded-lg border p-4 shadow-xs gap-2",
      ),
    ],
    [
      html.div([attribute.class("flex flex-col gap-0.5")], [
        html.label([attribute.for(id), attribute.class("leading-normal")], [
          html.text(label_text),
        ]),
        html.p([attribute.class("text-muted-foreground text-sm")], [
          html.text(description),
        ]),
      ]),
      switch([attribute.id(id), ..attrs]),
    ],
  )
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

pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}
