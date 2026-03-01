//// Basecoat documentation: <https://basecoatui.com/components/toast/>
////
//// Toast helpers for short, temporary notifications.
////
//// **Note**: This component requires JavaScript from Basecoat.
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
//// import glaze_basecoat/toast
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

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Toast category (visual style).
pub type Category {
  Success
  Info
  Warning
  Error
}

/// Configuration used by [`show`](#show).
pub type Config {
  Config(
    category: Category,
    title: String,
    description: String,
    action: Option(Action),
    cancel: Option(Cancel),
  )
}

/// Optional toast action button.
pub type Action {
  Action(label: String, onclick: Option(String))
}

/// Optional toast cancel button.
pub type Cancel {
  Cancel(label: Option(String), onclick: Option(String))
}

pub fn toaster(attrs: List(Attribute(msg))) -> Element(msg) {
  html.div(
    list.append([attribute.id("toaster"), attribute.class("toaster")], attrs),
    [],
  )
}

pub fn toaster_aligned(
  align: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id("toaster"),
        attribute.class("toaster"),
        attribute.data("align", align),
      ],
      attrs,
    ),
    [],
  )
}

pub fn toast(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.class("toast"),
        attribute.role("status"),
        attribute.aria_atomic(True),
        attribute.aria_hidden(False),
      ],
      attrs,
    ),
    [
      html.div([attribute.class("toast-content")], children),
    ],
  )
}

pub fn success() -> Attribute(msg) {
  attribute.data("category", "success")
}

pub fn info() -> Attribute(msg) {
  attribute.data("category", "info")
}

pub fn warning() -> Attribute(msg) {
  attribute.data("category", "warning")
}

pub fn error() -> Attribute(msg) {
  attribute.data("category", "error")
}

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

pub fn action_button(label: String, attrs: List(Attribute(msg))) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.class("btn"),
        attribute.data("toast-action", ""),
      ],
      attrs,
    ),
    [html.text(label)],
  )
}

pub fn cancel_button(label: String, attrs: List(Attribute(msg))) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.class("btn-outline"),
      ],
      attrs,
    ),
    [html.text(label)],
  )
}

fn category_to_string(cat: Category) -> String {
  case cat {
    Success -> "success"
    Info -> "info"
    Warning -> "warning"
    Error -> "error"
  }
}

fn action_to_json(action: Action) -> String {
  let onclick_json = case action.onclick {
    Some(onclick) -> ", \"onclick\": \"" <> onclick <> "\""
    None -> ""
  }
  "{\"label\": \"" <> action.label <> "\"" <> onclick_json <> "}"
}

fn cancel_to_json(cancel: Cancel) -> String {
  let label_json = case cancel.label {
    Some(label) -> "\"label\": \"" <> label <> "\""
    None -> ""
  }
  let onclick_json = case cancel.onclick {
    Some(onclick) -> ", \"onclick\": \"" <> onclick <> "\""
    None -> ""
  }
  "{" <> label_json <> onclick_json <> "}"
}

pub fn show(config: Config) -> String {
  let category_str = category_to_string(config.category)
  let action_json = case config.action {
    Some(action) -> ", \"action\": " <> action_to_json(action)
    None -> ""
  }
  let cancel_json = case config.cancel {
    Some(cancel) -> ", \"cancel\": " <> cancel_to_json(cancel)
    None -> ""
  }
  "document.dispatchEvent(new CustomEvent('basecoat:toast', { detail: { config: { category: '"
  <> category_str
  <> "', title: '"
  <> config.title
  <> "', description: '"
  <> config.description
  <> "'"
  <> action_json
  <> cancel_json
  <> " } } }));"
}

pub fn show_simple(category: Category, title: String) -> String {
  show(Config(category, title, "", None, None))
}

pub fn success_toast(title: String, description: String) -> String {
  show(Config(Success, title, description, None, None))
}

pub fn error_toast(title: String, description: String) -> String {
  show(Config(Error, title, description, None, None))
}

import gleam/int
