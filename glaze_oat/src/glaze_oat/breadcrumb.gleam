//// Oat documentation: <https://oat.ink/components/breadcrumb/>
////
//// The [`breadcrumb`](#breadcrumb) helpers render hierarchical navigation for
//// showing where a user is in the app and how to move back up.
////
//// ## Anatomy
////
//// A breadcrumb usually contains:
////
//// - A [`breadcrumb`](#breadcrumb) container. (**required**)
//// - One or more linked items via [`link`](#link). (**required**)
//// - Separators such as [`slash`](#slash) or [`chevron`](#chevron). (**optional**)
//// - A non-interactive [`current`](#current) item for the current page. (**optional**)
////
//// ## Recipes
////
//// ### Basic breadcrumb
////
//// ```gleam
//// import glaze_oat/breadcrumb
//// import lustre/attribute
//// import lustre/element/html
////
//// fn nav() {
////   breadcrumb.breadcrumb([], [
////     breadcrumb.link([attribute.href("/")], [html.text("Home")]),
////     breadcrumb.chevron([]),
////     breadcrumb.link([attribute.href("/docs")], [html.text("Docs")]),
////     breadcrumb.chevron([]),
////     breadcrumb.current([], [html.text("Breadcrumb")]),
////   ])
//// }
//// ```
////
//// ### Slash separators
////
//// ```gleam
//// import glaze_oat/breadcrumb
//// import lustre/attribute
//// import lustre/element/html
////
//// fn nav() {
////   breadcrumb.breadcrumb([], [
////     breadcrumb.link([attribute.href("/")], [html.text("Home")]),
////     breadcrumb.slash([]),
////     breadcrumb.link([attribute.href("/settings")], [html.text("Settings")]),
////     breadcrumb.slash([]),
////     breadcrumb.current([], [html.text("Profile")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a breadcrumb navigation container.
///
/// Produces semantic markup:
///
/// - `<nav aria-label="breadcrumb">`
/// - inner ordered list `<ol>` containing breadcrumb items
pub fn breadcrumb(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav([attribute.aria_label("breadcrumb")], [
    html.ol(
      [
        attribute.class("unstyled hstack"),
        attribute.style("font-size", "var(--text-7)"),
        ..attrs
      ],
      children,
    ),
  ])
}

/// Render a presentational breadcrumb separator element.
///
/// Use this when you want a custom separator glyph or icon.
/// For accessibility, separators are hidden from assistive tech.
pub fn separator(
  attributes: List(Attribute(msg)),
  content: Element(msg),
) -> Element(msg) {
  html.li(
    [
      attribute.role("presentation"),
      attribute("aria-hidden", "true"),
      ..attributes
    ],
    [content],
  )
}

/// Render a `/` separator.
pub fn slash(attributes: List(Attribute(msg))) -> Element(msg) {
  separator(attributes, html.text("/"))
}

/// Render a `>` separator.
pub fn chevron(attributes: List(Attribute(msg))) -> Element(msg) {
  separator(attributes, html.text(">"))
}

/// Render the current page item in the breadcrumb.
///
/// This is marked as the current location with:
///
/// - `role="link"`
/// - `aria-disabled="true"`
/// - `aria-current="page"`
///
/// Use this for the last breadcrumb segment.
pub fn current(
  attributes: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(
    [
      attribute.role("link"),
      attribute("aria-disabled", "true"),
      attribute("aria-current", "page"),
      ..attributes
    ],
    children,
  )
}

/// Render a linked breadcrumb item.
///
/// This wraps an anchor in a list item so it participates correctly in the
/// ordered breadcrumb structure.
pub fn link(attrs: List(Attribute(msg)), children: List(Element(msg))) {
  html.li([], [html.a([attribute.class("unstyled"), ..attrs], children)])
}
