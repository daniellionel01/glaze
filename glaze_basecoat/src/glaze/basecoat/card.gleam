//// Basecoat documentation: <https://basecoatui.com/components/card/>
////
//// The [`card`](#card) helpers compose grouped content blocks such as summaries,
//// settings sections, and dashboard tiles.
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
//// import glaze/basecoat/card
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

pub fn card(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("card"), ..attrs], children)
}

pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h2([attribute.class("text-lg font-semibold"), ..attrs], children)
}

pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p([attribute.class("text-sm text-muted-foreground"), ..attrs], children)
}

pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

pub fn no_padding() -> Attribute(msg) {
  attribute.class("p-0")
}
