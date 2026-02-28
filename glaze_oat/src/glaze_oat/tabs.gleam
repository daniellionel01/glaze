//// Oat documentation: https://oat.ink/components/tabs/

import lustre/attribute.{type Attribute}
import lustre/element.{type Element, element}
import lustre/element/html

pub fn tabs(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element("ot-tabs", attrs, children)
}

pub fn tablist(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.role("tablist"), ..attrs], children)
}

pub fn tab(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute.role("tab"), ..attrs], children)
}

pub fn tabpanel(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.role("tabpanel"), ..attrs], children)
}
