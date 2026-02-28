//// Oat documentation: <https://oat.ink/components/dropdown/>
////
//// The [`dropdown`](#dropdown) helpers compose trigger and menu markup for
//// small action lists and contextual menus.
////
//// ## Anatomy
////
//// A dropdown usually has a trigger control and a popover menu with one or more
//// `item` actions.
////
//// ## Recipes
////
//// ### A basic dropdown menu
////
//// ```gleam
//// import glaze_oat/dropdown
//// import lustre/element/html
////
//// fn user_menu() {
////   dropdown.dropdown([], [
////     html.button([dropdown.trigger_for("user-menu")], [html.text("Open")]),
////     dropdown.menu("user-menu", [], [
////       dropdown.item([], [html.text("Profile")]),
////       dropdown.item([], [html.text("Sign out")]),
////     ]),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN Popover API: <https://developer.mozilla.org/en-US/docs/Web/API/Popover_API>
//// - MDN `popovertarget`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/button#popovertarget>
//// - MDN `<menu>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/menu>

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render the dropdown container element.
///
/// Use this as the wrapper around the trigger and the menu.
///
pub fn dropdown(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("ot-dropdown", attrs, children)
}

/// Set the popover target for a trigger control.
///
/// Apply this to the element that opens the dropdown menu.
///
pub fn trigger_for(name: String) -> Attribute(msg) {
  attribute.popovertarget(name)
}

/// Return the base attributes needed for a dropdown popover target.
///
/// This includes an `id` and an empty `popover` attribute.
///
pub fn popover_target_attrs(name: String) -> List(Attribute(msg)) {
  [attribute.id(name), attribute("popover", "")]
}

/// Render the dropdown menu.
///
/// Pass the same `name` used by [`trigger_for`](#trigger_for).
///
pub fn menu(
  name: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.menu(list.append(popover_target_attrs(name), attrs), children)
}

/// Render an item action inside a dropdown menu.
///
/// Each item is rendered as a button with `role="menuitem"`.
///
pub fn item(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute.role("menuitem"), ..attrs], children)
}
