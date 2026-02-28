//// Oat documentation: https://oat.ink/components/breadcrumb/

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn breadcrumb(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav([attribute.aria_label("breadcrumb")], [
    html.ol(
      [
        attribute.class("unstyled hstack"),
        attribute.style("font-size", "var(--text-7)"),
        ..attrs
      ],
      children,
    ),
  ])
}

pub fn separator(
  attributes: List(Attribute(msg)),
  content: Element(msg),
) -> Element(msg) {
  html.li(
    [
      attribute.role("presentation"),
      attribute("aria-hidden", "true"),
      ..attributes
    ],
    [content],
  )
}

pub fn slash(attributes: List(Attribute(msg))) -> Element(msg) {
  separator(attributes, html.text("/"))
}

pub fn chevron(attributes: List(Attribute(msg))) -> Element(msg) {
  separator(attributes, html.text(">"))
}

pub fn current(
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(
    [
      attribute.role("link"),
      attribute("aria-disabled", "true"),
      attribute("aria-current", "page"),
      ..attributes
    ],
    children,
  )
}

pub fn link(attrs: List(Attribute(msg)), children: List(Element(msg))) {
  html.li([], [html.a([attribute.class("unstyled"), ..attrs], children)])
}
