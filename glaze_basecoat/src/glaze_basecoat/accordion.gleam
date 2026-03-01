//// Basecoat documentation: <https://basecoatui.com/components/accordion/>
////
//// A vertically stacked set of interactive headings that each reveal a section of content.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/accordion
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

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}
import lustre/element/html

pub fn accordion(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(list.append([attribute.class("accordion")], attrs), children)
}

pub fn item(
  title: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.details(
    list.append([attribute.class("group border-b last:border-b-0")], attrs),
    [
      html.summary(
        [
          attribute.class(
            "w-full focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] transition-all outline-none rounded-md",
          ),
        ],
        [
          html.h2(
            [
              attribute.class(
                "flex flex-1 items-start justify-between gap-4 py-4 text-left text-sm font-medium hover:underline",
              ),
            ],
            list.append([html.text(title)], [
              element(
                "svg",
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
                  attribute.class(
                    "text-muted-foreground pointer-events-none size-4 shrink-0 translate-y-0.5 transition-transform duration-200 group-open:rotate-180",
                  ),
                ],
                [
                  element("path", [attribute("d", "m6 9 6 6 6-6")], []),
                ],
              ),
            ]),
          ),
        ],
      ),
      html.section([attribute.class("pb-4")], children),
    ],
  )
}

pub fn item_open(
  title: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.details(
    list.append(
      [attribute.class("group border-b last:border-b-0"), attribute.open(True)],
      attrs,
    ),
    [
      html.summary(
        [
          attribute.class(
            "w-full focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] transition-all outline-none rounded-md",
          ),
        ],
        [
          html.h2(
            [
              attribute.class(
                "flex flex-1 items-start justify-between gap-4 py-4 text-left text-sm font-medium hover:underline",
              ),
            ],
            list.append([html.text(title)], [
              element(
                "svg",
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
                  attribute.class(
                    "text-muted-foreground pointer-events-none size-4 shrink-0 translate-y-0.5 transition-transform duration-200 group-open:rotate-180",
                  ),
                ],
                [
                  element("path", [attribute("d", "m6 9 6 6 6-6")], []),
                ],
              ),
            ]),
          ),
        ],
      ),
      html.section([attribute.class("pb-4")], children),
    ],
  )
}
