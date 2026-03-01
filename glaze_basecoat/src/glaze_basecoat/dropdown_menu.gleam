//// Basecoat documentation: <https://basecoatui.com/components/dropdown-menu/>
////
//// Displays a menu to the user — such as a set of actions or functions —
//// triggered by a button.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/dropdown_menu
////
//// fn my_dropdown() {
////   dropdown_menu.dropdown("my-menu", [
////     dropdown_menu.trigger([button.outline()], [html.text("Open")]),
////     dropdown_menu.content([dropdown_menu.min_width("14rem")], [
////       dropdown_menu.group("Options", [
////         dropdown_menu.item([], [html.text("Profile")]),
////         dropdown_menu.item([], [html.text("Settings")]),
////       ]),
////       dropdown_menu.separator(),
////       dropdown_menu.item([dropdown_menu.disabled()], [html.text("Logout")]),
////     ]),
////   ])
//// }
//// ```
////

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn dropdown(id: String, children: List(Element(msg))) -> Element(msg) {
  html.div([attribute.class("dropdown-menu"), attribute.id(id)], children)
}

pub fn trigger(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let trigger_id = "trigger"
  let menu_id = "menu"
  let popover_id = "popover"
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.id(trigger_id),
        attribute.aria_haspopup("menu"),
        attribute.aria_controls(menu_id),
        attribute.aria_expanded(False),
        attribute.popovertarget(popover_id),
      ],
      attrs,
    ),
    children,
  )
}

pub fn trigger_with_ids(
  trigger_id: String,
  menu_id: String,
  popover_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.id(trigger_id),
        attribute.aria_haspopup("menu"),
        attribute.aria_controls(menu_id),
        attribute.aria_expanded(False),
        attribute.popovertarget(popover_id),
      ],
      attrs,
    ),
    children,
  )
}

pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let popover_id = "popover"
  let menu_id = "menu"
  let trigger_id = "trigger"
  html.div(
    list.append(
      [
        attribute.id(popover_id),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
      ],
      attrs,
    ),
    [
      html.div(
        [
          attribute.role("menu"),
          attribute.id(menu_id),
          attribute.aria_labelledby(trigger_id),
        ],
        children,
      ),
    ],
  )
}

pub fn content_with_ids(
  popover_id: String,
  menu_id: String,
  trigger_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(popover_id),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
      ],
      attrs,
    ),
    [
      html.div(
        [
          attribute.role("menu"),
          attribute.id(menu_id),
          attribute.aria_labelledby(trigger_id),
        ],
        children,
      ),
    ],
  )
}

pub fn item(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(list.append([attribute.role("menuitem")], attrs), children)
}

pub fn item_with_shortcut(
  shortcut: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append([attribute.role("menuitem")], attrs),
    list.append(children, [
      html.span(
        [
          attribute.class(
            "text-muted-foreground ml-auto text-xs tracking-widest",
          ),
        ],
        [html.text(shortcut)],
      ),
    ]),
  )
}

pub fn checkbox_item(
  is_checked: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let checked_attr = case is_checked {
    True -> [attribute.aria_checked("true")]
    False -> [attribute.aria_checked("false")]
  }
  html.div(
    list.append(
      list.append([attribute.role("menuitemcheckbox")], checked_attr),
      attrs,
    ),
    children,
  )
}

pub fn radio_item(
  is_checked: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let checked_attr = case is_checked {
    True -> [attribute.aria_checked("true")]
    False -> [attribute.aria_checked("false")]
  }
  html.div(
    list.append(
      list.append([attribute.role("menuitemradio")], checked_attr),
      attrs,
    ),
    children,
  )
}

pub fn group(label: String, items: List(Element(msg))) -> Element(msg) {
  let label_id = "group-" <> label
  html.div(
    [attribute.role("group"), attribute.aria_labelledby(label_id)],
    list.append(
      [
        html.div([attribute.role("heading"), attribute.id(label_id)], [
          html.text(label),
        ]),
      ],
      items,
    ),
  )
}

pub fn separator() -> Element(msg) {
  html.hr([attribute.role("separator")])
}

pub fn heading(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append([attribute.role("heading"), attribute.id(id)], attrs),
    children,
  )
}

pub fn disabled() -> Attribute(msg) {
  attribute.aria_disabled(True)
}

pub fn min_width(width: String) -> Attribute(msg) {
  attribute.style("min-width", width)
}

pub fn side(s: String) -> Attribute(msg) {
  attribute.data("side", s)
}

pub fn align(a: String) -> Attribute(msg) {
  attribute.data("align", a)
}
