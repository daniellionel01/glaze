//// Basecoat documentation: <https://basecoatui.com/components/badge/>
////
//// The [`badge`](#badge) helpers display labels, counts, or status indicators.
////
//// ## Variants
////
//// - [`primary`](#primary) - Primary badge (default)
//// - [`secondary`](#secondary) - Secondary badge
//// - [`outline`](#outline) - Outline badge
//// - [`destructive`](#destructive) - Destructive badge
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/badge
//// import lustre/element/html
////
//// fn status() {
////   badge.badge([], [html.text("New")])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a primary badge.
///
/// Use this for prominent labels or counts.
///
pub fn badge(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge"), ..attrs], children)
}

/// Render a secondary badge.
///
/// Use this for less prominent labels.
///
pub fn secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge-secondary"), ..attrs], children)
}

/// Render an outline badge.
///
pub fn outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge-outline"), ..attrs], children)
}

/// Render a destructive badge.
///
/// Use this for error states or warnings.
///
pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge-destructive"), ..attrs], children)
}

/// Render a badge as a link.
///
pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge"), ..attrs], children)
}

/// Render a secondary badge as a link.
///
pub fn link_secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge-secondary"), ..attrs], children)
}

/// Render an outline badge as a link.
///
pub fn link_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge-outline"), ..attrs], children)
}

/// Render a destructive badge as a link.
///
pub fn link_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("badge-destructive"), ..attrs], children)
}

/// Render a badge with an icon on the left.
///
pub fn with_icon(
  icon: Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.span([attribute.class("badge"), ..attrs], [icon, ..children])
}
