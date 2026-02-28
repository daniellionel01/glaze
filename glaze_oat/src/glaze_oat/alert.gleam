//// Oat documentation: https://oat.ink/components/alert/

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn alert(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.div, attrs, children)
}

pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.role("alert"), ..attrs], children)
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.strong(attrs, children)
}

pub fn message(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span(attrs, children)
}

pub fn success() -> Attribute(msg) {
  attribute.data("variant", "success")
}

pub fn warning() -> Attribute(msg) {
  attribute.data("variant", "warning")
}

pub fn error() -> Attribute(msg) {
  attribute.data("variant", "error")
}

pub fn danger() -> Attribute(msg) {
  attribute.data("variant", "danger")
}
