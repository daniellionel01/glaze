import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $listx from "../../glaze/basecoat/internal/listx.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function tabs(id, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$("tabs w-full"),
      listPrepend($attribute.id(id), attrs),
    ),
    children,
  );
}

export function tab_list(attrs, children) {
  return $html.nav(
    listPrepend(
      $attribute.role("tablist"),
      listPrepend(
        $attribute.aria_orientation("horizontal"),
        listPrepend($attribute.class$("w-full"), attrs),
      ),
    ),
    children,
  );
}

export function tab_trigger(id, panel_id, is_selected, attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.role("tab"),
        listPrepend(
          $attribute.id(id),
          listPrepend(
            attribute("aria-controls", panel_id),
            listPrepend(
              $attribute.tabindex(0),
              listPrepend($attribute.aria_selected(is_selected), attrs),
            ),
          ),
        ),
      ),
    ),
    children,
  );
}

export function tab_panel(id, tab_id, is_selected, attrs, children) {
  let _block;
  if (is_selected) {
    _block = toList([$attribute.aria_selected(true)]);
  } else {
    _block = toList([$attribute.aria_selected(false), $attribute.hidden(true)]);
  }
  let selected_attr = _block;
  return $html.div(
    $listx.append3(
      toList([
        $attribute.role("tabpanel"),
        $attribute.id(id),
        $attribute.aria_labelledby(tab_id),
        $attribute.tabindex(-1),
      ]),
      selected_attr,
      attrs,
    ),
    children,
  );
}

export function tab_set(base_id, items, attrs) {
  let _block;
  let _pipe = items;
  _block = $list.index_map(
    _pipe,
    (item, index) => {
      let label;
      let is_selected;
      label = item[1];
      is_selected = item[2];
      return tab_trigger(
        (base_id + "-tab-") + $int.to_string(index),
        (base_id + "-panel-") + $int.to_string(index),
        is_selected,
        toList([]),
        toList([$html.text(label)]),
      );
    },
  );
  let triggers = _block;
  let _block$1;
  let _pipe$1 = items;
  _block$1 = $list.index_map(
    _pipe$1,
    (item, index) => {
      let is_selected;
      let content;
      is_selected = item[2];
      content = item[3];
      return tab_panel(
        (base_id + "-panel-") + $int.to_string(index),
        (base_id + "-tab-") + $int.to_string(index),
        is_selected,
        toList([]),
        toList([content]),
      );
    },
  );
  let panels = _block$1;
  return tabs(
    base_id,
    attrs,
    listPrepend(tab_list(toList([]), triggers), panels),
  );
}
