//// Basecoat documentation: <https://basecoatui.com/components/breadcrumb/>
////
//// Breadcrumbs show the path to the current resource using a hierarchy of links.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/breadcrumb
////
//// fn nav_breadcrumb() {
////   breadcrumb.breadcrumb([], [
////     breadcrumb.item([attribute.href("/")], [html.text("Home")]),
////     breadcrumb.item([attribute.href("/docs")], [html.text("Documentation")]),
////     breadcrumb.current([], [html.text("Components")]),
////   ])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a breadcrumb container.
///
pub fn breadcrumb(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.ol(
    [
      attribute.class(
        "text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5",
      ),
      ..attrs
    ],
    children,
  )
}

/// Render a breadcrumb item with link.
///
pub fn item(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.li([attribute.class("inline-flex items-center gap-1.5")], [
    html.a(
      [attribute.class("hover:text-foreground transition-colors"), ..attrs],
      children,
    ),
  ])
}

/// Render the current page (non-clickable).
///
pub fn current(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.li([attribute.class("inline-flex items-center gap-1.5")], [
    html.span(
      [attribute.class("text-foreground font-normal"), ..attrs],
      children,
    ),
  ])
}

/// Render a separator between breadcrumb items.
///
pub fn separator(attrs: List(Attribute(msg))) -> Element(msg) {
  html.li(attrs, [
    html.span([attribute.class("size-3.5")], [
      html.text("›"),
    ]),
  ])
}

/// Render a breadcrumb with items automatically separated.
///
pub fn with_items(
  items: List(#(String, String, Bool)),
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  let separated =
    items
    |> list.map(fn(i) {
      let #(href, label, is_current) = i
      case is_current {
        True -> current([], [html.text(label)])
        False -> item([attribute.href(href)], [html.text(label)])
      }
    })
    |> list.intersperse(separator([]))

  breadcrumb(attrs, separated)
}
