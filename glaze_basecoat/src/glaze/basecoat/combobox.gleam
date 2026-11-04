//// Basecoat documentation: <https://basecoatui.com/components/combobox/>
////
//// A text input that filters a list of options as you type. Requires
//// Basecoat's JavaScript.
////
//// Options, groups and separators come from `glaze/basecoat/select`. The
//// selected value is submitted through a hidden input named `name`.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/combobox
//// import glaze/basecoat/select
//// import lustre/element/html
////
//// fn framework() {
////   combobox.combobox("framework", "framework", "Select framework...", "No framework found.", [], [
////     select.option("next", [], [html.text("Next.js")]),
////     select.option("astro", [], [html.text("Astro")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg

/// `empty_message` is shown when no option matches the input.
///
pub fn combobox(
  id: String,
  name: String,
  placeholder: String,
  empty_message: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  do_combobox(id, name, placeholder, empty_message, attrs, [], children)
}

/// Lets the user pick several options, shown as chips. The hidden input
/// holds a JSON array of the selected values.
///
pub fn combobox_multiple(
  id: String,
  name: String,
  placeholder: String,
  empty_message: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  do_combobox(
    id,
    name,
    placeholder,
    empty_message,
    attrs,
    [attribute("aria-multiselectable", "true")],
    children,
  )
}

fn do_combobox(
  id: String,
  name: String,
  placeholder: String,
  empty_message: String,
  attrs: List(Attribute(msg)),
  listbox_attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let listbox_id = id <> "-listbox"

  html.div([attribute.id(id), attribute.class("combobox"), ..attrs], [
    html.input([
      attribute.type_("text"),
      attribute.role("combobox"),
      attribute.placeholder(placeholder),
      attribute.autocomplete("off"),
      attribute("autocorrect", "off"),
      attribute("spellcheck", "false"),
      attribute("aria-autocomplete", "list"),
      attribute.aria_expanded(False),
      attribute.aria_controls(listbox_id),
    ]),
    chevron(),
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
            attribute.data("empty", empty_message),
            ..listbox_attrs
          ],
          children,
        ),
      ],
    ),
    html.input([attribute.type_("hidden"), attribute.name(name)]),
  ])
}

/// Highlight the first matching option while typing. Put this in `attrs`.
///
pub fn auto_highlight() -> Attribute(msg) {
  attribute.data("auto-highlight", "true")
}

/// For [`combobox_multiple`](#combobox_multiple): close the list after
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
      attribute.class("combobox-trigger-icon"),
    ],
    [svg.path([attribute("d", "m6 9 6 6 6-6")])],
  )
}
