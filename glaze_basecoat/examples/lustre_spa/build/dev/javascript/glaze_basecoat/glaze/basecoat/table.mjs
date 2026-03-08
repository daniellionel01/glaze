import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function table(attrs, children) {
  return $html.table(listPrepend($attribute.class$("table"), attrs), children);
}

export function scrollable(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("overflow-x-auto"), attrs),
    children,
  );
}

export function caption(attrs, children) {
  return $html.caption(attrs, children);
}

export function thead(attrs, children) {
  return $html.thead(attrs, children);
}

export function tbody(attrs, children) {
  return $html.tbody(attrs, children);
}

export function tfoot(attrs, children) {
  return $html.tfoot(attrs, children);
}

export function tr(attrs, children) {
  return $html.tr(attrs, children);
}

export function th(attrs, children) {
  return $html.th(attrs, children);
}

export function td(attrs, children) {
  return $html.td(attrs, children);
}

export function align_right() {
  return $attribute.class$("text-right");
}

export function font_medium() {
  return $attribute.class$("font-medium");
}
