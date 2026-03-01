//// Basecoat documentation: <https://basecoatui.com/components/badge/>
////
//// The [`badge`](#badge) element, sometimes called a "tag", is used to attach
//// short contextual information to nearby content.
////
//// Common examples include labels like "New", "Beta", "Paid", or status chips
//// in lists and cards.
////
//// ## Variants
////
//// - [`secondary`](#secondary)
//// - [`outline`](#outline)
//// - [`destructive`](#destructive)
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/badge
//// import lustre/element/html
////
//// fn status() {
////   badge.badge([], [html.text("New")])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn badge(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge"), ..attrs], children)
}

pub fn secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge-secondary"), ..attrs], children)
}

pub fn outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge-outline"), ..attrs], children)
}

pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge-destructive"), ..attrs], children)
}

pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge"), ..attrs], children)
}

pub fn link_secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge-secondary"), ..attrs], children)
}

pub fn link_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge-outline"), ..attrs], children)
}

pub fn link_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge-destructive"), ..attrs], children)
}

pub fn with_icon(
  icon: Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge"), ..attrs], [icon, ..children])
}
