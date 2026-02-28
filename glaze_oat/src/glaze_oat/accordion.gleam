//// Oat documentation: https://oat.ink/components/accordion/

import gleam/list
import gleam/option.{type Option, None, Some}
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub opaque type Item(msg) {
  Item(label: Element(msg), content: List(Element(msg)))
  Group(name: String, items: List(Item(msg)))
}

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

pub fn group(name: String, items: List(Item(msg))) -> Item(msg) {
  Group(name:, items:)
}

pub fn item(
  label label: Element(msg),
  content content: List(Element(msg)),
) -> Item(msg) {
  Item(label:, content:)
}
