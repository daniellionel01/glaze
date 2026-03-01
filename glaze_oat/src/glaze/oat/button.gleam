//// Oat documentation: <https://oat.ink/components/button/>
////
//// The [`button`](#button) helpers style interactive actions and links with a
//// consistent API.
////
//// Use regular buttons for in-page actions, and use [`link`](#link) when the
//// interaction navigates to a different location.
////
//// ## Anatomy
////
//// A button setup usually has one interactive element and optional button groups.
//// `group` wraps multiple actions in a semantic menu/list structure so spacing
//// and alignment stay consistent.
////
//// ## Recipes
////
//// ### A primary action button
////
//// ```gleam
//// import glaze/oat/button
//// import lustre/element/html
////
//// fn save_button() {
////   button.button([button.primary()], [html.text("Save")])
//// }
//// ```
////
//// ### A grouped action row
////
//// ```gleam
//// import glaze/oat/button
//// import lustre/element/html
////
//// fn actions() {
////   button.group([], [
////     button.button([button.secondary()], [html.text("Cancel")]),
////     button.button([button.primary()], [html.text("Continue")]),
////   ])
//// }
//// ```
////
//// ### A link styled as button
////
//// ```gleam
//// import glaze/oat/button
//// import lustre/attribute
//// import lustre/element/html
////
//// fn docs_link() {
////   button.link([attribute.href("/docs"), button.outline()], [
////     html.text("Read docs"),
////   ])
//// }
//// ```
////
//// ## Variants
////
//// - [`primary`](#primary)
//// - [`secondary`](#secondary)
//// - [`danger`](#danger)
//// - [`outline`](#outline)
//// - [`ghost`](#ghost)
////
//// ## Sizes
////
//// - [`small`](#small)
//// - [`large`](#large)

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render buttons as an action group.
///
/// Use this when actions are related and should be visually grouped.
///
pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.menu([attribute.class("buttons"), ..attrs], {
    use child <- list.map(children)
    html.li([], [child])
  })
}

/// Render a button for in-page actions.
///
/// Use this for actions like submit, save, open, or confirm.
///
pub fn button(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.button, attrs, children)
}

/// Render a link (`<a>`) styled like a button.
///
/// Use this for navigation actions rather than state-changing actions.
///
pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  instance(html.a, [attribute.class("button"), ..attrs], children)
}

/// Render button styling on a custom element.
///
/// This is mostly useful in advanced cases.
///
pub fn instance(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute.role("button"), ..attrs], children)
}

pub fn primary() -> Attribute(msg) {
  attribute.data("data-variant", "primary")
}

pub fn secondary() -> Attribute(msg) {
  attribute.data("data-variant", "secondary")
}

pub fn danger() -> Attribute(msg) {
  attribute.data("data-variant", "danger")
}

pub fn outline() -> Attribute(msg) {
  attribute.class("outline")
}

pub fn ghost() -> Attribute(msg) {
  attribute.class("ghost")
}

pub fn small() -> Attribute(msg) {
  attribute.class("small")
}

pub fn large() -> Attribute(msg) {
  attribute.class("large")
}
