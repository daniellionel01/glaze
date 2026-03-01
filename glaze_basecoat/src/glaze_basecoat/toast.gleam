//// Basecoat documentation: <https://basecoatui.com/components/toast/>
////
//// A succinct message that is displayed temporarily.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/toast
////
//// // Server-rendered toast
//// fn success_toast() {
////   toast.toast([toast.success()], [
////     toast.title("Success"),
////     toast.description("Your changes have been saved."),
////   ])
//// }
////
//// // Client-side toast via JavaScript
//// fn show_toast_script() {
////   toast.show(toast.Config("success", "Success", "Saved!", None, None))
//// }
//// ```

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub type Category {
  Success
  Info
  Warning
  Error
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

pub type Action {
  Action(label: String, onclick: Option(String))
}

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
        attribute("data-align", align),
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
        attribute("aria-atomic", "true"),
        attribute("aria-hidden", "false"),
      ],
      attrs,
    ),
    [
      html.div([attribute.class("toast-content")], children),
    ],
  )
}

pub fn success() -> Attribute(msg) {
  attribute("data-category", "success")
}

pub fn info() -> Attribute(msg) {
  attribute("data-category", "info")
}

pub fn warning() -> Attribute(msg) {
  attribute("data-category", "warning")
}

pub fn error() -> Attribute(msg) {
  attribute("data-category", "error")
}

pub fn duration(ms: Int) -> Attribute(msg) {
  attribute("data-duration", int.to_string(ms))
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
        attribute("data-toast-action", ""),
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
