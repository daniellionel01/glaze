//// Basecoat documentation: <https://basecoatui.com/components/select/>
////
//// A custom select with a styled dropdown. Requires Basecoat's JavaScript.
//// For the native `<select>` element, see `glaze/basecoat/native_select`.
////
//// The selected value is submitted through a hidden input named `name`.
//// Mark the initial option with [`selected`](#selected), or set a
//// [`placeholder`](#placeholder).
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/select
////
//// fn fruit() {
////   select.select("fruit", "fruit", [], [], [
////     select.group("Fruits", [
////       select.option("apple", [], [html.text("Apple")]),
////       select.option("banana", [select.selected()], [html.text("Banana")]),
////     ]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg

/// - `attrs` go on the root element.
/// - `trigger_attrs` go on the button that opens the dropdown, e.g. for its
///   width.
///
pub fn select(
  id: String,
  name: String,
  attrs: List(Attribute(msg)),
  trigger_attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  do_select(id, name, attrs, trigger_attrs, [], children)
}

/// Lets the user pick several options. The hidden input holds a JSON array
/// of the selected values.
///
pub fn select_multiple(
  id: String,
  name: String,
  attrs: List(Attribute(msg)),
  trigger_attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  do_select(
    id,
    name,
    attrs,
    trigger_attrs,
    [attribute("aria-multiselectable", "true")],
    children,
  )
}

fn do_select(
  id: String,
  name: String,
  attrs: List(Attribute(msg)),
  trigger_attrs: List(Attribute(msg)),
  listbox_attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let trigger_id = id <> "-trigger"
  let listbox_id = id <> "-listbox"

  html.div([attribute.id(id), attribute.class("select"), ..attrs], [
    html.button(
      [
        attribute.type_("button"),
        attribute.id(trigger_id),
        attribute.aria_haspopup("listbox"),
        attribute.aria_expanded(False),
        attribute.aria_controls(listbox_id),
        ..trigger_attrs
      ],
      [html.span([attribute.class("truncate")], []), chevron()],
    ),
    html.div(
      [
        attribute.id(id <> "-popover"),
        attribute("data-popover", ""),
        attribute.aria_hidden(True),
      ],
      [
        html.div(
          [
            attribute.role("listbox"),
            attribute.id(listbox_id),
            attribute.aria_orientation("vertical"),
            attribute.aria_labelledby(trigger_id),
            ..listbox_attrs
          ],
          children,
        ),
      ],
    ),
    html.input([attribute.type_("hidden"), attribute.name(name)]),
  ])
}

pub fn option(
  value: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [attribute.role("option"), attribute.data("value", value), ..attrs],
    children,
  )
}

pub fn group(label: String, children: List(Element(msg))) -> Element(msg) {
  html.div([attribute.role("group"), attribute.aria_label(label)], [
    html.div([attribute.role("heading")], [html.text(label)]),
    ..children
  ])
}

/// Wrap long option lists to make them scroll, e.g. `scroll_area("18rem", options)`.
///
pub fn scroll_area(
  max_height: String,
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class("scrollbar-sm overflow-y-auto"),
      attribute.style("max-height", max_height),
    ],
    children,
  )
}

pub fn separator() -> Element(msg) {
  html.hr([attribute.role("separator")])
}

/// Put this on an [`option`](#option) to select it initially.
///
pub fn selected() -> Attribute(msg) {
  attribute("aria-selected", "true")
}

/// Put this on an [`option`](#option).
///
pub fn disabled() -> Attribute(msg) {
  attribute("aria-disabled", "true")
}

/// Shown while nothing is selected. Put this in `attrs`.
///
pub fn placeholder(text: String) -> Attribute(msg) {
  attribute.data("placeholder", text)
}

/// For [`select_multiple`](#select_multiple): close the dropdown after
/// each pick. Put this in `attrs`.
///
pub fn close_on_select() -> Attribute(msg) {
  attribute.data("close-on-select", "true")
}

fn chevron() -> Element(msg) {
  svg.svg(
    [
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute("width", "24"),
      attribute("height", "24"),
      attribute("viewBox", "0 0 24 24"),
      attribute("fill", "none"),
      attribute("stroke", "currentColor"),
      attribute("stroke-width", "2"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-linejoin", "round"),
      attribute.class("text-muted-foreground opacity-50 shrink-0"),
    ],
    [svg.path([attribute("d", "m6 9 6 6 6-6")])],
  )
}
