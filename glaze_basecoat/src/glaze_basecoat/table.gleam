//// Basecoat documentation: <https://basecoatui.com/components/table/>
////
//// A responsive table component.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/table
////
//// fn invoices_table() {
////   table.table([], [
////     table.thead([], [
////       table.tr([], [
////         table.th([], [html.text("Invoice")]),
////         table.th([], [html.text("Status")]),
////         table.th([], [html.text("Amount")]),
////       ]),
////     ]),
////     table.tbody([], [
////       table.tr([], [
////         table.td([], [html.text("INV001")]),
////         table.td([], [html.text("Paid")]),
////         table.td([], [html.text("$250.00")]),
////       ]),
////     ]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a table container.
///
pub fn table(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.table([attribute.class("table"), ..attrs], children)
}

/// Render a scrollable table wrapper.
///
pub fn scrollable(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("overflow-x-auto"), ..attrs], children)
}

/// Render a table caption.
///
pub fn caption(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.caption(attrs, children)
}

/// Render a table header.
///
pub fn thead(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.thead(attrs, children)
}

/// Render a table body.
///
pub fn tbody(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.tbody(attrs, children)
}

/// Render a table footer.
///
pub fn tfoot(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.tfoot(attrs, children)
}

/// Render a table row.
///
pub fn tr(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.tr(attrs, children)
}

/// Render a table header cell.
///
pub fn th(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.th(attrs, children)
}

/// Render a table data cell.
///
pub fn td(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.td(attrs, children)
}

/// Right-align a cell.
///
pub fn align_right() -> Attribute(msg) {
  attribute.class("text-right")
}

/// Bold text in a cell.
///
pub fn font_medium() -> Attribute(msg) {
  attribute.class("font-medium")
}
