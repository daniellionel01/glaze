//// Basecoat documentation: <https://basecoatui.com/components/kbd/>
////
//// The [`kbd`](#kbd) helpers display keyboard shortcuts.
////
//// ## Usage
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

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a keyboard key.
///
pub fn kbd(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.kbd([attribute.class("kbd"), ..attrs], children)
}

/// Render a keyboard shortcut with multiple keys.
///
pub fn shortcut(keys: List(String), attrs: List(Attribute(msg))) -> Element(msg) {
  let key_elements =
    keys
    |> list.map(fn(key) { kbd([], [html.text(key)]) })
    |> list.intersperse(html.text(" + "))

  html.span(attrs, key_elements)
}
