//// Oat documentation: https://oat.ink/components/skeleton/

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn skeleton(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div([attribute.class("skeleton"), attribute.role("status"), ..attrs], [])
}

pub fn line(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("line"), ..attrs])
}

pub fn box(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("box"), ..attrs])
}
