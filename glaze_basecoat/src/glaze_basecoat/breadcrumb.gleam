//// Basecoat documentation: <https://basecoatui.com/components/breadcrumb/>
////
//// The [`breadcrumb`](#breadcrumb) helpers render hierarchical navigation for
//// showing where a user is in the app and how to move back up.
////
//// ## Anatomy
////
//// Use [`breadcrumb`](#breadcrumb) as the ordered list container. Each step is
//// typically an [`item`](#item) link, followed by a [`current`](#current)
//// element.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/breadcrumb
//// import lustre/attribute
//// import lustre/element/html
////
//// fn nav_breadcrumb() {
////   html.nav([attribute.aria_label("Breadcrumb")], [
////     breadcrumb.breadcrumb([], [
////       breadcrumb.item([attribute.href("/")], [html.text("Home")]),
////       breadcrumb.separator([]),
////       breadcrumb.item([attribute.href("/docs")], [html.text("Documentation")]),
////       breadcrumb.separator([]),
////       breadcrumb.current([], [html.text("Components")]),
////     ])
////   ])
//// }
//// ```
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

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

pub fn separator(attrs: List(Attribute(msg))) -> Element(msg) {
  html.li(attrs, [
    html.span([attribute.class("size-3.5")], [
      html.text("›"),
    ]),
  ])
}

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
