//// Oat documentation: https://oat.ink/components/meter/

import gleam/float
import gleam/int
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn meter(attrs: List(Attribute(msg))) -> Element(msg) {
  html.meter(attrs, [])
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

pub fn min(amount: String) -> Attribute(msg) {
  attribute.min(amount)
}

pub fn min_int(amount: Int) -> Attribute(msg) {
  min(int.to_string(amount))
}

pub fn min_float(amount: Float) -> Attribute(msg) {
  min(float.to_string(amount))
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

pub fn low(amount: String) -> Attribute(msg) {
  attribute("low", amount)
}

pub fn low_int(amount: Int) -> Attribute(msg) {
  low(int.to_string(amount))
}

pub fn low_float(amount: Float) -> Attribute(msg) {
  low(float.to_string(amount))
}

pub fn high(amount: String) -> Attribute(msg) {
  attribute("high", amount)
}

pub fn high_int(amount: Int) -> Attribute(msg) {
  high(int.to_string(amount))
}

pub fn high_float(amount: Float) -> Attribute(msg) {
  high(float.to_string(amount))
}

pub fn optimum(amount: String) -> Attribute(msg) {
  attribute("optimum", amount)
}

pub fn optimum_int(amount: Int) -> Attribute(msg) {
  optimum(int.to_string(amount))
}

pub fn optimum_float(amount: Float) -> Attribute(msg) {
  optimum(float.to_string(amount))
}
