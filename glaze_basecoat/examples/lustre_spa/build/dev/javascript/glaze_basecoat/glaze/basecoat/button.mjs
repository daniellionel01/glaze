import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function group(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("flex items-center gap-2"), attrs),
    children,
  );
}

export function button(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function secondary(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-secondary"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function destructive(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-destructive"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function outline(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-outline"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function ghost(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-ghost"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function link_style(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-link"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function icon(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-icon"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function icon_outline(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-icon-outline"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function icon_destructive(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn-icon-destructive"),
      listPrepend($attribute.type_("button"), attrs),
    ),
    children,
  );
}

export function link(attrs, children) {
  return $html.a(listPrepend($attribute.class$("btn"), attrs), children);
}

export function link_secondary(attrs, children) {
  return $html.a(
    listPrepend($attribute.class$("btn-secondary"), attrs),
    children,
  );
}

export function link_outline(attrs, children) {
  return $html.a(listPrepend($attribute.class$("btn-outline"), attrs), children);
}

export function link_ghost(attrs, children) {
  return $html.a(listPrepend($attribute.class$("btn-ghost"), attrs), children);
}

export function link_destructive(attrs, children) {
  return $html.a(
    listPrepend($attribute.class$("btn-destructive"), attrs),
    children,
  );
}

export function small() {
  return $attribute.class$("btn-sm");
}

export function large() {
  return $attribute.class$("btn-lg");
}

export function full_width() {
  return $attribute.class$("w-full");
}

export function disabled() {
  return $attribute.disabled(true);
}

export function loading() {
  return $attribute.disabled(true);
}

export function submit(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn"),
      listPrepend($attribute.type_("submit"), attrs),
    ),
    children,
  );
}

export function reset(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.class$("btn"),
      listPrepend($attribute.type_("reset"), attrs),
    ),
    children,
  );
}
