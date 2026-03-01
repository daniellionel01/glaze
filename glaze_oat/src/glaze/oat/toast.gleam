//// Oat documentation: <https://oat.ink/components/toast/>
////
//// Programmatic toast notifications.
////
//// ## Anatomy
////
//// Choose a [`Variant`](#variant), configure [`Options`](#options), and call
//// [`toast`](#toast) to trigger a notification from application code.
////
//// ## Recipes
////
//// ```gleam
//// import glaze/oat/toast
////
//// let options =
////   toast.default_options(toast.Success)
////   |> toast.with_placement(toast.BottomRight)
////   |> toast.with_duration_ms(3000)
////
//// toast.toast("Saved", "Your changes were stored.", options)
//// ```
////
//// ```gleam
//// import glaze/oat/toast
//// import lustre/attribute
//// import lustre/element/html
////
//// let options =
////   toast.default_options(toast.Info)
////   |> toast.with_duration_ms(2500)
////
//// html.button([
////   attribute.type_("button"),
////   attribute(
////     "onclick",
////     toast.toast_eval_string(
////       "Build complete",
////       "All checks passed.",
////       options,
////     ),
////   ),
//// ], [html.text("Show toast")])
//// ```
////
//// ## Notes
////
//// - [`toast`](#toast) uses JavaScript FFI and is only available on the JS target.
//// - [`toast_eval_string`](#toast_eval_string) returns a script string for
////   integration contexts where inline evaluation is needed.

import gleam/int

/// Toast visual style.
///
pub type Variant {
  Info
  Success
  Danger
  Warning
}

/// Convert a toast variant to the string expected by Oat runtime.
///
pub fn variant_to_string(variant: Variant) -> String {
  case variant {
    Info -> "info"
    Success -> "success"
    Danger -> "danger"
    Warning -> "warning"
  }
}

/// Screen placement for a toast stack.
///
pub type Placement {
  TopRight
  TopLeft
  TopCenter
  BottomLeft
  BottomRight
  BottomCenter
}

/// Convert a placement to the string expected by Oat runtime.
///
pub fn placement_to_string(placement: Placement) -> String {
  case placement {
    TopRight -> "top-right"
    TopLeft -> "top-left"
    TopCenter -> "top-center"
    BottomLeft -> "bottom-left"
    BottomRight -> "bottom-right"
    BottomCenter -> "bottom-center"
  }
}

/// Toast runtime options.
///
pub opaque type Options {
  Options(variant: Variant, placement: Placement, duration_ms: Int)
}

/// Create default options for a given variant.
///
/// Defaults are top-right placement and `4000` milliseconds duration.
///
pub fn default_options(variant: Variant) {
  Options(variant, TopRight, 4000)
}

/// Set toast placement.
///
pub fn with_placement(options: Options, placement: Placement) {
  Options(..options, placement:)
}

/// Set toast duration in milliseconds.
///
pub fn with_duration_ms(options: Options, duration_ms: Int) {
  Options(..options, duration_ms:)
}

@target(javascript)
/// Trigger a toast notification.
///
/// Available on the JavaScript target.
///
@external(javascript, "./toast_ffi.mjs", "toast")
pub fn toast(title: String, description: String, options: Options) -> Nil

/// Build a JavaScript expression string that triggers a toast.
///
/// Useful when integrating with APIs that expect script strings.
///
pub fn toast_eval_string(title: String, description: String, options: Options) {
  let Options(variant:, placement:, duration_ms:) = options

  let variant = variant_to_string(variant)
  let placement = placement_to_string(placement)
  let duration = int.to_string(duration_ms)

  let options =
    "{variant: \""
    <> variant
    <> "\", placement: \""
    <> placement
    <> "\", duration: "
    <> duration
    <> "}"

  "ot.toast(`" <> title <> "`, `" <> description <> "`, " <> options <> ");"
}
