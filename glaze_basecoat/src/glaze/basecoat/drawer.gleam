//// Basecoat documentation: <https://basecoatui.com/components/drawer/>
////
//// A panel that slides in from an edge of the screen. Requires Basecoat's
//// JavaScript.
////
//// `attrs` go on the `<dialog>` element, `panel_attrs` on the visible panel
//// inside it. Clicking the backdrop closes the drawer.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/button
//// import glaze/basecoat/drawer
//// import lustre/attribute
//// import lustre/element/html
////
//// fn goal_drawer() {
////   html.div([], [
////     button.outline(
////       [attribute.attribute("onclick", drawer.open_script("goal"))],
////       [html.text("Open")],
////     ),
////     drawer.drawer("goal", "Move goal", [], [], [
////       drawer.content([], [html.text("Set your daily activity goal.")]),
////       drawer.footer([], [button.button([], [html.text("Submit")])]),
////     ]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn drawer(
  id: String,
  title: String,
  attrs: List(Attribute(msg)),
  panel_attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let title_id = id <> "-title"
  html.dialog(
    [
      attribute.class("drawer"),
      attribute.id(id),
      attribute.aria_labelledby(title_id),
      ..attrs
    ],
    [
      html.article(panel_attrs, [
        html.header([], [html.h2([attribute.id(title_id)], [html.text(title)])]),
        ..children
      ]),
    ],
  )
}

pub fn drawer_with_description(
  id: String,
  title: String,
  description: String,
  attrs: List(Attribute(msg)),
  panel_attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let title_id = id <> "-title"
  let desc_id = id <> "-description"
  html.dialog(
    [
      attribute.class("drawer"),
      attribute.id(id),
      attribute.aria_labelledby(title_id),
      attribute.aria_describedby(desc_id),
      ..attrs
    ],
    [
      html.article(panel_attrs, [
        html.header([], [
          html.h2([attribute.id(title_id)], [html.text(title)]),
          html.p([attribute.id(desc_id)], [html.text(description)]),
        ]),
        ..children
      ]),
    ],
  )
}

pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

/// Drawers open from the bottom by default.
///
pub fn top() -> Attribute(msg) {
  attribute.data("side", "top")
}

pub fn left() -> Attribute(msg) {
  attribute.data("side", "left")
}

pub fn right() -> Attribute(msg) {
  attribute.data("side", "right")
}

pub fn open_script(drawer_id: String) -> String {
  "document.getElementById('" <> drawer_id <> "').showModal()"
}

pub fn close_script(drawer_id: String) -> String {
  "document.getElementById('" <> drawer_id <> "').close()"
}
