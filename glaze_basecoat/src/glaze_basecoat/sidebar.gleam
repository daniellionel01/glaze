//// Basecoat documentation: <https://basecoatui.com/components/sidebar/>
////
//// A composable, themeable and customizable sidebar component.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/sidebar
//// import lustre/element/html
////
//// fn main_sidebar() {
////   sidebar.sidebar("main-nav", [sidebar.left()], [
////     sidebar.nav([], [
////       sidebar.section([], [
////         sidebar.group("Getting started", [
////           sidebar.link("#", True, [], [html.text("Playground")]),
////           sidebar.link("#", False, [], [html.text("Models")]),
////         ]),
////       ]),
////     ]),
////   ])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub type Side {
  Left
  Right
}

pub fn sidebar(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.aside(
    list.append(
      [
        attribute.class("sidebar"),
        attribute.id(id),
        attribute("aria-hidden", "false"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn left() -> Attribute(msg) {
  attribute("data-side", "left")
}

pub fn right() -> Attribute(msg) {
  attribute("data-side", "right")
}

pub fn hidden() -> Attribute(msg) {
  attribute("aria-hidden", "true")
}

pub fn visible() -> Attribute(msg) {
  attribute("aria-hidden", "false")
}

pub fn nav(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav(attrs, children)
}

pub fn nav_with_label(
  label: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav(list.append([attribute("aria-label", label)], attrs), children)
}

pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

pub fn section(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(list.append([attribute.class("scrollbar")], attrs), children)
}

pub fn group(label: String, items: List(Element(msg))) -> Element(msg) {
  let label_id = "group-label-" <> label
  html.div(
    [
      attribute.role("group"),
      attribute("aria-labelledby", label_id),
    ],
    [
      html.h3([attribute.id(label_id), attribute.class("text-sm font-medium")], [
        html.text(label),
      ]),
      html.ul([], items),
    ],
  )
}

pub fn group_with_attrs(
  label: String,
  attrs: List(Attribute(msg)),
  items: List(Element(msg)),
) -> Element(msg) {
  let label_id = "group-label-" <> label
  html.div(
    list.append(
      [
        attribute.role("group"),
        attribute("aria-labelledby", label_id),
      ],
      attrs,
    ),
    [
      html.h3([attribute.id(label_id), attribute.class("text-sm font-medium")], [
        html.text(label),
      ]),
      html.ul([], items),
    ],
  )
}

pub fn link(
  href: String,
  is_current: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let current_attr = case is_current {
    True -> [attribute("aria-current", "page")]
    False -> []
  }
  html.li([], [
    html.a(
      list.append(list.append([attribute.href(href)], current_attr), attrs),
      children,
    ),
  ])
}

pub fn button(
  is_current: Bool,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let current_attr = case is_current {
    True -> [attribute("aria-current", "page")]
    False -> []
  }
  html.li([], [
    html.button(
      list.append(
        list.append(
          [attribute.type_("button"), attribute.class("w-full text-left")],
          current_attr,
        ),
        attrs,
      ),
      children,
    ),
  ])
}

pub fn submenu(
  id: String,
  label: String,
  attrs: List(Attribute(msg)),
  items: List(Element(msg)),
) -> Element(msg) {
  html.li([], [
    html.details(list.append([attribute.id(id)], attrs), [
      html.summary([attribute("aria-controls", id <> "-content")], [
        html.text(label),
      ]),
      html.ul([attribute.id(id <> "-content")], items),
    ]),
  ])
}

pub fn submenu_with_icon(
  id: String,
  icon: Element(msg),
  label: String,
  attrs: List(Attribute(msg)),
  items: List(Element(msg)),
) -> Element(msg) {
  html.li([], [
    html.details(list.append([attribute.id(id)], attrs), [
      html.summary([attribute("aria-controls", id <> "-content")], [
        icon,
        html.text(label),
      ]),
      html.ul([attribute.id(id <> "-content")], items),
    ]),
  ])
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

pub fn toggle_script(sidebar_id: String) -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '"
  <> sidebar_id
  <> "' } }));"
}

pub fn toggle_script_default() -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:sidebar'));"
}

pub fn open_script(sidebar_id: String) -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '"
  <> sidebar_id
  <> "', action: 'open' } }));"
}

pub fn close_script(sidebar_id: String) -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '"
  <> sidebar_id
  <> "', action: 'close' } }));"
}
