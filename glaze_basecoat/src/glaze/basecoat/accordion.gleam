//// Basecoat documentation: <https://basecoatui.com/components/accordion/>
////
//// The [`accordion`](#accordion) helpers render semantic HTML accordion markup
//// using `<details>` and `<summary>` elements.
////
//// ## Anatomy
////
//// Each accordion `item` is a `<details>` with a `<summary>` title and a
//// content section.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/accordion
//// import lustre/element/html
////
//// fn my_accordion() {
////   accordion.accordion([], [
////     accordion.item("Is it accessible?", [], [
////       html.p([], [html.text("Yes. It adheres to the WAI-ARIA design pattern.")]),
////     ]),
////     accordion.item("Is it styled?", [], [
////       html.p([], [html.text("Yes. It comes with default styles.")]),
////     ]),
////   ])
//// }
//// ```
////
//// ## References
////
//// - MDN `<details>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details>
//// - MDN `<summary>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary>

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html
import lustre/element/svg

pub fn accordion(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section([attribute.class("accordion"), ..attrs], children)
}

pub fn item(
  title: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.details(attrs, [summary(title), html.section([], children)])
}

pub fn item_open(
  title: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  item(title, [attribute.open(True), ..attrs], children)
}

fn summary(title: String) -> Element(msg) {
  html.summary([], [
    html.text(title),
    svg.svg(
      [
        attribute("xmlns", "http://www.w3.org/2000/svg"),
        attribute("width", "24"),
        attribute("height", "24"),
        attribute("viewBox", "0 0 24 24"),
        attribute("fill", "none"),
        attribute("stroke", "currentColor"),
        attribute("stroke-width", "2"),
        attribute("stroke-linecap", "round"),
        attribute("stroke-linejoin", "round"),
      ],
      [svg.path([attribute("d", "m6 9 6 6 6-6")])],
    ),
  ])
}
