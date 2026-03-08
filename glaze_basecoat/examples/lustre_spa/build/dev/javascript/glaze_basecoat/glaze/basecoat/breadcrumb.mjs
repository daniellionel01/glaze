import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function breadcrumb(attrs, children) {
  return $html.ol(
    listPrepend(
      $attribute.class$(
        "text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5",
      ),
      attrs,
    ),
    children,
  );
}

export function item(attrs, children) {
  return $html.li(
    toList([$attribute.class$("inline-flex items-center gap-1.5")]),
    toList([
      $html.a(
        listPrepend(
          $attribute.class$("hover:text-foreground transition-colors"),
          attrs,
        ),
        children,
      ),
    ]),
  );
}

export function current(attrs, children) {
  return $html.li(
    toList([$attribute.class$("inline-flex items-center gap-1.5")]),
    toList([
      $html.span(
        listPrepend($attribute.class$("text-foreground font-normal"), attrs),
        children,
      ),
    ]),
  );
}

export function separator(attrs) {
  return $html.li(
    attrs,
    toList([
      $html.span(
        toList([$attribute.class$("size-3.5")]),
        toList([$html.text("›")]),
      ),
    ]),
  );
}

export function with_items(items, attrs) {
  let _block;
  let _pipe = items;
  let _pipe$1 = $list.map(
    _pipe,
    (i) => {
      let href;
      let label;
      let is_current;
      href = i[0];
      label = i[1];
      is_current = i[2];
      if (is_current) {
        return current(toList([]), toList([$html.text(label)]));
      } else {
        return item(
          toList([$attribute.href(href)]),
          toList([$html.text(label)]),
        );
      }
    },
  );
  _block = $list.intersperse(_pipe$1, separator(toList([])));
  let separated = _block;
  return breadcrumb(attrs, separated);
}
