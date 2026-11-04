import glaze/basecoat/theme
import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html

/// The latest supported version of Basecoat that is verified to work
/// and all components have been mapped for.
///
/// All releases are available here: https://github.com/hunvreus/basecoat/releases
///
pub const version = "1.1.0"

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
      attribute.src(
        "https://cdn.jsdelivr.net/npm/basecoat-css@"
        <> v
        <> "/dist/js/all.min.js",
      ),
    ],
    "",
  )
}

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
  cdn_stylesheet_with_style(v, Vega)
}

/// Basecoat's style packs: <https://basecoatui.com/installation/#cdn-files>
///
/// The default is Vega.
///
pub type Style {
  Vega
  Nova
  Maia
  Lyra
  Mira
  Luma
  Sera
  Rhea
}

/// Like [`cdn_stylesheet`](#cdn_stylesheet), but with a specific style pack.
///
pub fn cdn_stylesheet_with_style(v: String, style: Style) -> Element(a) {
  element.fragment([
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://cdn.jsdelivr.net/npm/basecoat-css@"
        <> v
        <> "/dist/basecoat-"
        <> style_to_string(style)
        <> ".cdn.min.css",
      ),
    ]),
    theme.tailwind_bridge_style_tag(),
  ])
}

fn style_to_string(style: Style) -> String {
  case style {
    Vega -> "vega"
    Nova -> "nova"
    Maia -> "maia"
    Lyra -> "lyra"
    Mira -> "mira"
    Luma -> "luma"
    Sera -> "sera"
    Rhea -> "rhea"
  }
}
