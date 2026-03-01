//// Oat documentation: <https://oat.ink/components/progress/>
////
//// Progress helpers for linear completion indicators.
////
//// ## Anatomy
////
//// Use [`progress`](#progress) with [`value`](#value) and [`max`](#max) to show
//// task completion. Typed helpers are available for `Int` and `Float` values.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/oat/progress
////
//// progress.progress([
////   progress.value_int(32),
////   progress.max_int(100),
//// ])
//// ```
////
//// ## References
////
//// - MDN `<progress>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/progress>

import gleam/float
import gleam/int
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn progress(attrs: List(Attribute(msg))) -> Element(msg) {
  html.progress(attrs, [])
}

pub fn value(amount: String) -> Attribute(msg) {
  attribute.value(amount)
}

pub fn value_int(amount: Int) -> Attribute(msg) {
  value(int.to_string(amount))
}

pub fn value_float(amount: Float) -> Attribute(msg) {
  value(float.to_string(amount))
}

pub fn max(amount: String) -> Attribute(msg) {
  attribute.max(amount)
}

pub fn max_int(amount: Int) -> Attribute(msg) {
  max(int.to_string(amount))
}

pub fn max_float(amount: Float) -> Attribute(msg) {
  max(float.to_string(amount))
}
