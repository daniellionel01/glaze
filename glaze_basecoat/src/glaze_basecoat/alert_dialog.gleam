//// Basecoat documentation: <https://basecoatui.com/components/alert-dialog/>
////
//// A modal dialog that interrupts the user with important content and expects
//// a response.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/alert_dialog
////
//// fn delete_confirm_dialog() {
////   alert_dialog.alert_dialog("delete-confirm", [
////     alert_dialog.title("Are you sure?"),
////     alert_dialog.description("This action cannot be undone."),
////     alert_dialog.content([], [
////       alert_dialog.footer([], [
////         button.button([button.outline()], [html.text("Cancel")]),
////         button.button([button.destructive()], [html.text("Delete")]),
////       ]),
////     ]),
////   ])
//// }
//// ```

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn alert_dialog(
  id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let title_id = id <> "-title"
  let desc_id = id <> "-description"
  html.dialog(
    list.append(
      [
        attribute.class("alert-dialog"),
        attribute.id(id),
        attribute("aria-labelledby", title_id),
        attribute("aria-describedby", desc_id),
        attribute.attribute(
          "onclick",
          "if (event.target === this) this.close()",
        ),
      ],
      attrs,
    ),
    [
      html.div(
        [],
        list.append(
          [
            header([], [
              html.h2([attribute.id(title_id)], []),
            ]),
            html.p([attribute.id(desc_id), attribute.class("sr-only")], []),
          ],
          children,
        ),
      ),
    ],
  )
}

pub fn alert_dialog_with_text(
  id: String,
  title: String,
  description: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let title_id = id <> "-title"
  let desc_id = id <> "-description"
  html.dialog(
    list.append(
      [
        attribute.class("alert-dialog"),
        attribute.id(id),
        attribute("aria-labelledby", title_id),
        attribute("aria-describedby", desc_id),
        attribute.attribute(
          "onclick",
          "if (event.target === this) this.close()",
        ),
      ],
      attrs,
    ),
    [
      html.div(
        [],
        list.append(
          [
            header([], [
              html.h2([attribute.id(title_id)], [html.text(title)]),
            ]),
            html.p([attribute.id(desc_id)], [html.text(description)]),
          ],
          children,
        ),
      ),
    ],
  )
}

pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h2(attrs, children)
}

pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p(attrs, children)
}

pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(attrs, children)
}

pub fn content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(attrs, children)
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

pub fn action(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append([attribute.type_("button"), attribute.class("btn")], attrs),
    children,
  )
}

pub fn cancel(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.class("btn-outline"),
        attribute.attribute("onclick", "this.closest('dialog').close()"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn destructive(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.class("btn-destructive"),
        attribute.attribute("onclick", "this.closest('dialog').close()"),
      ],
      attrs,
    ),
    children,
  )
}

pub fn open_script(dialog_id: String) -> String {
  "document.getElementById('" <> dialog_id <> "').showModal()"
}

pub fn close_script(dialog_id: String) -> String {
  "document.getElementById('" <> dialog_id <> "').close()"
}

pub fn trigger_button(
  dialog_id: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.attribute("onclick", open_script(dialog_id)),
      ],
      attrs,
    ),
    children,
  )
}
