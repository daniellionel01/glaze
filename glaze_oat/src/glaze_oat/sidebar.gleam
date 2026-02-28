//// Oat documentation: <https://oat.ink/components/sidebar/>
////
//// Sidebar layout helpers for responsive app navigation.
////
//// ## Anatomy
////
//// A sidebar layout usually includes a layout wrapper, a toggle control, a
//// sidebar `aside`, and navigation content.
////
//// [`sidebar`](#sidebar) enables collapsible behavior on smaller screens,
//// while [`sidebar_always`](#sidebar_always) keeps the sidebar visible.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/sidebar
//// import lustre/element/html
////
//// sidebar.sidebar(html.div, [], [
////   sidebar.toggle([], [html.text("Menu")]),
////   sidebar.aside([], [sidebar.nav([], [html.text("Navigation")])]),
////   html.main([], [html.text("Content")]),
//// ])
//// ```

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a responsive sidebar layout wrapper.
///
/// Use this for layouts that collapse to a toggleable sidebar on small screens.
///
pub fn sidebar(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute("data-sidebar-layout", ""), ..attrs], children)
}

/// Render a sidebar layout that is always visible.
///
/// Use this for desktop-first layouts where the sidebar should never collapse.
///
pub fn sidebar_always(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element([attribute("data-sidebar-layout", "always"), ..attrs], children)
}

pub fn toggle(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute("data-sidebar-toggle", ""), ..attrs], children)
}

pub fn nav(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav(attrs, children)
}

pub fn topnav(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.nav([attribute("data-topnav", ""), ..attrs], children)
}

pub fn aside(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.aside([attribute("data-sidebar", ""), ..attrs], children)
}
