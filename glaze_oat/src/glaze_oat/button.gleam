//// Oat documentation: https://oat.ink/components/button/

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.menu([attribute.class("buttons"), ..attrs], {
    use child <- list.map(children)
    html.li([], [child])
  })
}

pub fn button(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.button, attrs, children)
}

pub fn open_dialog(
  dialog element_id: String,
  attrs attrs: List(Attribute(msg)),
  children children: List(Element(msg)),
) -> Element(msg) {
  instance(
    html.button,
    [
      attribute("commandfor", element_id),
      attribute("command", "show-modal"),
      ..attrs
    ],
    children,
  )
}

pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.a, [attribute.class("button"), ..attrs], children)
}

pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.role("button"), ..attrs], children)
}

pub fn primary() -> Attribute(msg) {
  attribute.data("data-variant", "primary")
}

pub fn secondary() -> Attribute(msg) {
  attribute.data("data-variant", "secondary")
}

pub fn danger() -> Attribute(msg) {
  attribute.data("data-variant", "danger")
}

pub fn outline() -> Attribute(msg) {
  attribute.class("outline")
}

pub fn ghost() -> Attribute(msg) {
  attribute.class("ghost")
}

pub fn small() -> Attribute(msg) {
  attribute.class("small")
}

pub fn large() -> Attribute(msg) {
  attribute.class("small")
}
