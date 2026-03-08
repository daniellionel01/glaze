import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function input(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("text"), attrs),
    ),
  );
}

export function email(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("email"), attrs),
    ),
  );
}

export function password(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("password"), attrs),
    ),
  );
}

export function number(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("number"), attrs),
    ),
  );
}

export function search(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("search"), attrs),
    ),
  );
}

export function url(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("url"), attrs),
    ),
  );
}

export function date(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("date"), attrs),
    ),
  );
}

export function time(attrs) {
  return $html.input(
    listPrepend(
      $attribute.class$("input"),
      listPrepend($attribute.type_("time"), attrs),
    ),
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

export function value(text) {
  return $attribute.value(text);
}

export function name(n) {
  return $attribute.name(n);
}

export function id(id) {
  return $attribute.id(id);
}
