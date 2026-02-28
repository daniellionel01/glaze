//// Basecoat documentation: <https://basecoatui.com/components/button/>
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
//// import glaze_basecoat/button
//// import lustre/element/html
////
//// fn save_button() {
////   button.button([], [html.text("Save")])
//// }
//// ```
////
//// ### A grouped action row
////
//// ```gleam
//// import glaze_basecoat/button
//// import lustre/element/html
////
//// fn actions() {
////   button.group([], [
////     button.button([button.outline()], [html.text("Cancel")]),
////     button.button([], [html.text("Continue")]),
////   ])
//// }
//// ```
////
//// ### A link styled as button
////
//// ```gleam
//// import glaze_basecoat/button
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
//// - [`primary`](#primary) - Primary button (default `btn`)
//// - [`secondary`](#secondary) - Secondary button
//// - [`destructive`](#destructive) - Destructive/danger button
//// - [`outline`](#outline) - Outline button
//// - [`ghost`](#ghost) - Ghost button
//// - [`link`](#link) - Link-styled button
////
//// ## Sizes
////
//// - [`small`](#small) - Small button
//// - [`large`](#large) - Large button

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
  html.div([attribute.class("flex items-center gap-2"), ..attrs], children)
}

/// Render a primary button for in-page actions.
///
/// Use this for primary actions like submit, save, or confirm.
///
pub fn button(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render a secondary button for in-page actions.
///
/// Use this for secondary actions.
///
pub fn secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-secondary"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render a destructive button for dangerous actions.
///
/// Use this for destructive actions like delete or remove.
///
pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-destructive"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render an outline button for in-page actions.
///
/// Use this for less prominent actions.
///
pub fn outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-outline"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render a ghost button for in-page actions.
///
/// Use this for subtle actions or in tight spaces.
///
pub fn ghost(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-ghost"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render a link-styled button for in-page actions.
///
/// Use this when you want a button that looks like a link.
///
pub fn link_style(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-link"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render an icon button for in-page actions.
///
/// Use this for buttons that only contain an icon.
///
pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-icon"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render an outline icon button.
///
pub fn icon_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-icon-outline"), attribute.type_("button"), ..attrs],
    children,
  )
}

/// Render a destructive icon button.
///
pub fn icon_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [
      attribute.class("btn-icon-destructive"),
      attribute.type_("button"),
      ..attrs
    ],
    children,
  )
}

/// Render a link (`<a>`) styled like a primary button.
///
/// Use this for navigation actions rather than state-changing actions.
///
pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn"), ..attrs], children)
}

/// Render a link (`<a>`) styled like a secondary button.
///
pub fn link_secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-secondary"), ..attrs], children)
}

/// Render a link (`<a>`) styled like an outline button.
///
pub fn link_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-outline"), ..attrs], children)
}

/// Render a link (`<a>`) styled like a ghost button.
///
pub fn link_ghost(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-ghost"), ..attrs], children)
}

/// Render a link (`<a>`) styled like a destructive button.
///
pub fn link_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-destructive"), ..attrs], children)
}

/// Size modifier for small buttons.
///
pub fn small() -> Attribute(msg) {
  attribute.class("btn-sm")
}

/// Size modifier for large buttons.
///
pub fn large() -> Attribute(msg) {
  attribute.class("btn-lg")
}

/// Button with full width.
///
pub fn full_width() -> Attribute(msg) {
  attribute.class("w-full")
}

/// Disabled state.
///
pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

/// Loading state with spinner.
///
/// Note: You should provide the spinner icon as a child.
///
pub fn loading() -> Attribute(msg) {
  attribute.disabled(True)
}

/// Render button styling on a submit button.
///
pub fn submit(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn"), attribute.type_("submit"), ..attrs],
    children,
  )
}

/// Render button styling on a reset button.
///
pub fn reset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn"), attribute.type_("reset"), ..attrs],
    children,
  )
}
