import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function dropdown(id, children) {
  return $html.div(
    toList([$attribute.class$("dropdown-menu"), $attribute.id(id)]),
    children,
  );
}

export function trigger(attrs, children) {
  let trigger_id = "trigger";
  let menu_id = "menu";
  let popover_id = "popover";
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.id(trigger_id),
        listPrepend(
          $attribute.aria_haspopup("menu"),
          listPrepend(
            $attribute.aria_controls(menu_id),
            listPrepend(
              $attribute.aria_expanded(false),
              listPrepend($attribute.popovertarget(popover_id), attrs),
            ),
          ),
        ),
      ),
    ),
    children,
  );
}

export function trigger_with_ids(
  trigger_id,
  menu_id,
  popover_id,
  attrs,
  children
) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.id(trigger_id),
        listPrepend(
          $attribute.aria_haspopup("menu"),
          listPrepend(
            $attribute.aria_controls(menu_id),
            listPrepend(
              $attribute.aria_expanded(false),
              listPrepend($attribute.popovertarget(popover_id), attrs),
            ),
          ),
        ),
      ),
    ),
    children,
  );
}

export function content(attrs, children) {
  let popover_id = "popover";
  let menu_id = "menu";
  let trigger_id = "trigger";
  return $html.div(
    listPrepend(
      $attribute.id(popover_id),
      listPrepend(
        $attribute.data("popover", ""),
        listPrepend($attribute.aria_hidden(true), attrs),
      ),
    ),
    toList([
      $html.div(
        toList([
          $attribute.role("menu"),
          $attribute.id(menu_id),
          $attribute.aria_labelledby(trigger_id),
        ]),
        children,
      ),
    ]),
  );
}

export function content_with_ids(
  popover_id,
  menu_id,
  trigger_id,
  attrs,
  children
) {
  return $html.div(
    listPrepend(
      $attribute.id(popover_id),
      listPrepend(
        $attribute.data("popover", ""),
        listPrepend($attribute.aria_hidden(true), attrs),
      ),
    ),
    toList([
      $html.div(
        toList([
          $attribute.role("menu"),
          $attribute.id(menu_id),
          $attribute.aria_labelledby(trigger_id),
        ]),
        children,
      ),
    ]),
  );
}

export function item(attrs, children) {
  return $html.div(listPrepend($attribute.role("menuitem"), attrs), children);
}

export function item_with_shortcut(shortcut, attrs, children) {
  return $html.div(
    listPrepend($attribute.role("menuitem"), attrs),
    $list.append(
      children,
      toList([
        $html.span(
          toList([
            $attribute.class$(
              "text-muted-foreground ml-auto text-xs tracking-widest",
            ),
          ]),
          toList([$html.text(shortcut)]),
        ),
      ]),
    ),
  );
}

export function checkbox_item(is_checked, attrs, children) {
  let _block;
  if (is_checked) {
    _block = "true";
  } else {
    _block = "false";
  }
  let checked_str = _block;
  return $html.div(
    listPrepend(
      $attribute.role("menuitemcheckbox"),
      listPrepend($attribute.aria_checked(checked_str), attrs),
    ),
    children,
  );
}

export function radio_item(is_checked, attrs, children) {
  let _block;
  if (is_checked) {
    _block = "true";
  } else {
    _block = "false";
  }
  let checked_str = _block;
  return $html.div(
    listPrepend(
      $attribute.role("menuitemradio"),
      listPrepend($attribute.aria_checked(checked_str), attrs),
    ),
    children,
  );
}

export function group(label, items) {
  let label_id = "group-" + label;
  return $html.div(
    toList([$attribute.role("group"), $attribute.aria_labelledby(label_id)]),
    listPrepend(
      $html.div(
        toList([$attribute.role("heading"), $attribute.id(label_id)]),
        toList([$html.text(label)]),
      ),
      items,
    ),
  );
}

export function separator() {
  return $html.hr(toList([$attribute.role("separator")]));
}

export function heading(id, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.role("heading"),
      listPrepend($attribute.id(id), attrs),
    ),
    children,
  );
}

export function disabled() {
  return $attribute.aria_disabled(true);
}

export function min_width(width) {
  return $attribute.style("min-width", width);
}

export function side(s) {
  return $attribute.data("side", s);
}

export function align(a) {
  return $attribute.data("align", a);
}
