//// Basecoat documentation: <https://basecoatui.com/components/tabs/>
////
//// Tabs display layered sections of content shown one at a time.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/tabs
////
//// fn settings_tabs() {
////   tabs.tabs("settings-tabs", [], [
////     tabs.tab("account", "Account", True, account_panel),
////     tabs.tab("password", "Password", False, password_panel),
////   ])
//// }
//// ```

import gleam/int
import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a tabs container.
///
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

/// Render a tab list.
///
pub fn tab_list(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav(
    [
      attribute.role("tablist"),
      attribute("aria-orientation", "horizontal"),
      attribute.class("w-full"),
      ..attrs
    ],
    children,
  )
}

/// Render a tab trigger button.
///
pub fn tab_trigger(
  id: String,
  panel_id: String,
  is_selected: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let selected_attr = case is_selected {
    True -> [attribute("aria-selected", "true")]
    False -> [attribute("aria-selected", "false")]
  }

  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.role("tab"),
        attribute.id(id),
        attribute("aria-controls", panel_id),
        attribute.tabindex(0),
      ],
      list.append(selected_attr, attrs),
    ),
    children,
  )
}

/// Render a tab panel.
///
pub fn tab_panel(
  id: String,
  tab_id: String,
  is_selected: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let selected_attr = case is_selected {
    True -> [attribute("aria-selected", "true")]
    False -> [attribute("aria-selected", "false"), attribute.hidden(True)]
  }

  html.div(
    list.append(
      [
        attribute.role("tabpanel"),
        attribute.id(id),
        attribute("aria-labelledby", tab_id),
        attribute.tabindex(-1),
      ],
      list.append(selected_attr, attrs),
    ),
    children,
  )
}

/// Render a complete tab set with triggers and panels.
///
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
