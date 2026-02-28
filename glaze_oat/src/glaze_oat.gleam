import lustre/attribute.{attribute}
import lustre/element.{type Element}
import lustre/element/html

pub const version = "0.4.0"

pub fn register(version: String) -> Element(a) {
  element.fragment([
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://unpkg.com/@knadh/oat@" <> version <> "/oat.min.css",
      ),
    ]),
    html.script(
      [
        attribute("defer", "defer"),
        attribute.src(
          "https://unpkg.com/@knadh/oat@" <> version <> "/oat.min.js",
        ),
      ],
      "",
    ),
    // Workaround until new version of Oat UI is released, since current documentation is out of date with version on unpkg.com
    html.style(
      [],
      "
      @layer utilities {
        :is(ul, ol, a).unstyled {
          list-style: none;
          text-decoration: none;
          padding: 0;
        }
      }
    ",
    ),
  ])
}
