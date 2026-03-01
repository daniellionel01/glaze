//// Basecoat documentation: <https://basecoatui.com/components/card/>
////
//// The [`card`](#card) helpers build card containers with header, content, and footer.
////
//// ## Anatomy
////
//// A card typically includes a header (with title and description), content section,
//// and optional footer for actions.
////
//// ## Recipes
////
//// ### Simple card
////
//// ```gleam
//// import glaze_basecoat/card
//// import lustre/element/html
////
//// fn simple_card() {
////   card.card([], [
////     card.header([], [
////       card.title([], [html.text("Card Title")]),
////       card.description([], [html.text("Card description")]),
////     ]),
////     card.content([], [html.text("Content goes here")]),
////     card.footer([], [html.text("Footer")]),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a card container.
///
pub fn card(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("card"), ..attrs], children)
}

/// Render a card header.
///
/// Contains the title and optional description.
///
pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

/// Render a card title.
///
pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h2([attribute.class("text-lg font-semibold"), ..attrs], children)
}

/// Render a card description.
///
pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p([attribute.class("text-sm text-muted-foreground"), ..attrs], children)
}

/// Render card content.
///
pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}

/// Render a card footer.
///
/// Usually contains actions.
///
pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

/// Card with no padding on content.
///
pub fn no_padding() -> Attribute(msg) {
  attribute.class("p-0")
}
