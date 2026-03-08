import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $svg from "../../../lustre/lustre/element/svg.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function accordion(attrs, children) {
  return $html.section(
    listPrepend($attribute.class$("accordion"), attrs),
    children,
  );
}

export function item(title, attrs, children) {
  return $html.details(
    listPrepend($attribute.class$("group border-b last:border-b-0"), attrs),
    toList([
      $html.summary(
        toList([
          $attribute.class$(
            "w-full focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] transition-all outline-none rounded-md",
          ),
        ]),
        toList([
          $html.h2(
            toList([
              $attribute.class$(
                "flex flex-1 items-start justify-between gap-4 py-4 text-left text-sm font-medium hover:underline",
              ),
            ]),
            toList([
              $html.text(title),
              $svg.svg(
                toList([
                  attribute("xmlns", "http://www.w3.org/2000/svg"),
                  attribute("width", "24"),
                  attribute("height", "24"),
                  attribute("viewBox", "0 0 24 24"),
                  attribute("fill", "none"),
                  attribute("stroke", "currentColor"),
                  attribute("stroke-width", "2"),
                  attribute("stroke-linecap", "round"),
                  attribute("stroke-linejoin", "round"),
                  $attribute.class$(
                    "text-muted-foreground pointer-events-none size-4 shrink-0 translate-y-0.5 transition-transform duration-200 group-open:rotate-180",
                  ),
                ]),
                toList([$svg.path(toList([attribute("d", "m6 9 6 6 6-6")]))]),
              ),
            ]),
          ),
        ]),
      ),
      $html.section(toList([$attribute.class$("pb-4")]), children),
    ]),
  );
}

export function item_open(title, attrs, children) {
  return $html.details(
    listPrepend(
      $attribute.class$("group border-b last:border-b-0"),
      listPrepend($attribute.open(true), attrs),
    ),
    toList([
      $html.summary(
        toList([
          $attribute.class$(
            "w-full focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] transition-all outline-none rounded-md",
          ),
        ]),
        toList([
          $html.h2(
            toList([
              $attribute.class$(
                "flex flex-1 items-start justify-between gap-4 py-4 text-left text-sm font-medium hover:underline",
              ),
            ]),
            toList([
              $html.text(title),
              $svg.svg(
                toList([
                  attribute("xmlns", "http://www.w3.org/2000/svg"),
                  attribute("width", "24"),
                  attribute("height", "24"),
                  attribute("viewBox", "0 0 24 24"),
                  attribute("fill", "none"),
                  attribute("stroke", "currentColor"),
                  attribute("stroke-width", "2"),
                  attribute("stroke-linecap", "round"),
                  attribute("stroke-linejoin", "round"),
                  $attribute.class$(
                    "text-muted-foreground pointer-events-none size-4 shrink-0 translate-y-0.5 transition-transform duration-200 group-open:rotate-180",
                  ),
                ]),
                toList([$svg.path(toList([attribute("d", "m6 9 6 6 6-6")]))]),
              ),
            ]),
          ),
        ]),
      ),
      $html.section(toList([$attribute.class$("pb-4")]), children),
    ]),
  );
}
