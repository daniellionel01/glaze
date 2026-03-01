//// Basecoat documentation: <https://basecoatui.com/components/radio-group/>
////
//// The [`radio_group`](#radio_group) helpers display radio button groups.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/radio_group
//// import lustre/attribute
////
//// fn notification_preference() {
////   radio_group.group("notifications", [
////     radio_group.item("all", "All new messages", False),
////     radio_group.item("direct", "Direct messages only", True),
////     radio_group.item("none", "Nothing", False),
////   ], [])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a radio button group.
///
pub fn group(
  name: String,
  items: List(#(String, String, Bool)),
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  let options =
    items
    |> list.map(fn(item) {
      let #(value, label, checked) = item
      item_(name, value, label, checked, [])
    })

  html.fieldset([attribute.class("grid gap-3"), ..attrs], options)
}

/// Render a single radio option (alias for item_).
///
pub fn item(
  name: String,
  value: String,
  label_text: String,
  checked: Bool,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  item_(name, value, label_text, checked, attrs)
}

/// Render a single radio option with label.
///
fn item_(
  name: String,
  value: String,
  label_text: String,
  checked: Bool,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  let checked_attr = case checked {
    True -> [attribute.checked(True)]
    False -> []
  }

  html.label([attribute.class("label")], [
    html.input(list.append(
      [
        attribute.type_("radio"),
        attribute.name(name),
        attribute.value(value),
        attribute.class("input"),
      ],
      list.append(checked_attr, attrs),
    )),
    html.text(label_text),
  ])
}

/// Render a radio input without a label.
///
pub fn radio(
  name: String,
  value: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.input([
    attribute.type_("radio"),
    attribute.name(name),
    attribute.value(value),
    attribute.class("input"),
    ..attrs
  ])
}

/// Mark radio as checked.
///
pub fn checked() -> Attribute(msg) {
  attribute.checked(True)
}

/// Mark radio as disabled.
///
pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

/// Mark the group as invalid.
///
pub fn invalid() -> Attribute(msg) {
  attribute.aria_invalid("true")
}
