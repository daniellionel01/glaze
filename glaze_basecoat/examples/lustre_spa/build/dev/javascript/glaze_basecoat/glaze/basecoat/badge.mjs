import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function badge(attrs, children) {
  return $html.span(listPrepend($attribute.class$("badge"), attrs), children);
}

export function secondary(attrs, children) {
  return $html.span(
    listPrepend($attribute.class$("badge-secondary"), attrs),
    children,
  );
}

export function outline(attrs, children) {
  return $html.span(
    listPrepend($attribute.class$("badge-outline"), attrs),
    children,
  );
}

export function destructive(attrs, children) {
  return $html.span(
    listPrepend($attribute.class$("badge-destructive"), attrs),
    children,
  );
}

export function link(attrs, children) {
  return $html.a(listPrepend($attribute.class$("badge"), attrs), children);
}

export function link_secondary(attrs, children) {
  return $html.a(
    listPrepend($attribute.class$("badge-secondary"), attrs),
    children,
  );
}

export function link_outline(attrs, children) {
  return $html.a(
    listPrepend($attribute.class$("badge-outline"), attrs),
    children,
  );
}

export function link_destructive(attrs, children) {
  return $html.a(
    listPrepend($attribute.class$("badge-destructive"), attrs),
    children,
  );
}

export function with_icon(icon, attrs, children) {
  return $html.span(
    listPrepend($attribute.class$("badge"), attrs),
    listPrepend(icon, children),
  );
}
