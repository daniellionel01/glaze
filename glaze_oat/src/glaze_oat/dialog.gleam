//// Oat documentation: https://oat.ink/components/dialog/

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn dialog(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.dialog(attrs, children)
}

pub fn id(name: String) -> Attribute(msg) {
  attribute.id(name)
}

pub fn open_for(name: String) -> List(Attribute(msg)) {
  [attribute("commandfor", name), attribute("command", "show-modal")]
}

pub fn close_for(name: String) -> List(Attribute(msg)) {
  [attribute("commandfor", name), attribute("command", "close")]
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

pub fn closed_by_none() -> Attribute(msg) {
  attribute("closedby", "none")
}

pub fn closed_by_close_request() -> Attribute(msg) {
  attribute("closedby", "closerequest")
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
