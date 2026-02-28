//// Oat documentation: <https://oat.ink/components/accordion/>
////
//// The [`accordion`](#accordion) helpers render semantic HTML accordion markup
//// using `<details>` and `<summary>` elements.
////
//// This module is intentionally lightweight: it focuses on authoring structure,
//// while styling and container semantics are provided by the `element` function
//// you pass to [`accordion`](#accordion).
////
//// ## Anatomy
////
//// An accordion built with this module has:
////
//// - A container element provided to [`accordion`](#accordion). (**required**)
//// - One or more [`item`](#item) values, each rendered as `<details>`. (**required**)
//// - Optional [`group`](#group) values to coordinate item open-state. (**optional**)
////
//// ## Group behaviour
////
//// Items inside a [`group`](#group) get a shared `name` attribute on their
//// underlying `<details>` elements. Browsers use this to treat them as a
//// mutually-exclusive set, so opening one closes others with the same name.
////
//// Items not placed in a group are rendered without a `name` attribute and can
//// be opened independently.
////
//// ## Recipes
////
//// ### A basic accordion inside a section
////
//// ```gleam
//// import glaze_oat/accordion
//// import lustre/element/html
////
//// fn faq() {
////   accordion.accordion(
////     html.section,
////     [],
////     [
////       accordion.item(
////         label: html.text("What is Oat?"),
////         content: [html.p([], [html.text("A UI toolkit for Lustre.")])],
////       ),
////       accordion.item(
////         label: html.text("Does it use semantic HTML?"),
////         content: [html.p([], [html.text("Yes, with details/summary.")])],
////       ),
////     ],
////   )
//// }
//// ```
////
//// ### Multiple groups in one container
////
//// ```gleam
//// import glaze_oat/accordion
//// import lustre/element/html
////
//// fn settings_panels() {
////   accordion.accordion(
////     html.div,
////     [],
////     [
////       accordion.group("account", [
////         accordion.item(label: html.text("Profile"), content: [html.text("...")]),
////         accordion.item(label: html.text("Security"), content: [html.text("...")]),
////       ]),
////       accordion.group("notifications", [
////         accordion.item(label: html.text("Email"), content: [html.text("...")]),
////         accordion.item(label: html.text("Push"), content: [html.text("...")]),
////       ]),
////     ],
////   )
//// }
//// ```

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Represents an accordion entry in the tree passed to [`accordion`](#accordion).
///
/// Values are either:
///
/// - [`item`](#item): one rendered `<details>` block.
/// - [`group`](#group): a named collection of nested items.
///
/// This type is opaque to keep rendering rules internal and predictable.
pub opaque type Item(msg) {
  Item(label: Element(msg), content: List(Element(msg)))
  Group(name: String, items: List(Item(msg)))
}

/// Render an accordion container from a list of items.
///
/// You provide:
///
/// - `element`: the container constructor (for example `html.div`, `html.section`)
/// - `attrs`: attributes for that container
/// - `children`: items and/or groups to render
///
/// Each `item` renders to:
///
/// - `<details>`
///   - `<summary>{label}</summary>`
///   - `{content...}`
///
/// Grouped items include a shared `name` attribute on `<details>` to enable
/// browser-native single-open behavior within that group.
pub fn accordion(
  element: fn(List(Attribute(msg)), List(Element(msg))) -> Element(msg),
  attrs: List(Attribute(msg)),
  children: List(Item(msg)),
) -> Element(msg) {
  element(attrs, {
    use item <- list.flat_map(children)
    do_item_to_html(item, None)
  })
}

fn do_item_to_html(item: Item(msg), group: Option(String)) -> List(Element(msg)) {
  case item {
    Group(name:, items:) -> {
      use item <- list.flat_map(items)
      do_item_to_html(item, Some(name))
    }
    Item(label:, content:) -> {
      let attrs = case group {
        None -> []
        Some(group) -> [attribute.name(group)]
      }
      [html.details(attrs, [html.summary([], [label]), ..content])]
    }
  }
}

/// Create a named group of accordion items.
///
/// All items in a group are rendered with `<details name="{name}">`, allowing
/// the browser to manage them as a mutually-exclusive set.
///
/// Use distinct names for separate groups.
pub fn group(name: String, items: List(Item(msg))) -> Item(msg) {
  Group(name:, items:)
}

/// Create a single accordion item.
///
/// The `label` is rendered inside `<summary>`, and `content` is rendered as the
/// body of the corresponding `<details>`.
///
/// Keep the label concise and descriptive for accessibility and scanning.
pub fn item(
  label label: Element(msg),
  content content: List(Element(msg)),
) -> Item(msg) {
  Item(label:, content:)
}
