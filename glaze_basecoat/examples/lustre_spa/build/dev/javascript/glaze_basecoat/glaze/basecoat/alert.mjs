import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function alert(attrs, children) {
  return $html.div(listPrepend($attribute.class$("alert"), attrs), children);
}

export function destructive(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("alert-destructive"), attrs),
    children,
  );
}

export function icon(attrs, children) {
  return $html.div(attrs, children);
}

export function title(attrs, children) {
  return $html.h2(attrs, children);
}

export function description(attrs, children) {
  return $html.section(attrs, children);
}
