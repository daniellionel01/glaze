import lustre/attribute.{attribute}
import lustre/element/html

pub const version = "0.4.1"

pub fn stylesheet(version: String) {
  html.link([
    attribute.rel("stylesheet"),
    attribute.href("https://unpkg.com/@knadh/oat@" <> version <> "/oat.min.css"),
  ])
}

pub fn script(version: String) {
  html.script(
    [
      attribute("defer", "defer"),
      attribute.src("https://unpkg.com/@knadh/oat@" <> version <> "/oat.min.js"),
    ],
    "",
  )
}
