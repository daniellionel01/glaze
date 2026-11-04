//// Basecoat documentation: <https://basecoatui.com/components/scroll-area/>
////
//// Styled scrollbars for any scrollable element.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/scroll_area
//// import lustre/attribute
//// import lustre/element/html
////
//// fn tags() {
////   html.div([scroll_area.scrollbar(), attribute.class("h-72 overflow-y-auto")], [
////     html.text("..."),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}

pub fn scrollbar() -> Attribute(msg) {
  attribute.class("scrollbar")
}

/// A thinner scrollbar.
///
pub fn scrollbar_small() -> Attribute(msg) {
  attribute.class("scrollbar-sm")
}
