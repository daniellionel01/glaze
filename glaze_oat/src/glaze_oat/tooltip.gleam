//// Oat documentation: https://oat.ink/components/tooltip/

import lustre/attribute.{type Attribute, attribute}

pub fn tooltip(text: String) -> Attribute(msg) {
  attribute("data-tooltip", text)
}

pub fn title(text: String) -> Attribute(msg) {
  attribute.title(text)
}
