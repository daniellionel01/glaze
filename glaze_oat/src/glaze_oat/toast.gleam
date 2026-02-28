pub type Variant {
  Success
  Danger
  Warning
}

pub type Placement {
  TopRight
  TopLeft
  TopCenter
  BottomLeft
  BottomRight
  BottomCenter
}

pub type Options {
  Options(variant: Variant, placement: Placement, duration_ms: Int)
}

@target(javascript)
@external(javascript, "./toast_ffi.mjs", "toast")
pub fn toast(title: String, description: String, options: Options) -> Nil

pub fn toast_eval_string(title: String, description: String, options: Options) {
  todo
}
