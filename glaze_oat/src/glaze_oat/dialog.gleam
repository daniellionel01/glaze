//// Oat documentation: https://oat.ink/components/dialog/

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn dialog(
  name: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.dialog([attribute.id(name), ..attrs], children)
}

pub fn form(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form([attribute.method("dialog"), ..attrs], children)
}

pub fn closed_by_any() -> Attribute(msg) {
  attribute("closedby", "any")
}

pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h3(attrs, children)
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}
