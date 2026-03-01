//// Basecoat documentation: <https://basecoatui.com/components/slider/>
////
//// Range slider helpers built on `<input type="range">`.
////
//// Use sliders when you need to pick a numeric value within a bounded range.
////
//// ## Recipe
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

pub fn slider(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.type_("range"), attribute.class("slider"), ..attrs])
}

pub fn min(val: Int) -> Attribute(msg) {
  attribute.min(int.to_string(val))
}

pub fn max(val: Int) -> Attribute(msg) {
  attribute.max(int.to_string(val))
}

pub fn value(val: Int) -> Attribute(msg) {
  attribute.value(int.to_string(val))
}

pub fn step(val: Int) -> Attribute(msg) {
  attribute.step(int.to_string(val))
}

pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

pub fn id(id: String) -> Attribute(msg) {
  attribute.id(id)
}

pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}
