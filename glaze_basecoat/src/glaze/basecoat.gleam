import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html

pub const version = "0.3.11"

/// Register Basecoat UI CSS and JavaScript from CDN.
///
/// This includes all Basecoat styles and JavaScript components.
/// Use this for quick setup without Tailwind CSS configuration.
///
/// ## Example
///
/// ```gleam
/// import glaze/basecoat
///
/// html.head([], [
///   basecoat.register(basecoat.version),
/// ])
/// ```
///
pub fn register(v: String) -> Element(a) {
  element.fragment([
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://cdn.jsdelivr.net/npm/basecoat-css@"
        <> v
        <> "/dist/basecoat.cdn.min.css",
      ),
    ]),
    html.script(
      [
        attribute("defer", "defer"),
        attribute.src(
          "https://cdn.jsdelivr.net/npm/basecoat-css@"
          <> v
          <> "/dist/js/all.min.js",
        ),
      ],
      "",
    ),
  ])
}

/// Register only Basecoat JavaScript from CDN.
///
/// Use this when you have Tailwind CSS configured and just need
/// the JavaScript for interactive components (dropdowns, tabs, toasts, etc.).
///
/// ## Example
///
/// ```gleam
/// import glaze/basecoat
///
/// html.head([], [
///   // Your Tailwind CSS import...
///   glaze_basecoat.register_js(glaze_basecoat.version),
/// ])
/// ```
///
pub fn register_js(v: String) -> Element(a) {
  html.script(
    [
      attribute("defer", "defer"),
      attribute.src(
        "https://cdn.jsdelivr.net/npm/basecoat-css@"
        <> v
        <> "/dist/js/all.min.js",
      ),
    ],
    "",
  )
}

/// Register a specific Basecoat JavaScript component from CDN.
///
/// Use this when you only need specific interactive components
/// (dropdown-menu, popover, select, sidebar, tabs, toast).
///
/// ## Example
///
/// ```gleam
/// import glaze/basecoat
///
/// html.head([], [
///   glaze_basecoat.register_css(glaze_basecoat.version),
///   glaze_basecoat.register_component(glaze_basecoat.version, "tabs"),
/// ])
/// ```
///
pub fn register_component(v: String, component: String) -> Element(a) {
  element.fragment([
    html.script(
      [
        attribute("defer", "defer"),
        attribute.src(
          "https://cdn.jsdelivr.net/npm/basecoat-css@"
          <> v
          <> "/dist/js/basecoat.min.js",
        ),
      ],
      "",
    ),
    html.script(
      [
        attribute("defer", "defer"),
        attribute.src(
          "https://cdn.jsdelivr.net/npm/basecoat-css@"
          <> v
          <> "/dist/js/"
          <> component
          <> ".min.js",
        ),
      ],
      "",
    ),
  ])
}

/// Register only Basecoat CSS from CDN.
///
/// Use this when you want to manage JavaScript separately.
///
pub fn register_css(v: String) -> Element(a) {
  html.link([
    attribute.rel("stylesheet"),
    attribute.href(
      "https://cdn.jsdelivr.net/npm/basecoat-css@"
      <> v
      <> "/dist/basecoat.cdn.min.css",
    ),
  ])
}

/// Add the toaster container required for toast notifications.
///
/// Place this at the end of your body element.
///
/// ## Example
///
/// ```gleam
/// import glaze/basecoat
///
/// html.body([], [
///   // Your content...
///   basecoat.toaster(),
/// ])
/// ```
///
pub fn toaster() -> Element(a) {
  html.div([attribute.id("toaster"), attribute.class("toaster")], [])
}
