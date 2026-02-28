//// Oat documentation: https://oat.ink/components/dropdown/

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn dropdown(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("ot-dropdown", attrs, children)
}

pub fn trigger_for(name: String) -> Attribute(msg) {
  attribute.popovertarget(name)
}

pub fn popover_target_attrs(name: String) -> List(Attribute(msg)) {
  [attribute.id(name), attribute("popover", "")]
}

pub fn menu(
  name: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.menu(list.append(popover_target_attrs(name), attrs), children)
}

pub fn item(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute.role("menuitem"), ..attrs], children)
}
