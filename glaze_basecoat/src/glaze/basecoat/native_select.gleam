//// Basecoat documentation: <https://basecoatui.com/components/native-select/>
////
//// Select helpers for choosing one option from a list.
////
//// This module styles the native `<select>` element. For Basecoat's
//// JavaScript-driven select, see `glaze/basecoat/select`.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/native_select
////
//// fn my_select() {
////   native_select.native_select([native_select.name("fruit")], [
////     native_select.optgroup("Fruits", [
////       native_select.option("apple", "Apple", True),
////       native_select.option("banana", "Banana", False),
////     ]),
////   ])
//// }
//// ```
////

import glaze/basecoat/internal/listx
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn native_select(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.select([attribute.class("select"), ..attrs], children)
}

pub fn name(n: String) -> Attribute(msg) {
  attribute.name(n)
}

pub fn placeholder(p: String) -> Attribute(msg) {
  attribute.placeholder(p)
}

pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

pub fn required() -> Attribute(msg) {
  attribute.required(True)
}

pub fn multiple() -> Attribute(msg) {
  attribute.multiple(True)
}

pub fn optgroup(label: String, children: List(Element(msg))) -> Element(msg) {
  html.optgroup([attribute("label", label)], children)
}

pub fn option(value: String, label: String, selected: Bool) -> Element(msg) {
  let selected_attr = case selected {
    True -> [attribute.selected(True)]
    False -> []
  }
  html.option([attribute.value(value), ..selected_attr], label)
}

pub fn option_with_attrs(
  value: String,
  label: String,
  selected: Bool,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  let selected_attr = case selected {
    True -> [attribute.selected(True)]
    False -> []
  }
  html.option(
    listx.append3([attribute.value(value)], selected_attr, attrs),
    label,
  )
}

pub fn option_disabled(value: String, label: String) -> Element(msg) {
  html.option([attribute.value(value), attribute.disabled(True)], label)
}

pub fn width(w: String) -> Attribute(msg) {
  attribute.style("width", w)
}

pub fn full_width() -> Attribute(msg) {
  attribute.class("w-full")
}
