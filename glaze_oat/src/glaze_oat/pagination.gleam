//// Oat documentation: <https://oat.ink/components/pagination/>
////
//// Pagination helpers for multi-page lists and tables.
////
//// ## Anatomy
////
//// A pagination control usually has page links plus previous/next controls, with
//// the current page marked using `aria-current="page"`.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/pagination
//// import lustre/attribute
//// import lustre/element/html
////
//// pagination.pagination([], [
////   pagination.prev([attribute.href("?page=1")], [html.text("Previous")]),
////   pagination.page_link([attribute.href("?page=1")], [html.text("1")]),
////   pagination.current_page([attribute.href("?page=2")], [html.text("2")]),
////   pagination.page_link([attribute.href("?page=3")], [html.text("3")]),
////   pagination.next([attribute.href("?page=3")], [html.text("Next")]),
//// ])
//// ```
////
//// ## References
////
//// - MDN `aria-current`:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Attributes/aria-current>

import glaze_oat/button
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn pagination(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav([attribute.aria_label("Pagination"), ..attrs], [
    button.group([], children),
  ])
}

pub fn page_link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  button.link([button.outline(), button.small(), ..attrs], children)
}

/// Render the active page link.
///
/// This marks the link with `aria-current="page"`.
///
pub fn current_page(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  button.link(
    [button.small(), attribute("aria-current", "page"), ..attrs],
    children,
  )
}

pub fn prev(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  page_link(attrs, children)
}

pub fn next(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  page_link(attrs, children)
}
