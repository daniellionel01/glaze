//// Oat documentation: https://oat.ink/components/progress/

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
