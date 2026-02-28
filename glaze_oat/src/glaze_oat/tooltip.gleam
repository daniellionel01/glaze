//// Oat documentation: <https://oat.ink/components/tooltip/>
////
//// Tooltip helpers for short helper text on interactive elements.
////
//// ## Anatomy
////
//// Use [`tooltip`](#tooltip) for Oat-styled tooltip content and optionally pair
//// it with [`title`](#title) so native browser tooltip behavior still exists as
//// a fallback.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/tooltip
//// import lustre/attribute
//// import lustre/element/html
////
//// html.button([
////   attribute.type_("button"),
////   tooltip.tooltip("Delete this item"),
////   tooltip.title("Delete this item"),
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
