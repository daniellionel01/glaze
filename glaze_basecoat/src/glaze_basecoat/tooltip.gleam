//// Basecoat documentation: <https://basecoatui.com/components/tooltip/>
////
//// A popup that displays information related to an element when the element
//// receives keyboard focus or the mouse hovers over it.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/tooltip
////
//// fn my_tooltip() {
////   tooltip.tooltip("my-tooltip", [
////     tooltip.trigger([], [html.text("Hover me")]),
////     tooltip.content([], [html.text("Tooltip text")]),
////   ])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn tooltip(id: String, children: List(Element(msg))) -> Element(msg) {
  html.div([attribute.class("tooltip"), attribute.id(id)], children)
}

pub fn trigger(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let tooltip_id = "tooltip"
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.aria_describedby(tooltip_id),
      ],
      attrs,
    ),
    children,
  )
}

pub fn trigger_with_id(
  tooltip_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.aria_describedby(tooltip_id),
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
  let tooltip_id = "tooltip"
  html.div(
    list.append(
      [
        attribute.id(tooltip_id),
        attribute.role("tooltip"),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
      ],
      attrs,
    ),
    children,
  )
}

pub fn content_with_id(
  tooltip_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(tooltip_id),
        attribute.role("tooltip"),
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
