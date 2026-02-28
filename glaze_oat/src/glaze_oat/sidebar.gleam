//// Oat documentation: https://oat.ink/components/sidebar/

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn sidebar(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute("data-sidebar-layout", ""), ..attrs], children)
}

pub fn sidebar_always(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute("data-sidebar-layout", "always"), ..attrs], children)
}

pub fn toggle(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute("data-sidebar-toggle", ""), ..attrs], children)
}

pub fn topnav(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header([attribute("data-topnav", ""), ..attrs], children)
}

pub fn aside(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.aside([attribute("data-sidebar", ""), ..attrs], children)
}
