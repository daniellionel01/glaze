//// Basecoat documentation: <https://basecoatui.com/components/avatar/>
////
//// Avatar helpers for user/profile images.
////
//// These helpers style regular `<img>` elements (and a few common fallbacks)
//// so avatars look consistent across your UI.
////
//// ## Anatomy
////
//// - [`avatar`](#avatar) / [`rounded`](#rounded): image-based avatar
//// - [`initials`](#initials): text fallback
//// - [`group`](#group): stacked/overlapping avatar rows
////
//// ## Recipes
////
//// ### A user avatar
////
//// ```gleam
//// import glaze_basecoat/avatar
//// import lustre/attribute
////
//// fn user_avatar() {
////   avatar.avatar([
////     attribute.src("https://github.com/user.png"),
////     attribute.alt("User name"),
////   ])
//// }
//// ```
////
//// ### An avatar group
////
//// ```gleam
//// import glaze_basecoat/avatar
//// import lustre/attribute
////
//// fn team_avatars() {
////   avatar.group([], [
////     avatar.avatar([attribute.src("https://github.com/user1.png"), attribute.alt("User 1")]),
////     avatar.avatar([attribute.src("https://github.com/user2.png"), attribute.alt("User 2")]),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn avatar(attrs: List(Attribute(msg))) -> Element(msg) {
  html.img([
    attribute.class("size-8 shrink-0 object-cover rounded-full"),
    ..attrs
  ])
}

pub fn rounded(attrs: List(Attribute(msg))) -> Element(msg) {
  html.img([attribute.class("size-8 shrink-0 object-cover rounded-lg"), ..attrs])
}

pub fn initials(text: String, attrs: List(Attribute(msg))) -> Element(msg) {
  html.span(
    [
      attribute.class(
        "size-8 shrink-0 rounded-full bg-muted flex items-center justify-center text-sm font-medium",
      ),
      ..attrs
    ],
    [html.text(text)],
  )
}

pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class(
        "flex -space-x-2 [&_img]:ring-2 [&_img]:ring-background [&_img]:size-8 [&_img]:shrink-0 [&_img]:object-cover [&_img]:rounded-full",
      ),
      ..attrs
    ],
    children,
  )
}

pub fn small() -> Attribute(msg) {
  attribute.class("size-6")
}

pub fn large() -> Attribute(msg) {
  attribute.class("size-12")
}

pub fn extra_large() -> Attribute(msg) {
  attribute.class("size-16")
}
