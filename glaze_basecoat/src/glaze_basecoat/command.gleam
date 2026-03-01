//// Basecoat documentation: <https://basecoatui.com/components/command/>
////
//// Fast, composable command menu for quick navigation and actions.
////
//// **Note**: This component requires JavaScript from Basecoat.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/command
////
//// fn my_command() {
////   command.command("my-command", [], [
////     command.group("Suggestions", [
////       command.item([], [html.text("Calendar")]),
////       command.item([], [html.text("Search Emoji")]),
////     ]),
////   ])
//// }
//// ```
////

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn command(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(id),
        attribute.class("command"),
        attribute.aria_label("Command menu"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn command_styled(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(id),
        attribute.class("command rounded-lg border shadow-md"),
        attribute.aria_label("Command menu"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn dialog(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.dialog(
    list.append(
      [
        attribute.id(id),
        attribute.class("command-dialog"),
        attribute.aria_label("Command menu"),
        attribute("onclick", "if (event.target === this) this.close()"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

pub fn search_input(
  id: String,
  placeholder: String,
  menu_id: String,
  attrs: List(Attribute(msg)),
) -> Element(msg) {
  html.input(list.append(
    [
      attribute.type_("text"),
      attribute.id(id),
      attribute.placeholder(placeholder),
      attribute.autocomplete("off"),
      attribute.autocorrect(False),
      attribute.spellcheck(False),
      attribute.aria_autocomplete("list"),
      attribute.role("combobox"),
      attribute.aria_expanded(True),
      attribute.aria_controls(menu_id),
    ],
    attrs,
  ))
}

pub fn menu(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(id),
        attribute.role("menu"),
        attribute.aria_orientation("vertical"),
        attribute.class("scrollbar"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn menu_with_empty(
  id: String,
  empty_message: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [
        attribute.id(id),
        attribute.role("menu"),
        attribute.aria_orientation("vertical"),
        attribute.data("empty", empty_message),
        attribute.class("scrollbar"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn item(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(list.append([attribute.role("menuitem")], attrs), children)
}

pub fn item_with_shortcut(
  shortcut: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append([attribute.role("menuitem")], attrs),
    list.append(children, [
      html.kbd(
        [
          attribute.class(
            "ml-auto text-muted-foreground bg-transparent tracking-widest",
          ),
        ],
        [html.text(shortcut)],
      ),
    ]),
  )
}

pub fn item_disabled(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    list.append(
      [attribute.role("menuitem"), attribute.aria_disabled(True)],
      attrs,
    ),
    children,
  )
}

pub fn item_link(
  href: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.a(
    list.append([attribute.href(href), attribute.role("menuitem")], attrs),
    children,
  )
}

pub fn group(label: String, items: List(Element(msg))) -> Element(msg) {
  let label_id = "group-label-" <> label
  html.div(
    [attribute.role("group"), attribute.aria_labelledby(label_id)],
    list.append(
      [
        html.span([attribute.role("heading"), attribute.id(label_id)], [
          html.text(label),
        ]),
      ],
      items,
    ),
  )
}

pub fn separator() -> Element(msg) {
  html.hr([attribute.role("separator")])
}

pub fn disabled() -> Attribute(msg) {
  attribute.aria_disabled(True)
}

pub fn filter(text: String) -> Attribute(msg) {
  attribute.data("filter", text)
}

pub fn keywords(text: String) -> Attribute(msg) {
  attribute.data("keywords", text)
}

pub fn force_show() -> Attribute(msg) {
  attribute.data("force", "")
}

pub fn open_script(dialog_id: String) -> String {
  "document.getElementById('" <> dialog_id <> "').showModal()"
}

pub fn close_script(dialog_id: String) -> String {
  "document.getElementById('" <> dialog_id <> "').close()"
}
