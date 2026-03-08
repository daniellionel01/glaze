import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function tooltip(id, children) {
  return $html.div(
    toList([$attribute.class$("tooltip"), $attribute.id(id)]),
    children,
  );
}

export function trigger(attrs, children) {
  let tooltip_id = "tooltip";
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend($attribute.aria_describedby(tooltip_id), attrs),
    ),
    children,
  );
}

export function trigger_with_id(tooltip_id, attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend($attribute.aria_describedby(tooltip_id), attrs),
    ),
    children,
  );
}

export function content(attrs, children) {
  let tooltip_id = "tooltip";
  return $html.div(
    listPrepend(
      $attribute.id(tooltip_id),
      listPrepend(
        $attribute.role("tooltip"),
        listPrepend(
          $attribute.data("popover", ""),
          listPrepend($attribute.aria_hidden(true), attrs),
        ),
      ),
    ),
    children,
  );
}

export function content_with_id(tooltip_id, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.id(tooltip_id),
      listPrepend(
        $attribute.role("tooltip"),
        listPrepend(
          $attribute.data("popover", ""),
          listPrepend($attribute.aria_hidden(true), attrs),
        ),
      ),
    ),
    children,
  );
}

export function side(s) {
  return $attribute.data("side", s);
}

export function align(a) {
  return $attribute.data("align", a);
}

export function side_top() {
  return side("top");
}

export function side_bottom() {
  return side("bottom");
}

export function side_left() {
  return side("left");
}

export function side_right() {
  return side("right");
}

export function align_start() {
  return align("start");
}

export function align_center() {
  return align("center");
}

export function align_end() {
  return align("end");
}
