import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function label(attrs, children) {
  return $html.label(listPrepend($attribute.class$("label"), attrs), children);
}

export function with_input(id, label_text, input_attrs) {
  return $html.div(
    toList([$attribute.class$("grid gap-2")]),
    toList([
      label(toList([$attribute.for$(id)]), toList([$html.text(label_text)])),
      $html.input(
        listPrepend(
          $attribute.id(id),
          listPrepend(
            $attribute.type_("text"),
            listPrepend($attribute.class$("input"), input_attrs),
          ),
        ),
      ),
    ]),
  );
}
