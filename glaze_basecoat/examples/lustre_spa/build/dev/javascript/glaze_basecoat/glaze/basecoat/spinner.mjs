import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $svg from "../../../lustre/lustre/element/svg.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function spinner(attrs) {
  return $svg.svg(
    listPrepend(
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      listPrepend(
        attribute("width", "24"),
        listPrepend(
          attribute("height", "24"),
          listPrepend(
            attribute("viewBox", "0 0 24 24"),
            listPrepend(
              attribute("fill", "none"),
              listPrepend(
                attribute("stroke", "currentColor"),
                listPrepend(
                  attribute("stroke-width", "2"),
                  listPrepend(
                    attribute("stroke-linecap", "round"),
                    listPrepend(
                      attribute("stroke-linejoin", "round"),
                      listPrepend(
                        $attribute.role("status"),
                        listPrepend(
                          $attribute.aria_label("Loading"),
                          listPrepend(
                            $attribute.class$("animate-spin size-4"),
                            attrs,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
    toList([$svg.path(toList([attribute("d", "M21 12a9 9 0 1 1-6.219-8.56")]))]),
  );
}

export function small() {
  return $attribute.class$("size-3");
}

export function large() {
  return $attribute.class$("size-8");
}

export function overlay(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$("relative"),
      listPrepend(attribute("aria-busy", "true"), attrs),
    ),
    toList([
      $html.div(
        toList([
          $attribute.class$(
            "absolute inset-0 flex items-center justify-center bg-background/80",
          ),
        ]),
        toList([spinner(toList([]))]),
      ),
      $html.div(
        toList([$attribute.class$("opacity-50 pointer-events-none")]),
        children,
      ),
    ]),
  );
}
