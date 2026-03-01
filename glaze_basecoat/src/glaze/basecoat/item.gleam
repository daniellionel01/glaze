//// Basecoat documentation: <https://basecoatui.com/components/item/>
////
//// Item helpers for list rows and compact content blocks.
////
//// Use items for settings rows, search results, command-style lists, or any
//// repeated row content.
////
//// ## Anatomy
////
//// - [`item`](#item) / [`item_link`](#item_link): the row container
//// - [`icon`](#icon), [`avatar`](#avatar), [`image`](#image): leading visuals
//// - [`content`](#content): title/description stack
//// - [`actions`](#actions): trailing controls
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/item
//// import lustre/element/html
////
//// fn my_item() {
////   item.item([], [
////     item.title([], [html.text("My Item")]),
////     item.description([], [html.text("Item description here.")]),
////   ])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn item(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.article(
    list.append(
      [
        attribute.class(
          "group/item flex items-center border text-sm rounded-md transition-colors [a]:hover:bg-accent/50 [a]:transition-colors duration-100 flex-wrap outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] border-border p-4 gap-4",
        ),
      ],
      attrs,
    ),
    children,
  )
}

pub fn item_link(
  href: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(
    list.append(
      [
        attribute.href(href),
        attribute.class(
          "group/item flex items-center border text-sm rounded-md transition-colors [a]:hover:bg-accent/50 [a]:transition-colors duration-100 flex-wrap outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] border-border p-4 gap-4",
        ),
      ],
      attrs,
    ),
    children,
  )
}

pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append([attribute.class("flex flex-1 flex-col gap-1")], attrs),
    children,
  )
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h3(
    list.append(
      [
        attribute.class(
          "flex w-fit items-center gap-2 text-sm leading-snug font-medium",
        ),
      ],
      attrs,
    ),
    children,
  )
}

pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p(
    list.append(
      [
        attribute.class(
          "text-muted-foreground line-clamp-2 text-sm leading-normal font-normal text-balance",
        ),
      ],
      attrs,
    ),
    children,
  )
}

pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.class(
          "flex shrink-0 items-center justify-center gap-2 self-start [&_svg]:pointer-events-none size-8 border rounded-sm bg-muted [&_svg:not([class*='size-'])]:size-4",
        ),
      ],
      attrs,
    ),
    children,
  )
}

pub fn avatar(
  src: String,
  alt: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.img(list.append(
    [
      attribute.src(src),
      attribute.alt(alt),
      attribute.class("size-10 rounded-full object-cover"),
    ],
    attrs,
  ))
}

pub fn image(
  src: String,
  alt: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.img(list.append(
    [
      attribute.src(src),
      attribute.alt(alt),
      attribute.class("grayscale size-10 rounded-sm object-cover"),
    ],
    attrs,
  ))
}

pub fn actions(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [attribute.class("flex items-center gap-2 [&_svg]:size-4")],
      attrs,
    ),
    children,
  )
}

pub fn separator() -> Element(msg) {
  html.hr([attribute.role("separator"), attribute.class("border-border")])
}

pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(list.append([attribute.class("flex flex-col")], attrs), children)
}

pub fn muted() -> Attribute(msg) {
  attribute.class("border-transparent bg-muted/50")
}

pub fn outline() -> Attribute(msg) {
  attribute.class("border-border")
}

pub fn default() -> Attribute(msg) {
  attribute.class("border-transparent")
}
