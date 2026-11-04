//// Basecoat documentation: <https://basecoatui.com/components/button-group/>
////
//// Joins related buttons into a single control.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/button
//// import glaze/basecoat/button_group
//// import lustre/element/html
////
//// fn actions() {
////   button_group.button_group([], [
////     button.outline([], [html.text("Archive")]),
////     button.outline([], [html.text("Report")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn button_group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [attribute.role("group"), attribute.class("button-group"), ..attrs],
    children,
  )
}

/// Stack the buttons vertically.
///
pub fn vertical() -> Attribute(msg) {
  attribute.data("orientation", "vertical")
}

pub fn separator() -> Element(msg) {
  html.hr([attribute.role("separator")])
}

/// Non-interactive text inside the group, like a label or unit.
///
pub fn text(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span(attrs, children)
}
