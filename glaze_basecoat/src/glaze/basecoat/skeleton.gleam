//// Basecoat documentation: <https://basecoatui.com/components/skeleton/>
////
//// Skeleton placeholders for loading layouts.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/skeleton
//// import lustre/attribute
////
//// fn loading_state() {
////   skeleton.skeleton([attribute.class("h-4 w-full")])
//// }
//// ```
////
//// ## References
////
//// - MDN ARIA `status` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/status_role>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn skeleton(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div([attribute.class("bg-accent animate-pulse rounded-md"), ..attrs], [])
}

pub fn text(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("h-4"), ..attrs])
}

pub fn circle(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("rounded-full size-10 shrink-0"), ..attrs])
}

pub fn image(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("aspect-square w-full"), ..attrs])
}
