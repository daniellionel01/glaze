//// Basecoat documentation: <https://basecoatui.com/components/toast/>
////
//// Programmatic toast notifications.
////
//// ## Anatomy
////
//// - Render a container once with [`toaster`](#toaster)
//// - Trigger notifications either by rendering [`toast`](#toast) markup, or by
////   calling [`show`](#show) to build a JavaScript snippet
////
//// ## Recipes
////
//// ```gleam
//// import glaze/basecoat/toast
//// import lustre/element/html
////
//// fn success_toast_markup() {
////   toast.toast([toast.success()], [
////     toast.title([], [html.text("Success")]),
////     toast.description([], [html.text("Your changes have been saved.")]),
////   ])
//// }
//// ```
////
//// ```gleam
//// fn show_toast_script() {
////   toast.show(toast.Config(toast.Success, "Success", "Saved!", None, None))
//// }
//// ```
////
//// ## References
////
//// - MDN ARIA `status` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/status_role>
//// - MDN `CustomEvent`: <https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent>
////

import gleam/int
import gleam/json
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Name of the `CustomEvent` dispatched in the Browser environment.
///
/// ```js
/// document.dispatchEvent(new CustomEvent('basecoat:toast', /* payload */));
/// ```
///
pub const event_name = "basecoat:toast"

pub type Alignment {
  AlignStart
  AlignCenter
  AlignEnd
}

fn alignment_to_string(align: Alignment) {
  case align {
    AlignStart -> "start"
    AlignCenter -> "center"
    AlignEnd -> "end"
  }
}

pub type Action {
  Action(label: String, onclick: Option(String))
}

pub fn action_to_json(action: Action) -> json.Json {
  let Action(label:, onclick:) = action
  json.object([
    #("label", json.string(label)),
    #("onclick", case onclick {
      None -> json.null()
      Some(value) -> json.string(value)
    }),
  ])
}

pub type Cancel {
  Cancel(label: Option(String), onclick: Option(String))
}

pub fn cancel_to_json(cancel: Cancel) -> json.Json {
  let Cancel(label:, onclick:) = cancel
  json.object([
    #("label", case label {
      None -> json.null()
      Some(value) -> json.string(value)
    }),
    #("onclick", case onclick {
      None -> json.null()
      Some(value) -> json.string(value)
    }),
  ])
}

pub type Category {
  Success
  Info
  Warning
  Error
}

pub fn category_to_json(category: Category) -> json.Json {
  case category {
    Success -> json.string("success")
    Info -> json.string("info")
    Warning -> json.string("warning")
    Error -> json.string("error")
  }
}

pub type Config {
  Config(
    category: Category,
    title: String,
    description: String,
    action: Option(Action),
    cancel: Option(Cancel),
  )
}

pub fn config_to_json(config: Config) -> json.Json {
  let Config(category:, title:, description:, action:, cancel:) = config
  json.object([
    #("category", category_to_json(category)),
    #("title", json.string(title)),
    #("description", json.string(description)),
    #("action", case action {
      None -> json.null()
      Some(value) -> action_to_json(value)
    }),
    #("cancel", case cancel {
      None -> json.null()
      Some(value) -> cancel_to_json(value)
    }),
  ])
}

/// The toaster container required for toast notifications.
///
/// Place this at the end of your body element.
///
/// ### Example
///
/// ```gleam
/// import glaze/basecoat/toast
///
/// html.body([], [
///   // Your content...
///   toast.container([]),
/// ])
/// ```
///
pub fn container(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div([attribute.id("toaster"), attribute.class("toaster"), ..attrs], [])
}

/// Add the toaster container required for toast notifications.
///
/// Place this at the end of your body element.
///
/// ### Example
///
/// ```gleam
/// import glaze/basecoat/toast
///
/// html.body([], [
///   // Your content...
///   toast.container_aligned(toast.AlignStart, []),
/// ])
/// ```
///
pub fn container_aligned(
  align: Alignment,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.id("toaster"),
      attribute.class("toaster"),
      attribute.data("align", alignment_to_string(align)),
      ..attrs
    ],
    [],
  )
}

/// An element to create a custom toast.
///
/// The structure looks like this:
///
/// ```gleam
/// import glaze/basecoat/toast
/// import lustre/element/html
/// import lustre/element/svg
///
/// fn custom_toast() {
///   toast.toast([toast.success()], [
///     svg.svg([], [
///       // an icon...
///     ]),
///     toast.content([], [
///       toast.title([], [html.text("Lorem Ipsum!")]),
///       toast.description([], [html.text("Animi et eos quisquam debitis qui illum.")])
///     ]),
///     toast.footer([], [
///       toast.dismiss_button("go away", [])
///     ])
///   ])
/// }
/// ```
///
pub fn toast(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class("toast"),
      attribute.role("status"),
      attribute.aria_atomic(True),
      attribute.aria_hidden(False),
      ..attrs
    ],
    [
      html.div([attribute.class("toast-content")], children),
    ],
  )
}

/// Useful for when creating custom toasts with [`toast`](#toast).
///
pub fn success() -> Attribute(msg) {
  attribute.data("category", "success")
}

/// Useful for when creating custom toasts with [`toast`](#toast).
///
pub fn info() -> Attribute(msg) {
  attribute.data("category", "info")
}

/// Useful for when creating custom toasts with [`toast`](#toast).
///
pub fn warning() -> Attribute(msg) {
  attribute.data("category", "warning")
}

/// Useful for when creating custom toasts with [`toast`](#toast).
///
pub fn error() -> Attribute(msg) {
  attribute.data("category", "error")
}

/// Useful for when creating custom toasts with [`toast`](#toast).
///
pub fn duration(ms: Int) -> Attribute(msg) {
  attribute.data("duration", int.to_string(ms))
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h2(attrs, children)
}

pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p(attrs, children)
}

pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

pub fn dismiss_button(
  label: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.button(
    [
      attribute.type_("button"),
      attribute.class("btn"),
      attribute.data("toast-action", ""),
      ..attrs
    ],
    [html.text(label)],
  )
}

/// Trigger a toast notification.
///
/// Available in the Browser.
///
@external(javascript, "./toast.ffi.mjs", "dispatch")
pub fn dispatch(_config: Config) -> Nil {
  Nil
}
