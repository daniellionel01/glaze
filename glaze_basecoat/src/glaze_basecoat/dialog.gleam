//// Basecoat documentation: <https://basecoatui.com/components/dialog/>
////
//// A window overlaid on either the primary window or another dialog window,
//// rendering the content underneath inert.
////
//// ## Anatomy
////
//// A dialog flow usually includes a dialog container and a trigger that opens it.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_basecoat/dialog
//// import lustre/attribute
//// import lustre/element/html
////
//// fn edit_profile_dialog() {
////   dialog.dialog_with_description(
////     "edit-profile",
////     "Edit profile",
////     "Make changes to your profile here.",
////     [dialog.max_width("425px")],
////     [
////     dialog.content([], [html.text("Dialog content here.")]),
////     dialog.footer([], [
////       button.button([], [html.text("Save")]),
////     ]),
////     ],
////   )
//// }
//// ```
////
//// ## References
////
//// - MDN `<dialog>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog>
//// - MDN `HTMLDialogElement`: <https://developer.mozilla.org/en-US/docs/Web/API/HTMLDialogElement>

import gleam/list
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element, element}
import lustre/element/html

pub fn dialog(
  id: String,
  title: String,
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  let title_id = id <> "-title"
  html.dialog(
    list.append(
      [
        attribute.class("dialog"),
        attribute.id(id),
        attribute.aria_labelledby(title_id),
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
          ],
          children,
        ),
      ),
    ],
  )
}

pub fn dialog_with_description(
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
        attribute.class("dialog"),
        attribute.id(id),
        attribute.aria_labelledby(title_id),
        attribute.aria_describedby(desc_id),
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
              html.p([attribute.id(desc_id)], [html.text(description)]),
            ]),
          ],
          children,
        ),
      ),
    ],
  )
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

pub fn scrollable_content(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(
    list.append([attribute.class("overflow-y-auto scrollbar")], attrs),
    children,
  )
}

pub fn footer(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.footer(attrs, children)
}

pub fn close_button(attrs: List(Attribute(msg))) -> Element(msg) {
  html.button(
    list.append(
      [
        attribute.type_("button"),
        attribute.aria_label("Close dialog"),
        attribute("onclick", "this.closest('dialog').close()"),
      ],
      attrs,
    ),
    [
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
          element("path", [attribute("d", "M18 6 6 18")], []),
          element("path", [attribute("d", "m6 6 12 12")], []),
        ],
      ),
    ],
  )
}

pub fn max_width(width: String) -> Attribute(msg) {
  attribute.style("max-width", width)
}

pub fn max_height(height: String) -> Attribute(msg) {
  attribute.style("max-height", height)
}

pub fn full_width() -> Attribute(msg) {
  attribute.class("w-full")
}

pub fn responsive_width(width: String) -> Attribute(msg) {
  attribute.class("w-full sm:max-w-[" <> width <> "]")
}

pub fn close_on_backdrop() -> Attribute(msg) {
  attribute("onclick", "if (event.target === this) this.close()")
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
        attribute("onclick", open_script(dialog_id)),
      ],
      attrs,
    ),
    children,
  )
}
