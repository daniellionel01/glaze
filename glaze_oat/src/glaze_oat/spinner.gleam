//// Oat documentation: <https://oat.ink/components/spinner/>
////
//// Spinner attribute helpers for loading states.
////
//// ## Anatomy
////
//// Apply these attributes to the element that visually represents loading.
//// Use [`busy`](#busy) for accessibility state and one of the size helpers to
//// control presentation.
////
//// ## Recipe
////
//// ```gleam
//// import glaze_oat/spinner
//// import lustre/element/html
////
//// html.div([spinner.busy(), spinner.size(spinner.Large)], [])
//// ```
////
//// ## References
////
//// - MDN `aria-busy`:
////   <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-busy>

import lustre/attribute.{type Attribute, attribute}

/// Spinner size options.
///
pub type Size {
  Small
  Large
}

/// Set `aria-busy="true"` to mark content as loading.
///
pub fn busy() -> Attribute(msg) {
  attribute("aria-busy", "true")
}

/// Set spinner size styling.
///
pub fn size(size: Size) -> Attribute(msg) {
  case size {
    Small -> attribute.data("data-spinner", "small")
    Large -> attribute.data("data-spinner", "large")
  }
}

/// Enable overlay spinner styling.
///
pub fn overlay() -> Attribute(msg) {
  attribute.data("data-spinner", "overlay")
}

/// Set spinner size with overlay styling.
///
pub fn size_overlay(size: Size) -> Attribute(msg) {
  case size {
    Small -> attribute.data("data-spinner", "small overlay")
    Large -> attribute.data("data-spinner", "large overlay")
  }
}
