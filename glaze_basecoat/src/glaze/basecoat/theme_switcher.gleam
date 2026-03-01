//// Basecoat documentation: <https://basecoatui.com/components/theme-switcher/>
////
//// Theme switcher helpers for toggling a light/dark class.
////
//// **Note**: This component requires the theme script in the `<head>`.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/basecoat/theme_switcher
//// import lustre/element/html
////
//// fn my_theme_switcher() {
////   theme_switcher.button([])
//// }
//// ```
////
//// Add the initialization script once in your document `<head>`:
////
//// ```gleam
//// html.head([], [
////   theme_switcher.init_script(),
//// ])
//// ```
////
//// ## References
////
//// - MDN `prefers-color-scheme`: <https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme>

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}
import lustre/element/html

pub fn init_script() -> Element(msg) {
  html.script(
    [attribute.type_("text/javascript")],
    "(() => {
      try {
        const stored = localStorage.getItem('themeMode');
        if (stored ? stored === 'dark' : matchMedia('(prefers-color-scheme: dark)').matches) {
          document.documentElement.classList.add('dark');
        }
      } catch (_) {}

      const apply = (dark) => {
        document.documentElement.classList.toggle('dark', dark);
        try { localStorage.setItem('themeMode', dark ? 'dark' : 'light'); } catch (_) {}
      };

      document.addEventListener('basecoat:theme', (event) => {
        const mode = event.detail?.mode;
        apply(mode === 'dark' ? true : mode === 'light' ? false : !document.documentElement.classList.contains('dark'));
      });
    })();",
  )
}

pub fn toggle_script() -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:theme'))"
}

pub fn set_dark_script() -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:theme', { detail: { mode: 'dark' } }))"
}

pub fn set_light_script() -> String {
  "document.dispatchEvent(new CustomEvent('basecoat:theme', { detail: { mode: 'light' } }))"
}

pub fn button(attrs: List(Attribute(msg))) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.aria_label("Toggle dark mode"),
        attribute("onclick", toggle_script()),
        attribute.class("btn-icon-outline size-8"),
      ],
      attrs,
    ),
    [
      element("span", [attribute.class("hidden dark:block")], [sun_icon()]),
      element("span", [attribute.class("block dark:hidden")], [moon_icon()]),
    ],
  )
}

pub fn button_with_tooltip(
  tooltip_side: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.aria_label("Toggle dark mode"),
        attribute.data("tooltip", "Toggle dark mode"),
        attribute.data("side", tooltip_side),
        attribute("onclick", toggle_script()),
        attribute.class("btn-icon-outline size-8"),
      ],
      attrs,
    ),
    [
      element("span", [attribute.class("hidden dark:block")], [sun_icon()]),
      element("span", [attribute.class("block dark:hidden")], [moon_icon()]),
    ],
  )
}

fn sun_icon() -> Element(msg) {
  element(
    "svg",
    [
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute("width", "24"),
      attribute("height", "24"),
      attribute("viewBox", "0 0 24 24"),
      attribute("fill", "none"),
      attribute("stroke", "currentColor"),
      attribute("stroke-width", "2"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-linejoin", "round"),
    ],
    [
      element(
        "circle",
        [
          attribute("cx", "12"),
          attribute("cy", "12"),
          attribute("r", "4"),
        ],
        [],
      ),
      element("path", [attribute("d", "M12 2v2")], []),
      element("path", [attribute("d", "M12 20v2")], []),
      element("path", [attribute("d", "m4.93 4.93 1.41 1.41")], []),
      element("path", [attribute("d", "m17.66 17.66 1.41 1.41")], []),
      element("path", [attribute("d", "M2 12h2")], []),
      element("path", [attribute("d", "M20 12h2")], []),
      element("path", [attribute("d", "m6.34 17.66-1.41 1.41")], []),
      element("path", [attribute("d", "m19.07 4.93-1.41 1.41")], []),
    ],
  )
}

fn moon_icon() -> Element(msg) {
  element(
    "svg",
    [
      attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute("width", "24"),
      attribute("height", "24"),
      attribute("viewBox", "0 0 24 24"),
      attribute("fill", "none"),
      attribute("stroke", "currentColor"),
      attribute("stroke-width", "2"),
      attribute("stroke-linecap", "round"),
      attribute("stroke-linejoin", "round"),
    ],
    [
      element(
        "path",
        [attribute("d", "M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z")],
        [],
      ),
    ],
  )
}
