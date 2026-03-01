//// Oat documentation: <https://oat.ink/components/skeleton/>
////
//// Skeleton placeholders for loading layouts.
////
//// ## Anatomy
////
//// Use [`line`](#line) for text placeholders and [`box`](#box) for block
//// placeholders. Both are convenience helpers built on [`skeleton`](#skeleton).
////
//// ## Recipe
////
//// ```gleam
//// import glaze/oat/skeleton
////
//// [
////   skeleton.line([]),
////   skeleton.line([]),
////   skeleton.box([]),
//// ]
//// ```
////
//// ## References
////
//// - MDN ARIA `status` role:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/status_role>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn skeleton(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div([attribute.class("skeleton"), attribute.role("status"), ..attrs], [])
}

pub fn line(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("line"), ..attrs])
}

pub fn box(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("box"), ..attrs])
}
