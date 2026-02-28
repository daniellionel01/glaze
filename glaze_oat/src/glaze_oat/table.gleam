//// Oat documentation: <https://oat.ink/components/table/>
////
//// Table helpers for data grids and record lists.
////
//// ## Anatomy
////
//// Wrap tables with [`container`](#container) for Oat table styling, then build
//// rows and cells with regular table primitives.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/table
//// import lustre/element/html
////
//// table.container([], [
////   table.table([], [
////     table.thead([], [
////       table.tr([], [
////         table.th([], [html.text("Name")]),
////         table.th([], [html.text("Role")]),
////       ]),
////     ]),
////     table.tbody([], [
////       table.tr([], [
////         table.td([], [html.text("Casey")]),
////         table.td([], [html.text("Admin")]),
////       ]),
////     ]),
////   ]),
//// ])
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render the table wrapper used by Oat styling.
///
pub fn container(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("table"), ..attrs], children)
}

pub fn table(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.table(attrs, children)
}

pub fn thead(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.thead(attrs, children)
}

pub fn tbody(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.tbody(attrs, children)
}

pub fn tr(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.tr(attrs, children)
}

pub fn th(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.th(attrs, children)
}

pub fn td(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.td(attrs, children)
}
