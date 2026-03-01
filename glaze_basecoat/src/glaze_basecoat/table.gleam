//// Basecoat documentation: <https://basecoatui.com/components/table/>
////
//// Table helpers for data grids and record lists.
////
//// Use [`scrollable`](#scrollable) to wrap wide tables and keep them usable on
//// smaller screens.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/table
//// import lustre/element/html
////
//// fn invoices_table() {
////   table.scrollable([], [
////     table.table([], [
////       table.thead([], [
////         table.tr([], [
////           table.th([], [html.text("Invoice")]),
////           table.th([], [html.text("Status")]),
////           table.th([table.align_right()], [html.text("Amount")]),
////         ]),
////       ]),
////       table.tbody([], [
////         table.tr([], [
////           table.td([], [html.text("INV001")]),
////           table.td([], [html.text("Paid")]),
////           table.td([table.align_right(), table.font_medium()], [html.text("$250.00")]),
////         ]),
////       ]),
////     ])
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn table(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.table([attribute.class("table"), ..attrs], children)
}

pub fn scrollable(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("overflow-x-auto"), ..attrs], children)
}

pub fn caption(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.caption(attrs, children)
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

pub fn tfoot(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.tfoot(attrs, children)
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

pub fn align_right() -> Attribute(msg) {
  attribute.class("text-right")
}

pub fn font_medium() -> Attribute(msg) {
  attribute.class("font-medium")
}
