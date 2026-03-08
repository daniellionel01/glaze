import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function kbd(attrs, children) {
  return $html.kbd(listPrepend($attribute.class$("kbd"), attrs), children);
}

export function shortcut(keys, attrs) {
  let _block;
  let _pipe = keys;
  let _pipe$1 = $list.map(
    _pipe,
    (key) => { return kbd(toList([]), toList([$html.text(key)])); },
  );
  _block = $list.intersperse(_pipe$1, $html.text(" + "));
  let key_elements = _block;
  return $html.span(attrs, key_elements);
}
