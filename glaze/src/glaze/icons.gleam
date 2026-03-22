import lustre/attribute.{attribute}
import lustre/element
import lustre/element/svg

/// https://lucide.dev/icons/chevron-down
pub fn chevron_down(attrs: List(attribute.Attribute(a))) -> element.Element(a) {
  svg.svg(
    [
      attribute.class("lucide lucide-chevron-down-icon lucide-chevron-down"),
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      ..attrs
    ],
    [svg.path([attribute("d", "m6 9 6 6 6-6")])],
  )
}

/// https://lucide.dev/icons/chevron-up
pub fn chevron_up(attrs: List(attribute.Attribute(a))) -> element.Element(a) {
  svg.svg(
    [
      attribute.class("lucide lucide-chevron-up-icon lucide-chevron-up"),
      attribute("stroke-linejoin", "round"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-width", "2"),
      attribute("stroke", "currentColor"),
      attribute("fill", "none"),
      attribute("viewBox", "0 0 24 24"),
      attribute("height", "24"),
      attribute("width", "24"),
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      ..attrs
    ],
    [svg.path([attribute("d", "m18 15-6-6-6 6")])],
  )
}
