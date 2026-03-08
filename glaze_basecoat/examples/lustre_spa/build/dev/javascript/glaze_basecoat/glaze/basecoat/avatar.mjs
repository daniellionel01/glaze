import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function avatar(attrs) {
  return $html.img(
    listPrepend(
      $attribute.class$("size-8 shrink-0 object-cover rounded-full"),
      attrs,
    ),
  );
}

export function rounded(attrs) {
  return $html.img(
    listPrepend(
      $attribute.class$("size-8 shrink-0 object-cover rounded-lg"),
      attrs,
    ),
  );
}

export function initials(text, attrs) {
  return $html.span(
    listPrepend(
      $attribute.class$(
        "size-8 shrink-0 rounded-full bg-muted flex items-center justify-center text-sm font-medium",
      ),
      attrs,
    ),
    toList([$html.text(text)]),
  );
}

export function group(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$(
        "flex -space-x-2 [&_img]:ring-2 [&_img]:ring-background [&_img]:size-8 [&_img]:shrink-0 [&_img]:object-cover [&_img]:rounded-full",
      ),
      attrs,
    ),
    children,
  );
}

export function small() {
  return $attribute.class$("size-6");
}

export function large() {
  return $attribute.class$("size-12");
}

export function extra_large() {
  return $attribute.class$("size-16");
}
