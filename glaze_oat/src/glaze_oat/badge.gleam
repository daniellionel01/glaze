//// Oat documentation: <https://oat.ink/components/badge/>
////
//// The [`badge`](#badge) element, sometimes called a "tag", is used to attach
//// short contextual information to nearby content.
////
//// Common examples include labels like "New", "Beta", "Paid", or status chips
//// in lists and cards.
////
//// ## Anatomy
////
//// A badge is a compact inline container for short labels.
//// In practice this is usually a single word or short phrase, sometimes with
//// an icon.
////
//// ## Recipes
////
//// ### A basic badge
////
//// ```gleam
//// import glaze_oat/badge
//// import lustre/element/html
////
//// fn new_label() {
////   badge.badge([], [html.text("New")])
//// }
//// ```
////
//// ### A success badge
////
//// ```gleam
//// import glaze_oat/badge
//// import lustre/element/html
////
//// fn sync_status() {
////   badge.badge([badge.success()], [html.text("Synced")])
//// }
//// ```
////
//// ## Variants
////
//// - [`secondary`](#secondary)
//// - [`outline`](#outline)
//// - [`success`](#success)
//// - [`warning`](#warning)
//// - [`danger`](#danger)
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a badge as a `<span>`.
///
/// This is the default badge helper and wraps [`instance`](#instance) with
/// `html.span`.
///
pub fn badge(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.span, attrs, children)
}

/// Render a badge with a custom element.
///
/// Use this when you want badge styling on another semantic element such as
/// `html.button`, `html.a`, or `html.small`.
///
pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.class("badge"), ..attrs], children)
}

/// Apply the secondary badge variant class.
///
pub fn secondary() -> Attribute(msg) {
  attribute.class("secondary")
}

/// Apply the outline badge variant class.
///
pub fn outline() -> Attribute(msg) {
  attribute.class("outline")
}

/// Apply the success badge variant class.
///
pub fn success() -> Attribute(msg) {
  attribute.class("success")
}

/// Apply the warning badge variant class.
///
pub fn warning() -> Attribute(msg) {
  attribute.class("warning")
}

/// Apply the danger badge variant class.
///
pub fn danger() -> Attribute(msg) {
  attribute.class("danger")
}
