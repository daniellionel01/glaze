//// Oat documentation: <https://oat.ink/components/switch/>
////
//// Switch helpers for binary on/off controls.
////
//// ## Anatomy
////
//// A switch UI is usually a checkbox input rendered with `role="switch"` and a
//// nearby label.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/switch
//// import lustre/attribute
//// import lustre/element/html
////
//// switch.label([], [
////   switch.switch([attribute.checked(True)]),
////   html.text("Enable notifications"),
//// ])
//// ```
////
//// ## References
////
//// - MDN ARIA `switch` role:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/switch_role>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a switch input.
///
pub fn switch(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input([attribute.type_("checkbox"), attribute.role("switch"), ..attrs])
}

/// Render a label for switch content.
///
pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label(attrs, children)
}
