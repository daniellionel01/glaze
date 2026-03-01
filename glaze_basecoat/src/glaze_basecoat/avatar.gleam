//// Basecoat documentation: <https://basecoatui.com/components/avatar/>
////
//// Avatars are just `<img>` elements styled with Tailwind utility classes.
//// This module provides helpers to render avatars with consistent styling.
////
//// ## Recipes
////
//// ### User avatar
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
//// ### Avatar group
////
//// ```gleam
//// import glaze_basecoat/avatar
////
//// fn team_avatars() {
////   avatar.group([], [
////     avatar.avatar([attribute.src("https://github.com/user1.png"), attribute.alt("User 1")]),
////     avatar.avatar([attribute.src("https://github.com/user2.png"), attribute.alt("User 2")]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render an avatar image with default circular styling.
///
pub fn avatar(attrs: List(Attribute(msg))) -> Element(msg) {
  html.img([
    attribute.class("size-8 shrink-0 object-cover rounded-full"),
    ..attrs
  ])
}

/// Render an avatar with a square/rounded corners style.
///
pub fn rounded(attrs: List(Attribute(msg))) -> Element(msg) {
  html.img([attribute.class("size-8 shrink-0 object-cover rounded-lg"), ..attrs])
}

/// Render an avatar with just initials (no image).
///
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

/// Avatar group for stacked avatars.
///
/// Avatars will overlap with a ring around each.
///
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

/// Small avatar size (size-6).
///
pub fn small() -> Attribute(msg) {
  attribute.class("size-6")
}

/// Large avatar size (size-12).
///
pub fn large() -> Attribute(msg) {
  attribute.class("size-12")
}

/// Extra large avatar size (size-16).
///
pub fn extra_large() -> Attribute(msg) {
  attribute.class("size-16")
}
