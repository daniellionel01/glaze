//// Basecoat documentation: <https://basecoatui.com/components/tabs/>
////
//// Tabs helpers for grouped content views.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Anatomy
////
//// A tab view has a tablist of tab triggers and one or more matching tab panels.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/tabs
//// import lustre/element/html
////
//// fn settings_tabs() {
////   tabs.tab_set(
////     "settings-tabs",
////     [
////       #("account", "Account", True, html.div([], [html.text("Account")])),
////       #("password", "Password", False, html.div([], [html.text("Password")])),
////     ],
////     [],
////   )
//// }
//// ```
////
//// ## References
////
//// - MDN ARIA `tablist` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tablist_role>
//// - MDN ARIA `tab` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tab_role>
//// - MDN ARIA `tabpanel` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tabpanel_role>

import gleam/int
import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn tabs(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [attribute.class("tabs w-full"), attribute.id(id), ..attrs],
    children,
  )
}

pub fn tab_list(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav(
    [
      attribute.role("tablist"),
      attribute.aria_orientation("horizontal"),
      attribute.class("w-full"),
      ..attrs
    ],
    children,
  )
}

pub fn tab_trigger(
  id: String,
  panel_id: String,
  is_selected: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [
      attribute.type_("button"),
      attribute.role("tab"),
      attribute.id(id),
      attribute("aria-controls", panel_id),
      attribute.tabindex(0),
      attribute.aria_selected(is_selected),
      ..attrs
    ],
    children,
  )
}

pub fn tab_panel(
  id: String,
  tab_id: String,
  is_selected: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let selected_attr = case is_selected {
    True -> [attribute.aria_selected(True)]
    False -> [attribute.aria_selected(False), attribute.hidden(True)]
  }

  html.div(
    list.append(
      [
        attribute.role("tabpanel"),
        attribute.id(id),
        attribute.aria_labelledby(tab_id),
        attribute.tabindex(-1),
      ],
      list.append(selected_attr, attrs),
    ),
    children,
  )
}

pub fn tab_set(
  base_id: String,
  items: List(#(String, String, Bool, Element(msg))),
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  let triggers =
    items
    |> list.index_map(fn(item, index) {
      let #(_id, label, is_selected, _content) = item
      tab_trigger(
        base_id <> "-tab-" <> int.to_string(index),
        base_id <> "-panel-" <> int.to_string(index),
        is_selected,
        [],
        [html.text(label)],
      )
    })

  let panels =
    items
    |> list.index_map(fn(item, index) {
      let #(_id, _label, is_selected, content) = item
      tab_panel(
        base_id <> "-panel-" <> int.to_string(index),
        base_id <> "-tab-" <> int.to_string(index),
        is_selected,
        [],
        [content],
      )
    })

  tabs(base_id, attrs, [tab_list([], triggers), ..panels])
}
