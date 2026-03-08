import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { prepend as listPrepend } from "../../gleam.mjs";

export function empty(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$(
        "flex min-w-0 flex-1 flex-col items-center justify-center gap-6 rounded-lg border-dashed p-6 text-center text-balance md:p-12",
      ),
      attrs,
    ),
    children,
  );
}

export function outlined(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$(
        "flex min-w-0 flex-1 flex-col items-center justify-center gap-6 rounded-lg border-dashed border p-6 text-center text-balance md:p-12",
      ),
      attrs,
    ),
    children,
  );
}

export function header(attrs, children) {
  return $html.header(
    listPrepend(
      $attribute.class$("flex max-w-sm flex-col items-center gap-2 text-center"),
      attrs,
    ),
    children,
  );
}

export function icon(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$(
        "mb-2 bg-muted text-foreground flex size-10 shrink-0 items-center justify-center rounded-lg",
      ),
      attrs,
    ),
    children,
  );
}

export function title(attrs, children) {
  return $html.h3(
    listPrepend($attribute.class$("text-lg font-medium tracking-tight"), attrs),
    children,
  );
}

export function description(attrs, children) {
  return $html.p(
    listPrepend(
      $attribute.class$("text-muted-foreground text-sm/relaxed"),
      attrs,
    ),
    children,
  );
}

export function actions(attrs, children) {
  return $html.section(
    listPrepend(
      $attribute.class$(
        "flex w-full max-w-sm min-w-0 flex-col items-center gap-4 text-sm",
      ),
      attrs,
    ),
    children,
  );
}
