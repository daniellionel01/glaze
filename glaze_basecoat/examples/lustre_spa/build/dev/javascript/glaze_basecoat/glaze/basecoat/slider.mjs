import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function slider(attrs) {
  return $html.input(
    listPrepend(
      $attribute.type_("range"),
      listPrepend($attribute.class$("slider"), attrs),
    ),
  );
}

export function min(val) {
  return $attribute.min($int.to_string(val));
}

export function max(val) {
  return $attribute.max($int.to_string(val));
}

export function value(val) {
  return $attribute.value($int.to_string(val));
}

export function step(val) {
  return $attribute.step($int.to_string(val));
}

export function name(n) {
  return $attribute.name(n);
}

export function id(id) {
  return $attribute.id(id);
}

export function disabled() {
  return $attribute.disabled(true);
}
