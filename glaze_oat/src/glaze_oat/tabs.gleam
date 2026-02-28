//// Oat documentation: <https://oat.ink/components/tabs/>
////
//// Tabs helpers for grouped content views.
////
//// ## Anatomy
////
//// A tab view usually has a [`tablist`](#tablist) containing one or more
//// [`tab`](#tab) controls, plus matching [`tabpanel`](#tabpanel) sections.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/tabs
//// import lustre/attribute
//// import lustre/element/html
////
//// tabs.tabs([], [
////   tabs.tablist([], [
////     tabs.tab([attribute("aria-selected", "true")], [html.text("Overview")]),
////     tabs.tab([], [html.text("Details")]),
////   ]),
////   tabs.tabpanel([], [html.text("Overview content")]),
////   tabs.tabpanel([], [html.text("Details content")]),
//// ])
//// ```
////
//// ## References
////
//// - MDN ARIA `tablist` role:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tablist_role>
//// - MDN ARIA `tab` role:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tab_role>
//// - MDN ARIA `tabpanel` role:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tabpanel_role>

import lustre/attribute.{type Attribute}
import lustre/element.{type Element, element}
import lustre/element/html

/// Render the outer tabs container.
///
pub fn tabs(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element("ot-tabs", attrs, children)
}

/// Render the container that holds tab controls.
///
pub fn tablist(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.role("tablist"), ..attrs], children)
}

/// Render an individual tab control.
///
pub fn tab(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute.role("tab"), ..attrs], children)
}

/// Render a tab panel.
///
pub fn tabpanel(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute.role("tabpanel"), ..attrs], children)
}
