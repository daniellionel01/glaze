import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import { element } from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $svg from "../../../lustre/lustre/element/svg.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function init_script() {
  return $html.script(
    toList([$attribute.type_("text/javascript")]),
    "(() => {\n      try {\n        const stored = localStorage.getItem('themeMode');\n        if (stored ? stored === 'dark' : matchMedia('(prefers-color-scheme: dark)').matches) {\n          document.documentElement.classList.add('dark');\n        }\n      } catch (_) {}\n\n      const apply = (dark) => {\n        document.documentElement.classList.toggle('dark', dark);\n        try { localStorage.setItem('themeMode', dark ? 'dark' : 'light'); } catch (_) {}\n      };\n\n      document.addEventListener('basecoat:theme', (event) => {\n        const mode = event.detail?.mode;\n        apply(mode === 'dark' ? true : mode === 'light' ? false : !document.documentElement.classList.contains('dark'));\n      });\n    })();",
  );
}

export function toggle_script() {
  return "document.dispatchEvent(new CustomEvent('basecoat:theme'))";
}

export function set_dark_script() {
  return "document.dispatchEvent(new CustomEvent('basecoat:theme', { detail: { mode: 'dark' } }))";
}

export function set_light_script() {
  return "document.dispatchEvent(new CustomEvent('basecoat:theme', { detail: { mode: 'light' } }))";
}

function sun_icon() {
  return $svg.svg(
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
    ]),
    toList([
      $svg.circle(
        toList([
          attribute("cx", "12"),
          attribute("cy", "12"),
          attribute("r", "4"),
        ]),
      ),
      $svg.path(toList([attribute("d", "M12 2v2")])),
      $svg.path(toList([attribute("d", "M12 20v2")])),
      $svg.path(toList([attribute("d", "m4.93 4.93 1.41 1.41")])),
      $svg.path(toList([attribute("d", "m17.66 17.66 1.41 1.41")])),
      $svg.path(toList([attribute("d", "M2 12h2")])),
      $svg.path(toList([attribute("d", "M20 12h2")])),
      $svg.path(toList([attribute("d", "m6.34 17.66-1.41 1.41")])),
      $svg.path(toList([attribute("d", "m19.07 4.93-1.41 1.41")])),
    ]),
  );
}

function moon_icon() {
  return element(
    "svg",
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
    ]),
    toList([
      $svg.path(toList([attribute("d", "M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z")])),
    ]),
  );
}

export function button(attrs) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.aria_label("Toggle dark mode"),
        listPrepend(
          attribute("onclick", toggle_script()),
          listPrepend($attribute.class$("btn-icon-outline size-8"), attrs),
        ),
      ),
    ),
    toList([
      $html.span(
        toList([$attribute.class$("hidden dark:block")]),
        toList([sun_icon()]),
      ),
      $html.span(
        toList([$attribute.class$("block dark:hidden")]),
        toList([moon_icon()]),
      ),
    ]),
  );
}

export function button_with_tooltip(tooltip_side, attrs) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.aria_label("Toggle dark mode"),
        listPrepend(
          $attribute.data("tooltip", "Toggle dark mode"),
          listPrepend(
            $attribute.data("side", tooltip_side),
            listPrepend(
              attribute("onclick", toggle_script()),
              listPrepend($attribute.class$("btn-icon-outline size-8"), attrs),
            ),
          ),
        ),
      ),
    ),
    toList([
      $html.span(
        toList([$attribute.class$("hidden dark:block")]),
        toList([sun_icon()]),
      ),
      $html.span(
        toList([$attribute.class$("block dark:hidden")]),
        toList([moon_icon()]),
      ),
    ]),
  );
}
