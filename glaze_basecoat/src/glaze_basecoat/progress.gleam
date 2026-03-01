//// Basecoat documentation: <https://basecoatui.com/components/progress/>
////
//// Progress helpers for linear completion indicators.
////
//// This module styles the native `<progress>` element.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/progress
////
//// fn download_progress() {
////   progress.progress([
////     progress.value(75),
////     progress.max(100),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `<progress>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/progress>

import gleam/int
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn progress(attrs: List(Attribute(msg))) -> Element(msg) {
  html.progress([attribute.class("progress"), ..attrs], [])
}

pub fn value(val: Int) -> Attribute(msg) {
  attribute.value(int.to_string(val))
}

pub fn max(val: Int) -> Attribute(msg) {
  attribute.max(int.to_string(val))
}
