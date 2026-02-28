//// Oat documentation: <https://oat.ink/components/form/>
////
//// The [`form`](#form) helpers provide a compact set of primitives for building
//// accessible form layouts with native HTML elements.
////
//// ## Anatomy
////
//// A typical form has fields with labels, optional hints, and clear error
//// states. Use the attribute helpers in this module to keep those patterns
//// consistent.
////
//// ## Recipes
////
//// ### A basic labeled field
////
//// ```gleam
//// import glaze_oat/form
//// import lustre/attribute
//// import lustre/element/html
////
//// fn email_field() {
////   form.fieldset([form.field()], [
////     form.label([attribute.for("email")], [html.text("Email")]),
////     form.input([attribute.id("email"), attribute.type_("email")]),
////   ])
//// }
//// ```
////
//// ### A field with hint and error state
////
//// ```gleam
//// import glaze_oat/form
//// import lustre/attribute
//// import lustre/element/html
////
//// fn username_field() {
////   form.fieldset([form.field_error()], [
////     form.label([attribute.for("username")], [html.text("Username")]),
////     form.input([
////       attribute.id("username"),
////       form.invalid(),
////       form.described_by("username-hint"),
////     ]),
////     html.small([attribute.id("username-hint"), form.hint(), form.error()], [
////       html.text("Username is already taken."),
////     ]),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `aria-invalid`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid>
//// - MDN `aria-describedby`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-describedby>
//// - MDN ARIA `switch` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/switch_role>

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a form container.
///
/// Use this as the root element for grouped form controls.
///
pub fn form(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form(attrs, children)
}

/// Render a fieldset for related controls.
///
/// Useful for grouping controls that belong together.
///
pub fn fieldset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.fieldset(attrs, children)
}

/// Render a legend for a fieldset.
///
/// Use this as the visible title for a grouped set of controls.
///
pub fn legend(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.legend(attrs, children)
}

/// Render a form label.
///
/// Pair with `attribute.for(...)` to associate it with an input id.
///
pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label(attrs, children)
}

/// Render an input control.
///
pub fn input(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input(attrs)
}

/// Render a select control.
///
pub fn select(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.select(attrs, children)
}

/// Render an option inside a select.
///
pub fn option(attrs: List(Attribute(msg)), label: String) -> Element(msg) {
  html.option(attrs, label)
}

/// Render a textarea control.
///
pub fn textarea(attrs: List(Attribute(msg)), value: String) -> Element(msg) {
  html.textarea(attrs, value)
}

/// Mark a field container for default field styling.
///
pub fn field() -> Attribute(msg) {
  attribute("data-field", "")
}

/// Mark a field container as errored.
///
pub fn field_error() -> Attribute(msg) {
  attribute("data-field", "error")
}

/// Mark an element as helper or hint text.
///
pub fn hint() -> Attribute(msg) {
  attribute("data-hint", "")
}

/// Apply grouped control styling.
///
pub fn group() -> Attribute(msg) {
  attribute.class("group")
}

/// Apply error text styling.
///
pub fn error() -> Attribute(msg) {
  attribute.class("error")
}

/// Set ARIA `role="switch"` for switch-style controls.
///
pub fn as_switch() -> Attribute(msg) {
  attribute.role("switch")
}

/// Set `aria-invalid="true"`.
///
/// Use this on controls in an invalid state.
///
pub fn invalid() -> Attribute(msg) {
  attribute("aria-invalid", "true")
}

/// Set `aria-describedby` to reference hint or error text.
///
pub fn described_by(name: String) -> Attribute(msg) {
  attribute("aria-describedby", name)
}
