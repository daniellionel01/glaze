import gleam/int

pub type Variant {
  Success
  Danger
  Warning
}

fn variant_to_string(variant: Variant) -> String {
  case variant {
    Success -> "success"
    Danger -> "danger"
    Warning -> "warning"
  }
}

pub type Placement {
  TopRight
  TopLeft
  TopCenter
  BottomLeft
  BottomRight
  BottomCenter
}

fn placement_to_string(placement: Placement) -> String {
  case placement {
    TopRight -> "top-right"
    TopLeft -> "top-left"
    TopCenter -> "top-center"
    BottomLeft -> "bottom-left"
    BottomRight -> "bottom-right"
    BottomCenter -> "bottom-center"
  }
}

pub opaque type Options {
  Options(variant: Variant, placement: Placement, duration_ms: Int)
}

pub fn default_options(variant: Variant) {
  Options(variant, TopRight, 4000)
}

pub fn with_placement(options: Options, placement: Placement) {
  Options(..options, placement:)
}

pub fn with_duration_ms(options: Options, duration_ms: Int) {
  Options(..options, duration_ms:)
}

@target(javascript)
@external(javascript, "./toast_ffi.mjs", "toast")
pub fn toast(title: String, description: String, options: Options) -> Nil

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
