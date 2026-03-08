import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $listx from "../../glaze/basecoat/internal/listx.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

function item_(name, value, label_text, checked, attrs) {
  let _block;
  if (checked) {
    _block = toList([$attribute.checked(true)]);
  } else {
    _block = toList([]);
  }
  let checked_attr = _block;
  return $html.label(
    toList([$attribute.class$("label")]),
    toList([
      $html.input(
        $listx.append3(
          toList([
            $attribute.type_("radio"),
            $attribute.name(name),
            $attribute.value(value),
            $attribute.class$("input"),
          ]),
          checked_attr,
          attrs,
        ),
      ),
      $html.text(label_text),
    ]),
  );
}

export function group(name, items, attrs) {
  let _block;
  let _pipe = items;
  _block = $list.map(
    _pipe,
    (item) => {
      let value;
      let label;
      let checked$1;
      value = item[0];
      label = item[1];
      checked$1 = item[2];
      return item_(name, value, label, checked$1, toList([]));
    },
  );
  let options = _block;
  return $html.fieldset(
    listPrepend($attribute.class$("grid gap-3"), attrs),
    options,
  );
}

export function item(name, value, label_text, checked, attrs) {
  return item_(name, value, label_text, checked, attrs);
}

export function radio(name, value, attrs) {
  return $html.input(
    listPrepend(
      $attribute.type_("radio"),
      listPrepend(
        $attribute.name(name),
        listPrepend(
          $attribute.value(value),
          listPrepend($attribute.class$("input"), attrs),
        ),
      ),
    ),
  );
}

export function checked() {
  return $attribute.checked(true);
}

export function disabled() {
  return $attribute.disabled(true);
}

export function invalid() {
  return $attribute.aria_invalid("true");
}
