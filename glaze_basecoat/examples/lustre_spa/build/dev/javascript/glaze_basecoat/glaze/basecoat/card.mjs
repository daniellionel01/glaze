import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function card(attrs, children) {
  return $html.div(listPrepend($attribute.class$("card"), attrs), children);
}

export function header(attrs, children) {
  return $html.header(attrs, children);
}

export function title(attrs, children) {
  return $html.h2(
    listPrepend($attribute.class$("text-lg font-semibold"), attrs),
    children,
  );
}

export function description(attrs, children) {
  return $html.p(
    listPrepend($attribute.class$("text-sm text-muted-foreground"), attrs),
    children,
  );
}

export function content(attrs, children) {
  return $html.section(attrs, children);
}

export function footer(attrs, children) {
  return $html.footer(attrs, children);
}

export function no_padding() {
  return $attribute.class$("p-0");
}
