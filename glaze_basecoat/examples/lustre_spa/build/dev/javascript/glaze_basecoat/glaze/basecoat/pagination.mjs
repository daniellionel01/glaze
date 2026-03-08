import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function pagination(attrs, children) {
  return $html.nav(
    listPrepend(
      $attribute.role("navigation"),
      listPrepend(
        $attribute.aria_label("pagination"),
        listPrepend(
          $attribute.class$("mx-auto flex w-full justify-center"),
          attrs,
        ),
      ),
    ),
    toList([
      $html.ul(
        toList([$attribute.class$("flex flex-row items-center gap-1")]),
        children,
      ),
    ]),
  );
}

export function prev(attrs) {
  return $html.li(
    toList([]),
    toList([
      $html.a(
        listPrepend($attribute.class$("btn-ghost"), attrs),
        toList([$html.text(" Previous")]),
      ),
    ]),
  );
}

export function next(attrs) {
  return $html.li(
    toList([]),
    toList([
      $html.a(
        listPrepend($attribute.class$("btn-ghost"), attrs),
        toList([$html.text("Next ")]),
      ),
    ]),
  );
}

export function page(page_num, is_active, attrs) {
  let _block;
  if (is_active) {
    _block = "btn-icon-outline";
  } else {
    _block = "btn-icon-ghost";
  }
  let class$ = _block;
  return $html.li(
    toList([]),
    toList([
      $html.a(
        listPrepend($attribute.class$(class$), attrs),
        toList([$html.text($int.to_string(page_num))]),
      ),
    ]),
  );
}

export function ellipsis(attrs) {
  return $html.li(
    toList([]),
    toList([
      $html.div(
        listPrepend(
          $attribute.class$("size-9 flex items-center justify-center"),
          attrs,
        ),
        toList([$html.text("...")]),
      ),
    ]),
  );
}
