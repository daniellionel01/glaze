//@ts-check

/**
 * Shows a toast notification.
 *
 * @param {string} title - The toast title.
 * @param {string} description - The toast description.
 * @param {import("./toast.mjs").Options} options - Optional toast configuration.
 * @returns {void}
 */
export function toast(title, description, options) {
  let options_args = {
    variant: options.variant,
    placement: options.placement,
    duration: options.duration_ms,
  };
  //@ts-ignore
  ot.toast(title, description, options_args);
}
