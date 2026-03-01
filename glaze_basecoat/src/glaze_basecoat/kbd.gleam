//// Basecoat documentation: <https://basecoatui.com/components/kbd/>
////
//// Keyboard shortcut helpers built on `<kbd>`.
////
//// Use `kbd` for individual keys and [`shortcut`](#shortcut) for small key
//// sequences.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/kbd
//// import lustre/element/html
////
//// fn shortcut() {
////   html.p([], [
////     html.text("Press "),
////     kbd.kbd([], [html.text("⌘")]),
////     kbd.kbd([], [html.text("K")]),
////     html.text(" to search"),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `<kbd>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/kbd>

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn kbd(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.kbd([attribute.class("kbd"), ..attrs], children)
}

pub fn shortcut(keys: List(String), attrs: List(Attribute(msg))) -> Element(msg) {
  let key_elements =
    keys
    |> list.map(fn(key) { kbd([], [html.text(key)]) })
    |> list.intersperse(html.text(" + "))

  html.span(attrs, key_elements)
}
