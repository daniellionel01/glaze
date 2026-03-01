//// Basecoat documentation: <https://basecoatui.com/components/theme-switcher/>
////
//// A component that allows the user to switch between light and dark mode.
////
//// **Note**: This component requires the theme script in the `<head>`.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/theme_switcher
////
//// fn my_theme_switcher() {
////   theme_switcher.button([])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}
import lustre/element/html

pub fn init_script() -> Element(msg) {
  html.script(
    [attribute.type_("text/javascript")],
    "(() => {\n"
      <> "  try {\n"
      <> "    const stored = localStorage.getItem('themeMode');\n"
      <> "    if (stored ? stored === 'dark' : matchMedia('(prefers-color-scheme: dark)').matches) {\n"
      <> "      document.documentElement.classList.add('dark');\n"
      <> "    }\n"
      <> "  } catch (_) {}\n\n"
      <> "  const apply = (dark) => {\n"
      <> "    document.documentElement.classList.toggle('dark', dark);\n"
      <> "    try { localStorage.setItem('themeMode', dark ? 'dark' : 'light'); } catch (_) {}\n"
      <> "  };\n\n"
      <> "  document.addEventListener('basecoat:theme', (event) => {\n"
      <> "    const mode = event.detail?.mode;\n"
      <> "    apply(mode === 'dark' ? true : mode === 'light' ? false : !document.documentElement.classList.contains('dark'));\n"
      <> "  });\n"
      <> "})();\n",
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
        attribute("aria-label", "Toggle dark mode"),
        attribute.attribute("onclick", toggle_script()),
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
        attribute("aria-label", "Toggle dark mode"),
        attribute("data-tooltip", "Toggle dark mode"),
        attribute("data-side", tooltip_side),
        attribute.attribute("onclick", toggle_script()),
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
      attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute.attribute("width", "24"),
      attribute.attribute("height", "24"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("fill", "none"),
      attribute.attribute("stroke", "currentColor"),
      attribute.attribute("stroke-width", "2"),
      attribute.attribute("stroke-linecap", "round"),
      attribute.attribute("stroke-linejoin", "round"),
    ],
    [
      element(
        "circle",
        [
          attribute.attribute("cx", "12"),
          attribute.attribute("cy", "12"),
          attribute.attribute("r", "4"),
        ],
        [],
      ),
      element("path", [attribute.attribute("d", "M12 2v2")], []),
      element("path", [attribute.attribute("d", "M12 20v2")], []),
      element("path", [attribute.attribute("d", "m4.93 4.93 1.41 1.41")], []),
      element("path", [attribute.attribute("d", "m17.66 17.66 1.41 1.41")], []),
      element("path", [attribute.attribute("d", "M2 12h2")], []),
      element("path", [attribute.attribute("d", "M20 12h2")], []),
      element("path", [attribute.attribute("d", "m6.34 17.66-1.41 1.41")], []),
      element("path", [attribute.attribute("d", "m19.07 4.93-1.41 1.41")], []),
    ],
  )
}

fn moon_icon() -> Element(msg) {
  element(
    "svg",
    [
      attribute.attribute("xmlns", "http://www.w3.org/2000/svg"),
      attribute.attribute("width", "24"),
      attribute.attribute("height", "24"),
      attribute.attribute("viewBox", "0 0 24 24"),
      attribute.attribute("fill", "none"),
      attribute.attribute("stroke", "currentColor"),
      attribute.attribute("stroke-width", "2"),
      attribute.attribute("stroke-linecap", "round"),
      attribute.attribute("stroke-linejoin", "round"),
    ],
    [
      element(
        "path",
        [attribute.attribute("d", "M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z")],
        [],
      ),
    ],
  )
}
