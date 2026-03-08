import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function skeleton(attrs) {
  return $html.div(
    listPrepend($attribute.class$("bg-accent animate-pulse rounded-md"), attrs),
    toList([]),
  );
}

export function text(attrs) {
  return skeleton(listPrepend($attribute.class$("h-4"), attrs));
}

export function circle(attrs) {
  return skeleton(
    listPrepend($attribute.class$("rounded-full size-10 shrink-0"), attrs),
  );
}

export function image(attrs) {
  return skeleton(listPrepend($attribute.class$("aspect-square w-full"), attrs));
}
