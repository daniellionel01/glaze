import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $listx from "../../glaze/basecoat/internal/listx.mjs";
import { toList, prepend as listPrepend, CustomType as $CustomType } from "../../gleam.mjs";

export class Left extends $CustomType {}
export const Side$Left = () => new Left();
export const Side$isLeft = (value) => value instanceof Left;

export class Right extends $CustomType {}
export const Side$Right = () => new Right();
export const Side$isRight = (value) => value instanceof Right;

export function sidebar(id, attrs, children) {
  return $html.aside(
    listPrepend(
      $attribute.class$("sidebar"),
      listPrepend(
        $attribute.id(id),
        listPrepend($attribute.aria_hidden(false), attrs),
      ),
    ),
    children,
  );
}

export function left() {
  return $attribute.data("side", "left");
}

export function right() {
  return $attribute.data("side", "right");
}

export function hidden() {
  return $attribute.aria_hidden(true);
}

export function visible() {
  return $attribute.aria_hidden(false);
}

export function nav(attrs, children) {
  return $html.nav(attrs, children);
}

export function nav_with_label(label, attrs, children) {
  return $html.nav(listPrepend($attribute.aria_label(label), attrs), children);
}

export function header(attrs, children) {
  return $html.header(attrs, children);
}

export function section(attrs, children) {
  return $html.section(
    listPrepend($attribute.class$("scrollbar"), attrs),
    children,
  );
}

export function group(label, items) {
  let label_id = "group-label-" + label;
  return $html.div(
    toList([$attribute.role("group"), $attribute.aria_labelledby(label_id)]),
    toList([
      $html.h3(
        toList([
          $attribute.id(label_id),
          $attribute.class$("text-sm font-medium"),
        ]),
        toList([$html.text(label)]),
      ),
      $html.ul(toList([]), items),
    ]),
  );
}

export function group_with_attrs(label, attrs, items) {
  let label_id = "group-label-" + label;
  return $html.div(
    listPrepend(
      $attribute.role("group"),
      listPrepend($attribute.aria_labelledby(label_id), attrs),
    ),
    toList([
      $html.h3(
        toList([
          $attribute.id(label_id),
          $attribute.class$("text-sm font-medium"),
        ]),
        toList([$html.text(label)]),
      ),
      $html.ul(toList([]), items),
    ]),
  );
}

export function link(href, is_current, attrs, children) {
  let _block;
  if (is_current) {
    _block = toList([$attribute.aria_current("page")]);
  } else {
    _block = toList([]);
  }
  let current_attr = _block;
  return $html.li(
    toList([]),
    toList([
      $html.a(
        $listx.append3(toList([$attribute.href(href)]), current_attr, attrs),
        children,
      ),
    ]),
  );
}

export function button(is_current, attrs, children) {
  let _block;
  if (is_current) {
    _block = toList([$attribute.aria_current("page")]);
  } else {
    _block = toList([]);
  }
  let current_attr = _block;
  return $html.li(
    toList([]),
    toList([
      $html.button(
        $listx.append3(
          toList([
            $attribute.type_("button"),
            $attribute.class$("w-full text-left"),
          ]),
          current_attr,
          attrs,
        ),
        children,
      ),
    ]),
  );
}

export function submenu(id, label, attrs, items) {
  return $html.li(
    toList([]),
    toList([
      $html.details(
        listPrepend($attribute.id(id), attrs),
        toList([
          $html.summary(
            toList([$attribute.aria_controls(id + "-content")]),
            toList([$html.text(label)]),
          ),
          $html.ul(toList([$attribute.id(id + "-content")]), items),
        ]),
      ),
    ]),
  );
}

export function submenu_with_icon(id, icon, label, attrs, items) {
  return $html.li(
    toList([]),
    toList([
      $html.details(
        listPrepend($attribute.id(id), attrs),
        toList([
          $html.summary(
            toList([$attribute.aria_controls(id + "-content")]),
            toList([icon, $html.text(label)]),
          ),
          $html.ul(toList([$attribute.id(id + "-content")]), items),
        ]),
      ),
    ]),
  );
}

export function footer(attrs, children) {
  return $html.footer(attrs, children);
}

export function toggle_script(sidebar_id) {
  return ("document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '" + sidebar_id) + "' } }));";
}

export function toggle_script_default() {
  return "document.dispatchEvent(new CustomEvent('basecoat:sidebar'));";
}

export function open_script(sidebar_id) {
  return ("document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '" + sidebar_id) + "', action: 'open' } }));";
}

export function close_script(sidebar_id) {
  return ("document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '" + sidebar_id) + "', action: 'close' } }));";
}
