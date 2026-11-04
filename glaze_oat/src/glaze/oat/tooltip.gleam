//// Oat documentation: <https://oat.ink/components/tooltip/>
////
//// Tooltip helpers for short helper text on interactive elements.
//// Requires Oat's JavaScript, which also turns plain `title` attributes into
//// Oat tooltips.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/oat/tooltip
//// import lustre/attribute
//// import lustre/element/html
////
//// html.button([
////   attribute.type_("button"),
////   tooltip.tooltip("Delete this item"),
////   tooltip.bottom(),
//// ], [html.text("Delete")])
//// ```
////
//// ## References
////
//// - MDN `title` global attribute:
////   <https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/title>

import lustre/attribute.{type Attribute, attribute}

/// Add Oat tooltip text to an element.
///
/// This sets `data-tooltip`, which Oat styles can read to show tooltip UI.
///
pub fn tooltip(text: String) -> Attribute(msg) {
  attribute("data-tooltip", text)
}

/// Add the native HTML `title` attribute.
///
/// Use this when you want browser-default tooltip behavior or a fallback.
///
pub fn title(text: String) -> Attribute(msg) {
  attribute.title(text)
}

/// Tooltips show above the element by default.
///
pub fn bottom() -> Attribute(msg) {
  attribute("data-tooltip-placement", "bottom")
}

pub fn left() -> Attribute(msg) {
  attribute("data-tooltip-placement", "left")
}

pub fn right() -> Attribute(msg) {
  attribute("data-tooltip-placement", "right")
}
