//// Oat documentation: https://oat.ink/components/spinner/

import lustre/attribute.{type Attribute, attribute}

pub type Size {
  Small
  Large
}

pub fn busy() -> Attribute(msg) {
  attribute("aria-busy", "true")
}

pub fn size(size: Size) -> Attribute(msg) {
  case size {
    Small -> attribute.data("data-spinner", "small")
    Large -> attribute.data("data-spinner", "large")
  }
}

pub fn overlay() -> Attribute(msg) {
  attribute.data("data-spinner", "overlay")
}

pub fn size_overlay(size: Size) -> Attribute(msg) {
  case size {
    Small -> attribute.data("data-spinner", "small overlay")
    Large -> attribute.data("data-spinner", "large overlay")
  }
}
