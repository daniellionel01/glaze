import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function switch$(attrs) {
  return $html.input(
    listPrepend(
      $attribute.type_("checkbox"),
      listPrepend(
        $attribute.class$("input"),
        listPrepend($attribute.role("switch"), attrs),
      ),
    ),
  );
}

export function with_label(id, label_text, attrs) {
  return $html.label(
    toList([$attribute.class$("label")]),
    toList([
      switch$(listPrepend($attribute.id(id), attrs)),
      $html.text(label_text),
    ]),
  );
}

export function with_description(id, label_text, description, attrs) {
  return $html.div(
    toList([
      $attribute.class$(
        "flex flex-row items-start justify-between rounded-lg border p-4 shadow-xs gap-2",
      ),
    ]),
    toList([
      $html.div(
        toList([$attribute.class$("flex flex-col gap-0.5")]),
        toList([
          $html.label(
            toList([$attribute.for$(id), $attribute.class$("leading-normal")]),
            toList([$html.text(label_text)]),
          ),
          $html.p(
            toList([$attribute.class$("text-muted-foreground text-sm")]),
            toList([$html.text(description)]),
          ),
        ]),
      ),
      switch$(listPrepend($attribute.id(id), attrs)),
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

export function id(id) {
  return $attribute.id(id);
}
