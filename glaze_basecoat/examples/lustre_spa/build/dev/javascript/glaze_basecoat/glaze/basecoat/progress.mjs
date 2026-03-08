import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function progress(attrs) {
  return $html.progress(
    listPrepend($attribute.class$("progress"), attrs),
    toList([]),
  );
}

export function value(val) {
  return $attribute.value($int.to_string(val));
}

export function max(val) {
  return $attribute.max($int.to_string(val));
}
