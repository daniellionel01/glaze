import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function form(attrs, children) {
  return $html.form(listPrepend($attribute.class$("form"), attrs), children);
}

export function vertical(attrs, children) {
  return $html.form(
    listPrepend($attribute.class$("form space-y-6"), attrs),
    children,
  );
}

export function group(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("grid gap-3"), attrs),
    children,
  );
}

export function action(url) {
  return $attribute.action(url);
}

export function method(m) {
  return $attribute.method(m);
}

export function post() {
  return $attribute.method("post");
}

export function get() {
  return $attribute.method("get");
}

export function name(n) {
  return $attribute.name(n);
}

export function fieldset(attrs, children) {
  return $html.fieldset(
    listPrepend($attribute.class$("grid gap-3"), attrs),
    children,
  );
}

export function legend(attrs, children) {
  return $html.legend(attrs, children);
}
