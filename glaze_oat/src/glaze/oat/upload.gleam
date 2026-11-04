//// Oat documentation: <https://oat.ink/components/upload/>
////
//// A drop zone around a native file input. Selected files are shown as
//// removable badges in the [`files`](#files) element. This requires Oat's
//// JavaScript.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/oat/upload
//// import lustre/attribute
//// import lustre/element/html
////
//// fn uploader() {
////   upload.upload([], [
////     html.input([
////       attribute.type_("file"),
////       attribute.name("files"),
////       attribute.multiple(True),
////       attribute.hidden(True),
////     ]),
////     html.button([attribute.type_("button")], [html.text("Choose files")]),
////     upload.files([], [html.small([], [html.text("Drop files here")])]),
////   ])
//// }
//// ```

import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}
import lustre/element/html

pub fn upload(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("ot-upload", attrs, children)
}

/// Where the selected files are listed. Its children are shown while no
/// files are selected.
///
pub fn files(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.div([attribute("data-files", ""), ..attrs], children)
}
