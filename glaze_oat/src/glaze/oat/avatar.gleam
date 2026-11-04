//// Oat documentation: <https://oat.ink/components/avatar/>
////
//// Round user images or initials, optionally stacked in a [`group`](#group).
////
//// ## Recipe
////
//// ```gleam
//// import glaze/oat/avatar
//// import lustre/attribute
//// import lustre/element/html
////
//// fn team() {
////   avatar.group([], [
////     avatar.avatar([], [html.img([attribute.src("/jane.png"), attribute.alt("Jane")])]),
////     avatar.avatar([], [html.text("JD")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn avatar(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.figure([attribute.data("variant", "avatar"), ..attrs], children)
}

/// Overlap several avatars in a row.
///
pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.figure(
    [attribute.data("variant", "avatar"), attribute.role("group"), ..attrs],
    children,
  )
}

/// Works on both [`avatar`](#avatar) and [`group`](#group).
///
pub fn small() -> Attribute(msg) {
  attribute.class("small")
}

/// Works on both [`avatar`](#avatar) and [`group`](#group).
///
pub fn large() -> Attribute(msg) {
  attribute.class("large")
}
