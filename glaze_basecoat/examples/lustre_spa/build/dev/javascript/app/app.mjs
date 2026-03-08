import * as $basecoat from "../glaze_basecoat/glaze/basecoat.mjs";
import * as $button from "../glaze_basecoat/glaze/basecoat/button.mjs";
import * as $card from "../glaze_basecoat/glaze/basecoat/card.mjs";
import * as $lustre from "../lustre/lustre.mjs";
import * as $attribute from "../lustre/lustre/attribute.mjs";
import * as $html from "../lustre/lustre/element/html.mjs";
import { Ok, toList, makeError } from "./gleam.mjs";

const FILEPATH = "src/app.gleam";

export function dependencies() {
  $basecoat.append_cdn_script_to_head($basecoat.version);
  return $basecoat.append_cdn_stylesheet_to_head($basecoat.version);
}

export function view() {
  return $html.div(
    toList([$attribute.class$("p-10")]),
    toList([
      $card.card(
        toList([]),
        toList([
          $card.header(
            toList([]),
            toList([
              $card.title(toList([]), toList([$html.text("Welcome")])),
              $card.description(toList([]), toList([$html.text("Hello!")])),
            ]),
          ),
          $card.content(
            toList([]),
            toList([
              $button.button(toList([]), toList([$html.text("Get Started")])),
            ]),
          ),
        ]),
      ),
    ]),
  );
}

export function main() {
  dependencies();
  let app = $lustre.element(view());
  let $ = $lustre.start(app, "#app", undefined);
  if (!($ instanceof Ok)) {
    throw makeError(
      "let_assert",
      FILEPATH,
      "app",
      18,
      "main",
      "Pattern match failed, no pattern matched the value.",
      { value: $, start: 376, end: 425, pattern_start: 387, pattern_end: 392 }
    )
  }
  return undefined;
}
