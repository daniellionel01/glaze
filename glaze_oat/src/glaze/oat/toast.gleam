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
//// toast.dispatch("Saved", "Your changes were stored.", options)
//// ```
////

import gleam/json

/// Toast visual style.
///
pub type Variant {
  Info
  Success
  Danger
  Warning
}

pub fn variant_to_json(variant: Variant) -> json.Json {
  case variant {
    Info -> json.string("info")
    Success -> json.string("success")
    Danger -> json.string("danger")
    Warning -> json.string("warning")
  }
}

/// Screen placement for a toast.
///
pub type Placement {
  TopRight
  TopLeft
  TopCenter
  BottomLeft
  BottomRight
  BottomCenter
}

pub fn placement_to_json(placement: Placement) -> json.Json {
  case placement {
    TopRight -> json.string("top-right")
    TopLeft -> json.string("top-left")
    TopCenter -> json.string("top-center")
    BottomLeft -> json.string("bottom-left")
    BottomRight -> json.string("bottom-right")
    BottomCenter -> json.string("bottom-center")
  }
}

/// Configuration for when launching a toast.
///
pub type Options {
  Options(variant: Variant, placement: Placement, duration_ms: Int)
}

pub fn options_to_json(options: Options) -> json.Json {
  let Options(variant:, placement:, duration_ms:) = options
  json.object([
    #("variant", variant_to_json(variant)),
    #("placement", placement_to_json(placement)),
    #("duration", json.int(duration_ms)),
  ])
}

/// Create default options for a given variant.
///
/// Defaults are top-right placement and `4000` milliseconds duration.
///
pub fn default_options(variant: Variant) {
  Options(variant, TopRight, 4000)
}

pub fn with_placement(options: Options, placement: Placement) {
  Options(..options, placement:)
}

pub fn with_duration(options: Options, duration_ms: Int) {
  Options(..options, duration_ms:)
}

/// Trigger a toast notification.
///
/// Available in the Browser.
///
@external(javascript, "./toast.ffi.mjs", "dispatch")
pub fn dispatch(_title: String, _description: String, _options: Options) -> Nil {
  Nil
}
