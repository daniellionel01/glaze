//// Icon helpers for Lucide icons in Basecoat UIs.
////
//// Basecoat uses Lucide icons: <https://lucide.dev>
////
//// ## Anatomy
////
//// - [`icon`](#icon): render an icon placeholder element
//// - [`init`](#init): load Lucide via ESM (bundler/import map)
//// - [`register_cdn`](#register_cdn): load Lucide via CDN (no bundler)
////
//// ## Recipes
////
//// ```gleam
//// import glaze_basecoat/icon
////
//// icon.icon("plus", [])
//// ```
////
//// ```gleam
//// import glaze_basecoat/icon
////
//// html.head([], [
////   // Prefer a pinned version in real projects.
////   icon.register_cdn("latest"),
//// ])
//// ```
////
//// ## References
////
//// - Lucide icon list: <https://lucide.dev/icons>
//// - Lucide package guide: <https://lucide.dev/guide/packages/lucide>
////

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Initialize Lucide icons.
///
/// Add this script to your `<head>` to enable Lucide icon rendering.
/// Requires a JS setup that can resolve `import ... from "lucide"`.
///
pub fn init() -> Element(a) {
  html.script(
    [attribute.type_("module")],
    "import lucide from 'lucide'; lucide.createIcons();",
  )
}

/// Initialize Lucide icons via CDN (no bundler).
///
/// This injects Lucide's UMD build from unpkg and runs `lucide.createIcons()` on
/// `DOMContentLoaded`.
///
/// Lucide recommends pinning a specific version instead of using `latest`.
/// See: <https://lucide.dev/guide/packages/lucide>
///
pub fn register_cdn(lucide_version: String) -> Element(a) {
  element.fragment([
    html.script(
      [
        attribute("defer", "defer"),
        attribute.src(
          "https://unpkg.com/lucide@"
          <> lucide_version
          <> "/dist/umd/lucide.min.js",
        ),
      ],
      "",
    ),
    html.script(
      [],
      "window.addEventListener('DOMContentLoaded', () => lucide.createIcons());",
    ),
  ])
}

/// Render a Lucide icon by name.
///
/// Use the icon name from [lucide.dev/icons](https://lucide.dev/icons).
///
/// ## Example
///
/// ```gleam
/// import glaze_basecoat/icon
///
/// icon.icon("plus", [attribute.class("size-4")])
/// ```
///
pub fn icon(name: String, attrs: List(Attribute(a))) -> Element(a) {
  html.i(
    [attribute.class("lucide"), attribute("data-lucide", name), ..attrs],
    [],
  )
}

/// Common icon sizes for convenience.
///
pub fn size_xs() -> Attribute(a) {
  attribute.class("size-3")
}

pub fn size_sm() -> Attribute(a) {
  attribute.class("size-4")
}

pub fn size_md() -> Attribute(a) {
  attribute.class("size-5")
}

pub fn size_lg() -> Attribute(a) {
  attribute.class("size-6")
}

pub fn size_xl() -> Attribute(a) {
  attribute.class("size-8")
}

/// Stroke width variants.
///
pub fn thin() -> Attribute(a) {
  attribute.class("stroke-1")
}

pub fn normal() -> Attribute(a) {
  attribute.class("stroke-2")
}

pub fn bold() -> Attribute(a) {
  attribute.class("stroke-3")
}

/// Common icons as constants for convenience.
///
pub fn plus(attrs: List(Attribute(a))) -> Element(a) {
  icon("plus", attrs)
}

pub fn minus(attrs: List(Attribute(a))) -> Element(a) {
  icon("minus", attrs)
}

pub fn x(attrs: List(Attribute(a))) -> Element(a) {
  icon("x", attrs)
}

pub fn check(attrs: List(Attribute(a))) -> Element(a) {
  icon("check", attrs)
}

pub fn chevron_right(attrs: List(Attribute(a))) -> Element(a) {
  icon("chevron-right", attrs)
}

pub fn chevron_left(attrs: List(Attribute(a))) -> Element(a) {
  icon("chevron-left", attrs)
}

pub fn chevron_down(attrs: List(Attribute(a))) -> Element(a) {
  icon("chevron-down", attrs)
}

pub fn chevron_up(attrs: List(Attribute(a))) -> Element(a) {
  icon("chevron-up", attrs)
}

pub fn arrow_right(attrs: List(Attribute(a))) -> Element(a) {
  icon("arrow-right", attrs)
}

pub fn arrow_left(attrs: List(Attribute(a))) -> Element(a) {
  icon("arrow-left", attrs)
}

pub fn search(attrs: List(Attribute(a))) -> Element(a) {
  icon("search", attrs)
}

pub fn settings(attrs: List(Attribute(a))) -> Element(a) {
  icon("settings", attrs)
}

pub fn user(attrs: List(Attribute(a))) -> Element(a) {
  icon("user", attrs)
}

pub fn home(attrs: List(Attribute(a))) -> Element(a) {
  icon("home", attrs)
}

pub fn menu(attrs: List(Attribute(a))) -> Element(a) {
  icon("menu", attrs)
}

pub fn more_vertical(attrs: List(Attribute(a))) -> Element(a) {
  icon("more-vertical", attrs)
}

pub fn more_horizontal(attrs: List(Attribute(a))) -> Element(a) {
  icon("more-horizontal", attrs)
}

pub fn trash(attrs: List(Attribute(a))) -> Element(a) {
  icon("trash-2", attrs)
}

pub fn edit(attrs: List(Attribute(a))) -> Element(a) {
  icon("pencil", attrs)
}

pub fn copy(attrs: List(Attribute(a))) -> Element(a) {
  icon("copy", attrs)
}

pub fn external_link(attrs: List(Attribute(a))) -> Element(a) {
  icon("external-link", attrs)
}

pub fn mail(attrs: List(Attribute(a))) -> Element(a) {
  icon("mail", attrs)
}

pub fn phone(attrs: List(Attribute(a))) -> Element(a) {
  icon("phone", attrs)
}

pub fn calendar(attrs: List(Attribute(a))) -> Element(a) {
  icon("calendar", attrs)
}

pub fn clock(attrs: List(Attribute(a))) -> Element(a) {
  icon("clock", attrs)
}

pub fn info(attrs: List(Attribute(a))) -> Element(a) {
  icon("info", attrs)
}

pub fn alert_circle(attrs: List(Attribute(a))) -> Element(a) {
  icon("alert-circle", attrs)
}

pub fn alert_triangle(attrs: List(Attribute(a))) -> Element(a) {
  icon("alert-triangle", attrs)
}

pub fn check_circle(attrs: List(Attribute(a))) -> Element(a) {
  icon("check-circle", attrs)
}

pub fn x_circle(attrs: List(Attribute(a))) -> Element(a) {
  icon("x-circle", attrs)
}

pub fn loader(attrs: List(Attribute(a))) -> Element(a) {
  icon("loader-2", [attribute.class("animate-spin"), ..attrs])
}

pub fn refresh(attrs: List(Attribute(a))) -> Element(a) {
  icon("refresh-cw", attrs)
}

pub fn download(attrs: List(Attribute(a))) -> Element(a) {
  icon("download", attrs)
}

pub fn upload(attrs: List(Attribute(a))) -> Element(a) {
  icon("upload", attrs)
}

pub fn save(attrs: List(Attribute(a))) -> Element(a) {
  icon("save", attrs)
}

pub fn file(attrs: List(Attribute(a))) -> Element(a) {
  icon("file", attrs)
}

pub fn folder(attrs: List(Attribute(a))) -> Element(a) {
  icon("folder", attrs)
}

pub fn image(attrs: List(Attribute(a))) -> Element(a) {
  icon("image", attrs)
}

pub fn video(attrs: List(Attribute(a))) -> Element(a) {
  icon("video", attrs)
}

pub fn music(attrs: List(Attribute(a))) -> Element(a) {
  icon("music", attrs)
}

pub fn star(attrs: List(Attribute(a))) -> Element(a) {
  icon("star", attrs)
}

pub fn heart(attrs: List(Attribute(a))) -> Element(a) {
  icon("heart", attrs)
}

pub fn thumbs_up(attrs: List(Attribute(a))) -> Element(a) {
  icon("thumbs-up", attrs)
}

pub fn thumbs_down(attrs: List(Attribute(a))) -> Element(a) {
  icon("thumbs-down", attrs)
}

pub fn share(attrs: List(Attribute(a))) -> Element(a) {
  icon("share-2", attrs)
}

pub fn link(attrs: List(Attribute(a))) -> Element(a) {
  icon("link", attrs)
}

pub fn eye(attrs: List(Attribute(a))) -> Element(a) {
  icon("eye", attrs)
}

pub fn eye_off(attrs: List(Attribute(a))) -> Element(a) {
  icon("eye-off", attrs)
}

pub fn lock(attrs: List(Attribute(a))) -> Element(a) {
  icon("lock", attrs)
}

pub fn unlock(attrs: List(Attribute(a))) -> Element(a) {
  icon("unlock", attrs)
}

pub fn key(attrs: List(Attribute(a))) -> Element(a) {
  icon("key", attrs)
}

pub fn filter(attrs: List(Attribute(a))) -> Element(a) {
  icon("filter", attrs)
}

pub fn sort(attrs: List(Attribute(a))) -> Element(a) {
  icon("arrow-up-down", attrs)
}

pub fn grid(attrs: List(Attribute(a))) -> Element(a) {
  icon("grid-3x3", attrs)
}

pub fn list(attrs: List(Attribute(a))) -> Element(a) {
  icon("list", attrs)
}

pub fn moon(attrs: List(Attribute(a))) -> Element(a) {
  icon("moon", attrs)
}

pub fn sun(attrs: List(Attribute(a))) -> Element(a) {
  icon("sun", attrs)
}

pub fn github(attrs: List(Attribute(a))) -> Element(a) {
  icon("github", attrs)
}

pub fn twitter(attrs: List(Attribute(a))) -> Element(a) {
  icon("twitter", attrs)
}

pub fn linkedin(attrs: List(Attribute(a))) -> Element(a) {
  icon("linkedin", attrs)
}

pub fn facebook(attrs: List(Attribute(a))) -> Element(a) {
  icon("facebook", attrs)
}

pub fn instagram(attrs: List(Attribute(a))) -> Element(a) {
  icon("instagram", attrs)
}

pub fn youtube(attrs: List(Attribute(a))) -> Element(a) {
  icon("youtube", attrs)
}
