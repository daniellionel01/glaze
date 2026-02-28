//// Basecoat documentation: <https://basecoatui.com/components/progress/>
////
//// The [`progress`](#progress) helpers display progress indicators.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/progress
//// import lustre/attribute
////
//// fn download_progress() {
////   progress.progress([
////     attribute.value(75),
////     attribute.max(100),
////   ])
//// }
//// ```

import gleam/int
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a progress bar.
///
/// Use the `value` and `max` attributes to set progress.
///
pub fn progress(attrs: List(Attribute(msg))) -> Element(msg) {
  html.progress([attribute.class("progress"), ..attrs], [])
}

/// Set the progress value (0-100).
///
pub fn value(val: Int) -> Attribute(msg) {
  attribute.value(int.to_string(val))
}

/// Set the max value (default is 100).
///
pub fn max(val: Int) -> Attribute(msg) {
  attribute.max(int.to_string(val))
}
