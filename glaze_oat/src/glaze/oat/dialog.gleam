//// Oat documentation: <https://oat.ink/components/dialog/>
////
//// The [`dialog`](#dialog) helpers build native HTML dialog flows for
//// confirmations, forms, and focused tasks.
////
//// ## Anatomy
////
//// A dialog flow usually includes a dialog container, a trigger that opens it,
//// and actions that close it. Most dialogs also include a header/title and
//// footer actions.
////
//// ## Recipes
////
//// ### Open and close a dialog with command attributes
////
//// ```gleam
//// import glaze/oat/dialog
//// import lustre/attribute
//// import lustre/element/html
////
//// fn confirm_delete() {
////   let id = "delete-dialog"
////
////   html.div([], [
////     html.button(dialog.open_for(id), [html.text("Delete")]),
////     dialog.dialog([dialog.id(id)], [
////       dialog.header([], [dialog.title([], [html.text("Delete item?")])]),
////       html.p([], [html.text("This action cannot be undone.")]),
////       dialog.footer([], [
////         html.button(dialog.close_for(id), [html.text("Cancel")]),
////         html.button([attribute.class("danger")], [html.text("Delete")]),
////       ]),
////     ]),
////   ])
//// }
//// ```
////
//// ### Close from inside with a dialog form
////
//// ```gleam
//// import glaze/oat/dialog
//// import lustre/element/html
////
//// fn simple_dialog() {
////   dialog.dialog([dialog.id("settings")], [
////     dialog.form([], [
////       html.p([], [html.text("Done")]),
////       html.button([], [html.text("Close")]),
////     ]),
////   ])
//// }
//// ```
////
//// ## Close behavior
////
//// - [`closed_by_any`](#closed_by_any)
//// - [`closed_by_none`](#closed_by_none)
//// - [`closed_by_close_request`](#closed_by_close_request)
////
//// ## References
////
//// - MDN `<dialog>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog>
//// - MDN `HTMLDialogElement`: <https://developer.mozilla.org/en-US/docs/Web/API/HTMLDialogElement>
//// - MDN `<form>` `method` attribute (`method="dialog"`):
////   <https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/form#method>
//// - MDN Invoker Commands (`command`/`commandfor` on dialog controls):
////   <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog>

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a dialog container.
///
/// Use this as the root element for modal and non-modal dialog content.
///
pub fn dialog(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.dialog(attrs, children)
}

/// Set an `id` on a dialog.
///
/// Pair this with [`open_for`](#open_for) and [`close_for`](#close_for).
///
pub fn id(name: String) -> Attribute(msg) {
  attribute.id(name)
}

/// Attributes for a control that opens the target dialog.
///
/// Attach these to a button or other interactive element.
///
pub fn open_for(name: String) -> List(Attribute(msg)) {
  [attribute("commandfor", name), attribute("command", "show-modal")]
}

/// Attributes for a control that closes the target dialog.
///
/// Attach these to a button or other interactive element.
///
pub fn close_for(name: String) -> List(Attribute(msg)) {
  [attribute("commandfor", name), attribute("command", "close")]
}

/// Render a form that closes its parent dialog on submit.
///
/// Useful for cancel/confirm controls inside dialog content.
///
pub fn form(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form([attribute.method("dialog"), ..attrs], children)
}

/// Allow the dialog to close from any supported close interaction.
///
pub fn closed_by_any() -> Attribute(msg) {
  attribute("closedby", "any")
}

/// Prevent automatic close interactions.
///
pub fn closed_by_none() -> Attribute(msg) {
  attribute("closedby", "none")
}

/// Allow close requests such as Esc and explicit close commands.
///
pub fn closed_by_close_request() -> Attribute(msg) {
  attribute("closedby", "closerequest")
}

pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h3(attrs, children)
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}
