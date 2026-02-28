//// Oat documentation: <https://oat.ink/components/card/>
////
//// The [`card`](#card) helpers compose grouped content blocks such as summaries,
//// settings sections, and dashboard tiles.
////
//// ## Anatomy
////
//// A card is typically an outer container with optional `header`, `content`,
//// and `footer` regions. You can use only the regions you need.
////
//// ## Recipes
////
//// ### A basic card
////
//// ```gleam
//// import glaze_oat/card
//// import lustre/element/html
////
//// fn profile_card() {
////   card.card([], [
////     card.header([], [html.h3([], [html.text("Profile")])]),
////     card.content([], [html.p([], [html.text("Update your details.")])]),
////     card.footer([], [html.button([], [html.text("Save")])]),
////   ])
//// }
//// ```
////
//// ### Content-only card
////
//// ```gleam
//// import glaze_oat/card
//// import lustre/element/html
////
//// fn simple_card() {
////   card.card([], [
////     card.content([], [html.text("Just content")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a card container as an `<article>`.
///
/// This is the default card helper and wraps [`instance`](#instance) with
/// `html.article`.
///
pub fn card(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.article, attrs, children)
}

/// Render a card using a custom container element.
///
/// Use this when you need card styling on a different semantic wrapper.
///
pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.class("card"), ..attrs], children)
}

/// Render a card header region using `<header>`.
///
pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

/// Render a card content region using `<main>`.
///
pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.main(attrs, children)
}

/// Render a card footer region using `<footer>`.
///
pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}
