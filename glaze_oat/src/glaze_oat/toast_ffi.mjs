import { variant_to_string, placement_to_string } from "./toast.mjs";

export function toast(title, description, options) {
  let options_args = {
    variant: variant_to_string(options.variant),
    placement: placement_to_string(options.placement),
    duration: options.duration_ms,
  };
  ot.toast(title, description, options_args);
}
