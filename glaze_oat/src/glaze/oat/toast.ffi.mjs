import {
  variant_to_json,
  placement_to_json,
  Options,
  Options$Options$duration_ms,
  Options$Options$placement,
  Options$Options$variant,
} from "./toast.mjs";

/**
 * @param {string} title - The main heading text of the toast notification.
 * @param {string} description - Additional descriptive text shown below the title.
 * @param {Options} options
 */
export function dispatch(title, description, options) {
  let options_args = {
    variant: variant_to_json(Options$Options$variant(options)),
    placement: placement_to_json(Options$Options$placement(options)),
    duration: Options$Options$duration_ms(options),
  };
  ot.toast(title, description, options_args);

  return null;
}
