//// Basecoat documentation: <https://basecoatui.com/components/avatar/>
////
//// The [`avatar`](#avatar) helpers display user avatars with fallback initials.
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
//// ### Avatar with fallback
////
//// ```gleam
//// import glaze_basecoat/avatar
////
//// fn avatar_with_fallback() {
////   avatar.avatar_with_fallback(
////     src: "https://github.com/user.png",
////     alt: "John Doe",
////     fallback: "JD",
////   )
//// }
//// ```

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render an avatar image.
///
pub fn avatar(attrs: List(Attribute(msg))) -> Element(msg) {
  html.img([attribute.class("avatar"), ..attrs])
}

/// Render an avatar with fallback initials.
///
/// Shows the fallback when the image fails to load.
///
pub fn avatar_with_fallback(
  src src: String,
  alt alt: String,
  fallback fallback: String,
) -> Element(msg) {
  html.span([attribute.class("avatar")], [
    html.img([
      attribute.src(src),
      attribute.alt(alt),
      attribute.class("aspect-square h-full w-full"),
    ]),
    html.span([attribute.class("fallback")], [html.text(fallback)]),
  ])
}

/// Render an avatar with just initials (no image).
///
pub fn initials(fallback: String, attrs: List(Attribute(msg))) -> Element(msg) {
  html.span([attribute.class("avatar"), ..attrs], [
    html.span([attribute.class("fallback")], [html.text(fallback)]),
  ])
}

/// Avatar group for stacked avatars.
///
pub fn group(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [attribute.class("flex -space-x-2 *:ring-2 *:ring-background"), ..attrs],
    children,
  )
}

/// Small avatar size.
///
pub fn small() -> Attribute(msg) {
  attribute.class("avatar-sm")
}

/// Large avatar size.
///
pub fn large() -> Attribute(msg) {
  attribute.class("avatar-lg")
}
