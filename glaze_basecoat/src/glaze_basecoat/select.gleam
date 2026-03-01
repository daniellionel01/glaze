//// Basecoat documentation: <https://basecoatui.com/components/select/>
////
//// Select helpers for choosing one option from a list.
////
//// This module styles the native `<select>` element.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/select
////
//// fn my_select() {
////   select.select([select.name("fruit")], [
////     select.optgroup("Fruits", [
////       select.option("apple", "Apple", True),
////       select.option("banana", "Banana", False),
////     ]),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `<select>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/select>
//// - MDN `<option>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/option>

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn select(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.select(list.append([attribute.class("select")], attrs), children)
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
  html.option(list.append([attribute.value(value)], selected_attr), label)
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
    list.append(list.append([attribute.value(value)], selected_attr), attrs),
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
