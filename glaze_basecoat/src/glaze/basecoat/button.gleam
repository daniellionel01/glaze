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
////     button.outline([], [html.text("Cancel")]),
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
////   button.link_outline([attribute.href("/docs")], [
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
//// Size can be set on any variant with the [`small`](#small) or
//// [`large`](#large) attribute helpers. The `_sm` and `_lg` functions are
//// shorthands for the same thing.
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
  html.button(btn("", "", "button", attrs), children)
}

pub fn secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("secondary", "", "button", attrs), children)
}

pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("destructive", "", "button", attrs), children)
}

pub fn outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("outline", "", "button", attrs), children)
}

pub fn ghost(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("ghost", "", "button", attrs), children)
}

pub fn link_style(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("link", "", "button", attrs), children)
}

pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("", "icon", "button", attrs), children)
}

pub fn icon_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("outline", "icon", "button", attrs), children)
}

pub fn icon_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("destructive", "icon", "button", attrs), children)
}

pub fn link(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("", "", attrs), children)
}

pub fn link_secondary(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("secondary", "", attrs), children)
}

pub fn link_outline(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("outline", "", attrs), children)
}

pub fn link_ghost(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("ghost", "", attrs), children)
}

pub fn link_destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("destructive", "", attrs), children)
}

pub fn small() -> Attribute(msg) {
  attribute.data("size", "sm")
}

pub fn large() -> Attribute(msg) {
  attribute.data("size", "lg")
}

// -- Small variant buttons --------------------------------------------------

pub fn secondary_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("secondary", "sm", "button", attrs), children)
}

pub fn destructive_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("destructive", "sm", "button", attrs), children)
}

pub fn outline_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("outline", "sm", "button", attrs), children)
}

pub fn ghost_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("ghost", "sm", "button", attrs), children)
}

pub fn link_style_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("link", "sm", "button", attrs), children)
}

// -- Large variant buttons --------------------------------------------------

pub fn secondary_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("secondary", "lg", "button", attrs), children)
}

pub fn destructive_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("destructive", "lg", "button", attrs), children)
}

pub fn outline_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("outline", "lg", "button", attrs), children)
}

pub fn ghost_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("ghost", "lg", "button", attrs), children)
}

pub fn link_style_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("link", "lg", "button", attrs), children)
}

// -- Small variant links ----------------------------------------------------

pub fn link_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("", "sm", attrs), children)
}

pub fn link_secondary_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("secondary", "sm", attrs), children)
}

pub fn link_outline_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("outline", "sm", attrs), children)
}

pub fn link_ghost_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("ghost", "sm", attrs), children)
}

pub fn link_destructive_sm(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("destructive", "sm", attrs), children)
}

// -- Large variant links ----------------------------------------------------

pub fn link_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("", "lg", attrs), children)
}

pub fn link_secondary_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("secondary", "lg", attrs), children)
}

pub fn link_outline_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("outline", "lg", attrs), children)
}

pub fn link_ghost_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("ghost", "lg", attrs), children)
}

pub fn link_destructive_lg(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(btn_attrs("destructive", "lg", attrs), children)
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

fn btn(
  variant: String,
  size: String,
  type_: String,
  attrs: List(Attribute(msg)),
) -> List(Attribute(msg)) {
  [attribute.type_(type_), ..btn_attrs(variant, size, attrs)]
}

fn btn_attrs(
  variant: String,
  size: String,
  attrs: List(Attribute(msg)),
) -> List(Attribute(msg)) {
  let attrs = case size {
    "" -> attrs
    size -> [attribute.data("size", size), ..attrs]
  }
  let attrs = case variant {
    "" -> attrs
    variant -> [attribute.data("variant", variant), ..attrs]
  }
  [attribute.class("btn"), ..attrs]
}

pub fn submit(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("", "", "submit", attrs), children)
}

pub fn reset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(btn("", "", "reset", attrs), children)
}
