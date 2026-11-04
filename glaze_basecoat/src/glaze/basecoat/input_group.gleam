//// Basecoat documentation: <https://basecoatui.com/components/input-group/>
////
//// An input or textarea with icons, text or buttons attached to it.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/input_group
//// import lustre/attribute
//// import lustre/element/html
////
//// fn search() {
////   input_group.input_group([], [
////     html.input([attribute.placeholder("Search...")]),
////     input_group.addon([input_group.start()], [html.text("🔍")]),
////     input_group.addon([input_group.end()], [html.text("12 results")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Put the input or textarea first, followed by its addons.
///
pub fn input_group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("input-group"), ..attrs], children)
}

/// Content attached to the input. Position it with [`start`](#start),
/// [`end`](#end), [`top`](#top) or [`bottom`](#bottom).
///
pub fn addon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span(attrs, children)
}

pub fn start() -> Attribute(msg) {
  attribute.data("align", "start")
}

pub fn end() -> Attribute(msg) {
  attribute.data("align", "end")
}

pub fn top() -> Attribute(msg) {
  attribute.data("align", "block-start")
}

pub fn bottom() -> Attribute(msg) {
  attribute.data("align", "block-end")
}
