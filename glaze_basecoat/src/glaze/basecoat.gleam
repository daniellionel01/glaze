import glaze/basecoat/theme
import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html

/// The latest supported version of Basecoat that is verified to work
/// and all components have been mapped for.
///
/// All releases are available here: https://github.com/hunvreus/basecoat/releases
///
pub const version = "0.3.11"

/// Register Basecoat UI CSS and JavaScript from a CDN.
///
/// This includes the styles and logic for all components.
///
/// ### Example
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
  element.fragment([cdn_stylesheet(v), cdn_script(v)])
}

/// <style> element that imports the Basecoat JavaScript from a CDN.
///
/// This includes the JavaScript for all components.
///
/// ### Example
///
/// ```gleam
/// import glaze/basecoat
///
/// html.head([], [
///   // Your Tailwind CSS import...
///   basecoat.cdn_script(basecoat.version),
/// ])
/// ```
///
pub fn cdn_script(v: String) -> Element(a) {
  html.script(
    [
      attribute("defer", "defer"),
      attribute.src(cdn_script_link(v)),
    ],
    "",
  )
}

@internal
pub fn cdn_script_link(v: String) -> String {
  "https://cdn.jsdelivr.net/npm/basecoat-css@" <> v <> "/dist/js/all.min.js"
}

@internal
pub fn cdn_stylesheet_link(v: String) -> String {
  "https://cdn.jsdelivr.net/npm/basecoat-css@"
  <> v
  <> "/dist/basecoat.cdn.min.css"
}

@target(javascript)
/// Ensure the <script> tag that loads the Basecoat JavaScript.
///
/// Available on the JavaScript target.
///
@external(javascript, "./basecoat_ffi.mjs", "append_cdn_script_to_head")
pub fn append_cdn_script_to_head(v: String) -> Nil

@target(javascript)
/// Ensure the <style> tag that loads the Basecoat CSS.
///
/// Available on the JavaScript target.
///
@external(javascript, "./basecoat_ffi.mjs", "append_cdn_stylesheet_to_head")
pub fn append_cdn_stylesheet_to_head(v: String) -> Nil

/// <style> tag that loads the Basecoat CSS from a CDN.
///
/// ### Example
///
/// ```gleam
/// import glaze/basecoat
///
/// html.head([], [
///   basecoat.cdn_stylesheet(basecoat.version),
/// ])
/// ```
///
pub fn cdn_stylesheet(v: String) -> Element(a) {
  element.fragment([
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(cdn_stylesheet_link(v)),
    ]),
    theme.tailwind_v4_bridge_style_tag(),
  ])
}
