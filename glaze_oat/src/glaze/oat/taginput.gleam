//// Oat documentation: <https://oat.ink/components/taginput/>
////
//// A text input that turns words into removable tags on Enter or comma.
//// This requires Oat's JavaScript.
////
//// The element dispatches a bubbling `input` event whenever a tag is added
//// or removed. The `.value` property holds the current list of tags.
////
//// ## Recipe
////
//// ```gleam
//// import glaze/oat/taginput
//// import lustre/attribute
//// import lustre/element/html
////
//// fn tags() {
////   taginput.taginput([taginput.value(["apple", "mango"])], [
////     html.input([attribute.placeholder("Add tags ...")]),
////   ])
//// }
//// ```

import gleam/string
import lustre/attribute.{type Attribute, attribute}
import lustre/element.{type Element}

/// Wrap a single `<input>`. Add a `<datalist>` via the input's `list`
/// attribute for autocomplete.
///
pub fn taginput(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  element.element("ot-taginput", attrs, children)
}

/// Initial tags.
///
pub fn value(tags: List(String)) -> Attribute(msg) {
  attribute("value", string.join(tags, ", "))
}
