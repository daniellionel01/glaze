//// Basecoat documentation: <https://basecoatui.com/components/popover/>
////
//// Popover helpers for rich floating content.
////
//// A popover typically has a trigger control and a floating content panel.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Anatomy
////
//// - [`trigger`](#trigger): the control that opens the popover
//// - [`content`](#content): the floating panel
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/popover
//// import lustre/element/html
////
//// fn my_popover() {
////   popover.popover("my-popover", [
////     popover.trigger([button.outline()], [html.text("Open")]),
////     popover.content([], [
////       html.p([], [html.text("Popover content here.")]),
////     ]),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN Popover API: <https://developer.mozilla.org/en-US/docs/Web/API/Popover_API>
//// - MDN `popovertarget`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/button#popovertarget>

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn popover(id: String, children: List(Element(msg))) -> Element(msg) {
  html.div([attribute.class("popover"), attribute.id(id)], children)
}

pub fn trigger(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let popover_id = "popover"
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.popovertarget(popover_id),
      ],
      attrs,
    ),
    children,
  )
}

pub fn trigger_with_id(
  popover_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
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
  html.div(
    list.append(
      [
        attribute.id(popover_id),
        attribute.popover(""),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
      ],
      attrs,
    ),
    children,
  )
}

pub fn content_with_id(
  popover_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(popover_id),
        attribute.popover(""),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
      ],
      attrs,
    ),
    children,
  )
}

pub fn side(s: String) -> Attribute(msg) {
  attribute.data("side", s)
}

pub fn align(a: String) -> Attribute(msg) {
  attribute.data("align", a)
}

pub fn side_top() -> Attribute(msg) {
  side("top")
}

pub fn side_bottom() -> Attribute(msg) {
  side("bottom")
}

pub fn side_left() -> Attribute(msg) {
  side("left")
}

pub fn side_right() -> Attribute(msg) {
  side("right")
}

pub fn align_start() -> Attribute(msg) {
  align("start")
}

pub fn align_center() -> Attribute(msg) {
  align("center")
}

pub fn align_end() -> Attribute(msg) {
  align("end")
}
