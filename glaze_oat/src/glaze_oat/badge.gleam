//// Oat documentation: https://oat.ink/components/badge/

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn badge(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.span, attrs, children)
}

pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.class("badge"), ..attrs], children)
}

pub fn secondary() -> Attribute(msg) {
  attribute.class("secondary")
}

pub fn outline() -> Attribute(msg) {
  attribute.class("outline")
}

pub fn success() -> Attribute(msg) {
  attribute.class("success")
}

pub fn warning() -> Attribute(msg) {
  attribute.class("warning")
}

pub fn danger() -> Attribute(msg) {
  attribute.class("danger")
}
