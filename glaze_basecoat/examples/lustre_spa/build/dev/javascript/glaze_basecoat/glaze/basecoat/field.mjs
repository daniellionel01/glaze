import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function field(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("grid gap-3"), attrs),
    children,
  );
}

export function label(attrs, children) {
  return $html.label(listPrepend($attribute.class$("label"), attrs), children);
}

export function description(attrs, children) {
  return $html.p(
    listPrepend($attribute.class$("text-muted-foreground text-sm"), attrs),
    children,
  );
}

export function error(attrs, children) {
  return $html.p(
    listPrepend($attribute.class$("text-destructive text-sm"), attrs),
    children,
  );
}

export function with_label(id, label_text, input_element, attrs) {
  return $html.div(
    listPrepend($attribute.class$("grid gap-3"), attrs),
    toList([
      label(toList([$attribute.for$(id)]), toList([$html.text(label_text)])),
      input_element,
    ]),
  );
}

export function with_description(
  id,
  label_text,
  description_text,
  input_element,
  attrs
) {
  return $html.div(
    listPrepend($attribute.class$("grid gap-3"), attrs),
    toList([
      label(toList([$attribute.for$(id)]), toList([$html.text(label_text)])),
      input_element,
      $html.p(
        toList([$attribute.class$("text-muted-foreground text-sm")]),
        toList([$html.text(description_text)]),
      ),
    ]),
  );
}
