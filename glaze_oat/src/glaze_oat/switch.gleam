//// Oat documentation: https://oat.ink/components/switch/

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn switch(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.type_("checkbox"), attribute.role("switch"), ..attrs])
}

pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label(attrs, children)
}
