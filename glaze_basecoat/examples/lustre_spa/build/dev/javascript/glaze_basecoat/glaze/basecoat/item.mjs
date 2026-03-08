import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function item(attrs, children) {
  return $html.article(
    listPrepend(
      $attribute.class$(
        "group/item flex items-center border text-sm rounded-md transition-colors [a]:hover:bg-accent/50 [a]:transition-colors duration-100 flex-wrap outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] border-border p-4 gap-4",
      ),
      attrs,
    ),
    children,
  );
}

export function item_link(href, attrs, children) {
  return $html.a(
    listPrepend(
      $attribute.href(href),
      listPrepend(
        $attribute.class$(
          "group/item flex items-center border text-sm rounded-md transition-colors [a]:hover:bg-accent/50 [a]:transition-colors duration-100 flex-wrap outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] border-border p-4 gap-4",
        ),
        attrs,
      ),
    ),
    children,
  );
}

export function content(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("flex flex-1 flex-col gap-1"), attrs),
    children,
  );
}

export function title(attrs, children) {
  return $html.h3(
    listPrepend(
      $attribute.class$(
        "flex w-fit items-center gap-2 text-sm leading-snug font-medium",
      ),
      attrs,
    ),
    children,
  );
}

export function description(attrs, children) {
  return $html.p(
    listPrepend(
      $attribute.class$(
        "text-muted-foreground line-clamp-2 text-sm leading-normal font-normal text-balance",
      ),
      attrs,
    ),
    children,
  );
}

export function icon(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$(
        "flex shrink-0 items-center justify-center gap-2 self-start [&_svg]:pointer-events-none size-8 border rounded-sm bg-muted [&_svg:not([class*='size-'])]:size-4",
      ),
      attrs,
    ),
    children,
  );
}

export function avatar(src, alt, attrs) {
  return $html.img(
    listPrepend(
      $attribute.src(src),
      listPrepend(
        $attribute.alt(alt),
        listPrepend(
          $attribute.class$("size-10 rounded-full object-cover"),
          attrs,
        ),
      ),
    ),
  );
}

export function image(src, alt, attrs) {
  return $html.img(
    listPrepend(
      $attribute.src(src),
      listPrepend(
        $attribute.alt(alt),
        listPrepend(
          $attribute.class$("grayscale size-10 rounded-sm object-cover"),
          attrs,
        ),
      ),
    ),
  );
}

export function actions(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$("flex items-center gap-2 [&_svg]:size-4"),
      attrs,
    ),
    children,
  );
}

export function separator() {
  return $html.hr(
    toList([$attribute.role("separator"), $attribute.class$("border-border")]),
  );
}

export function group(attrs, children) {
  return $html.div(
    listPrepend($attribute.class$("flex flex-col"), attrs),
    children,
  );
}

export function muted() {
  return $attribute.class$("border-transparent bg-muted/50");
}

export function outline() {
  return $attribute.class$("border-border");
}

export function default$() {
  return $attribute.class$("border-transparent");
}
