//// Oat documentation: https://oat.ink/components/form/

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn form(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.form(attrs, children)
}

pub fn fieldset(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.fieldset(attrs, children)
}

pub fn legend(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.legend(attrs, children)
}

pub fn label(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.label(attrs, children)
}

pub fn input(attrs: List(Attribute(msg))) -> Element(msg) {
  html.input(attrs)
}

pub fn select(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.select(attrs, children)
}

pub fn option(attrs: List(Attribute(msg)), label: String) -> Element(msg) {
  html.option(attrs, label)
}

pub fn textarea(attrs: List(Attribute(msg)), value: String) -> Element(msg) {
  html.textarea(attrs, value)
}

pub fn field() -> Attribute(msg) {
  attribute("data-field", "")
}

pub fn field_error() -> Attribute(msg) {
  attribute("data-field", "error")
}

pub fn hint() -> Attribute(msg) {
  attribute("data-hint", "")
}

pub fn group() -> Attribute(msg) {
  attribute.class("group")
}

pub fn error() -> Attribute(msg) {
  attribute.class("error")
}

pub fn as_switch() -> Attribute(msg) {
  attribute.role("switch")
}

pub fn invalid() -> Attribute(msg) {
  attribute("aria-invalid", "true")
}

pub fn described_by(name: String) -> Attribute(msg) {
  attribute("aria-describedby", name)
}
