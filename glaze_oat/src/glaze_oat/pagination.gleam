//// Oat documentation: https://oat.ink/components/pagination/

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
