//// Basecoat documentation: <https://basecoatui.com/components/pagination/>
////
//// Pagination helpers for lists split across pages.
////
//// These helpers render a navigation landmark with page links.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/pagination
//// import lustre/attribute
////
//// fn page_nav() {
////   pagination.pagination([], [
////     pagination.prev([attribute.href("?page=1")]),
////     pagination.page(1, True, [attribute.href("?page=1")]),
////     pagination.page(2, False, [attribute.href("?page=2")]),
////     pagination.next([attribute.href("?page=2")]),
////   ])
//// }
//// ```
////

import gleam/int
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn pagination(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav(
    [
      attribute.role("navigation"),
      attribute.aria_label("pagination"),
      attribute.class("mx-auto flex w-full justify-center"),
      ..attrs
    ],
    [
      html.ul([attribute.class("flex flex-row items-center gap-1")], children),
    ],
  )
}

pub fn prev(attrs: List(Attribute(msg))) -> Element(msg) {
  html.li([], [
    html.a([attribute.class("btn-ghost"), ..attrs], [html.text(" Previous")]),
  ])
}

pub fn next(attrs: List(Attribute(msg))) -> Element(msg) {
  html.li([], [
    html.a([attribute.class("btn-ghost"), ..attrs], [html.text("Next ")]),
  ])
}

pub fn page(
  page_num: Int,
  is_active: Bool,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  let class = case is_active {
    True -> "btn-icon-outline"
    False -> "btn-icon-ghost"
  }

  html.li([], [
    html.a([attribute.class(class), ..attrs], [
      html.text(int.to_string(page_num)),
    ]),
  ])
}

pub fn ellipsis(attrs: List(Attribute(msg))) -> Element(msg) {
  html.li([], [
    html.div(
      [attribute.class("size-9 flex items-center justify-center"), ..attrs],
      [
        html.text("..."),
      ],
    ),
  ])
}
