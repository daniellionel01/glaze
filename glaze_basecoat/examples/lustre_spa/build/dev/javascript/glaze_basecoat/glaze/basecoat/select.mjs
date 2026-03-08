import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $listx from "../../glaze/basecoat/internal/listx.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function select(attrs, children) {
  return $html.select(listPrepend($attribute.class$("select"), attrs), children);
}

export function name(n) {
  return $attribute.name(n);
}

export function placeholder(p) {
  return $attribute.placeholder(p);
}

export function disabled() {
  return $attribute.disabled(true);
}

export function required() {
  return $attribute.required(true);
}

export function multiple() {
  return $attribute.multiple(true);
}

export function optgroup(label, children) {
  return $html.optgroup(toList([attribute("label", label)]), children);
}

export function option(value, label, selected) {
  let _block;
  if (selected) {
    _block = toList([$attribute.selected(true)]);
  } else {
    _block = toList([]);
  }
  let selected_attr = _block;
  return $html.option(
    listPrepend($attribute.value(value), selected_attr),
    label,
  );
}

export function option_with_attrs(value, label, selected, attrs) {
  let _block;
  if (selected) {
    _block = toList([$attribute.selected(true)]);
  } else {
    _block = toList([]);
  }
  let selected_attr = _block;
  return $html.option(
    $listx.append3(toList([$attribute.value(value)]), selected_attr, attrs),
    label,
  );
}

export function option_disabled(value, label) {
  return $html.option(
    toList([$attribute.value(value), $attribute.disabled(true)]),
    label,
  );
}

export function width(w) {
  return $attribute.style("width", w);
}

export function full_width() {
  return $attribute.class$("w-full");
}
