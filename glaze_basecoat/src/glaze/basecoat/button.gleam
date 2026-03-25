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
//// import glaze/basecoat/button
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
//// import glaze/basecoat/button
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
//// import glaze/basecoat/button
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
//// Size can be set via the [`small`](#small) or [`large`](#large) attribute
//// helpers when using a primary button. For other variants, pass the size to
//// the variant function directly (e.g., `outline_sm`, `destructive_lg`) to
//// produce the correct compound CSS class (e.g., `btn-sm-outline`).
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.class("flex items-center gap-2"), ..attrs], children)
}

pub fn button(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-secondary"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-destructive"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-outline"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn ghost(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-ghost"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn link_style(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-link"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-icon"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn icon_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-icon-outline"), attribute.type_("button"), ..attrs],
    children,
  )
}

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

pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn"), ..attrs], children)
}

pub fn link_secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-secondary"), ..attrs], children)
}

pub fn link_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-outline"), ..attrs], children)
}

pub fn link_ghost(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-ghost"), ..attrs], children)
}

pub fn link_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-destructive"), ..attrs], children)
}

pub fn small() -> Attribute(msg) {
  attribute.class("btn-sm")
}

pub fn large() -> Attribute(msg) {
  attribute.class("btn-lg")
}

// -- Small variant buttons --------------------------------------------------

pub fn secondary_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-sm-secondary"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn destructive_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-sm-destructive"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn outline_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-sm-outline"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn ghost_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-sm-ghost"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn link_style_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-sm-link"), attribute.type_("button"), ..attrs],
    children,
  )
}

// -- Large variant buttons --------------------------------------------------

pub fn secondary_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-lg-secondary"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn destructive_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-lg-destructive"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn outline_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-lg-outline"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn ghost_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-lg-ghost"), attribute.type_("button"), ..attrs],
    children,
  )
}

pub fn link_style_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn-lg-link"), attribute.type_("button"), ..attrs],
    children,
  )
}

// -- Small variant links ----------------------------------------------------

pub fn link_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-sm"), ..attrs], children)
}

pub fn link_secondary_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-sm-secondary"), ..attrs], children)
}

pub fn link_outline_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-sm-outline"), ..attrs], children)
}

pub fn link_ghost_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-sm-ghost"), ..attrs], children)
}

pub fn link_destructive_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-sm-destructive"), ..attrs], children)
}

// -- Large variant links ----------------------------------------------------

pub fn link_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-lg"), ..attrs], children)
}

pub fn link_secondary_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-lg-secondary"), ..attrs], children)
}

pub fn link_outline_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-lg-outline"), ..attrs], children)
}

pub fn link_ghost_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-lg-ghost"), ..attrs], children)
}

pub fn link_destructive_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a([attribute.class("btn-lg-destructive"), ..attrs], children)
}

pub fn full_width() -> Attribute(msg) {
  attribute.class("w-full")
}

pub fn disabled() -> Attribute(msg) {
  attribute.disabled(True)
}

pub fn loading() -> Attribute(msg) {
  attribute.disabled(True)
}

pub fn submit(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn"), attribute.type_("submit"), ..attrs],
    children,
  )
}

pub fn reset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    [attribute.class("btn"), attribute.type_("reset"), ..attrs],
    children,
  )
}
