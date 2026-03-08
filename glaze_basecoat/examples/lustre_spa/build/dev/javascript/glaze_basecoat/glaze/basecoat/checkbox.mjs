import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function checkbox(attrs) {
  return $html.input(
    listPrepend(
      $attribute.type_("checkbox"),
      listPrepend($attribute.class$("input"), attrs),
    ),
  );
}

export function with_label(id, label_text, attrs) {
  return $html.label(
    toList([$attribute.class$("label gap-3")]),
    toList([
      checkbox(listPrepend($attribute.id(id), attrs)),
      $html.text(label_text),
    ]),
  );
}

export function with_description(id, label_text, description, attrs) {
  return $html.div(
    toList([$attribute.class$("flex items-start gap-3")]),
    toList([
      checkbox(listPrepend($attribute.id(id), attrs)),
      $html.div(
        toList([$attribute.class$("grid gap-2")]),
        toList([
          $html.label(
            toList([$attribute.for$(id), $attribute.class$("label")]),
            toList([$html.text(label_text)]),
          ),
          $html.p(
            toList([$attribute.class$("text-muted-foreground text-sm")]),
            toList([$html.text(description)]),
          ),
        ]),
      ),
    ]),
  );
}

export function checked() {
  return $attribute.checked(true);
}

export function disabled() {
  return $attribute.disabled(true);
}

export function name(n) {
  return $attribute.name(n);
}

export function value(v) {
  return $attribute.value(v);
}

export function id(id) {
  return $attribute.id(id);
}
