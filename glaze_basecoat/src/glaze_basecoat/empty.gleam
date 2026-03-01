//// Basecoat documentation: <https://basecoatui.com/components/empty/>
////
//// Display empty states with icons, titles, descriptions, and actions.
////
//// ## Usage
////
//// ```gleam
//// import glaze_basecoat/empty
////
//// fn no_projects() {
////   empty.empty([], [
////     empty.icon([], [icon.folder([])]),
////     empty.title([], [html.text("No Projects Yet")]),
////     empty.description([], [html.text("Create your first project to get started.")]),
////     empty.actions([], [
////       button.button([], [html.text("Create Project")]),
////     ]),
////   ])
//// }
//// ```
////

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render an empty state container.
///
pub fn empty(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class(
        "flex min-w-0 flex-1 flex-col items-center justify-center gap-6 rounded-lg border-dashed p-6 text-center text-balance md:p-12",
      ),
      ..attrs
    ],
    children,
  )
}

/// Render an empty state with a border.
///
pub fn outlined(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class(
        "flex min-w-0 flex-1 flex-col items-center justify-center gap-6 rounded-lg border-dashed border p-6 text-center text-balance md:p-12",
      ),
      ..attrs
    ],
    children,
  )
}

/// Render an empty state header.
///
pub fn header(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.header(
    [
      attribute.class("flex max-w-sm flex-col items-center gap-2 text-center"),
      ..attrs
    ],
    children,
  )
}

/// Render an empty state icon container.
///
pub fn icon(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div(
    [
      attribute.class(
        "mb-2 bg-muted text-foreground flex size-10 shrink-0 items-center justify-center rounded-lg",
      ),
      ..attrs
    ],
    children,
  )
}

/// Render an empty state title.
///
pub fn title(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.h3(
    [attribute.class("text-lg font-medium tracking-tight"), ..attrs],
    children,
  )
}

/// Render an empty state description.
///
pub fn description(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.p(
    [attribute.class("text-muted-foreground text-sm/relaxed"), ..attrs],
    children,
  )
}

/// Render an empty state actions container.
///
pub fn actions(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.section(
    [
      attribute.class(
        "flex w-full max-w-sm min-w-0 flex-col items-center gap-4 text-sm",
      ),
      ..attrs
    ],
    children,
  )
}
