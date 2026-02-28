//// Basecoat documentation: <https://basecoatui.com/components/skeleton/>
////
//// The [`skeleton`](#skeleton) helpers display loading placeholders.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/skeleton
////
//// fn loading_state() {
////   skeleton.skeleton([attribute.class("h-4 w-full")])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a skeleton placeholder.
///
/// Add width and height classes to size the skeleton.
///
pub fn skeleton(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div([attribute.class("skeleton"), ..attrs], [])
}

/// Render a skeleton that matches text size.
///
pub fn text(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("h-4 w-full"), ..attrs])
}

/// Render a skeleton that matches a circle (avatar).
///
pub fn circle(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("rounded-full h-10 w-10"), ..attrs])
}

/// Render a skeleton that matches an image.
///
pub fn image(attrs: List(Attribute(msg))) -> Element(msg) {
  skeleton([attribute.class("h-48 w-full"), ..attrs])
}
