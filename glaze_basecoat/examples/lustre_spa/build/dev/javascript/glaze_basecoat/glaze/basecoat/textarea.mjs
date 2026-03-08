import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function textarea(attrs, content) {
  return $html.textarea(
    listPrepend($attribute.class$("textarea"), attrs),
    content,
  );
}

export function invalid() {
  return $attribute.aria_invalid("true");
}

export function disabled() {
  return $attribute.disabled(true);
}

export function placeholder(text) {
  return $attribute.placeholder(text);
}

export function name(n) {
  return $attribute.name(n);
}

export function id(id) {
  return $attribute.id(id);
}

export function rows(n) {
  return $attribute.rows(n);
}
