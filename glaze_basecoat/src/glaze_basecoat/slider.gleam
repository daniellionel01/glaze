//// Basecoat documentation: <https://basecoatui.com/components/slider/>
////
//// The [`slider`](#slider) helpers display range input sliders.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/slider
////
//// fn volume_slider() {
////   slider.slider([
////     slider.min(0),
////     slider.max(100),
////     slider.value(50),
////   ])
//// }
//// ```
////

import gleam/int
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a range slider.
///
pub fn slider(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.type_("range"), attribute.class("slider"), ..attrs])
}

/// Set the minimum value.
///
pub fn min(val: Int) -> Attribute(msg) {
  attribute.min(int.to_string(val))
}

/// Set the maximum value.
///
pub fn max(val: Int) -> Attribute(msg) {
  attribute.max(int.to_string(val))
}

/// Set the current value.
///
pub fn value(val: Int) -> Attribute(msg) {
  attribute.value(int.to_string(val))
}

/// Set the step increment.
///
pub fn step(val: Int) -> Attribute(msg) {
  attribute.step(int.to_string(val))
}

/// Set the slider name.
///
pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

/// Set the slider id.
///
pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}

/// Mark slider as disabled.
///
pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}
