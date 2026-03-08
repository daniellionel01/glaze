//@ts-check

import { cdn_script_link, cdn_stylesheet_link } from "./basecoat.mjs";

/**
 *
 * @param {String} v
 */
export function append_cdn_script_to_head(v) {
  const script = document.createElement("script");
  script.src = cdn_script_link(v);
  document.head.appendChild(script);
  return null;
}

/**
 *
 * @param {String} v
 */
export function append_cdn_stylesheet_to_head(v) {
  const link = document.createElement("link");
  link.rel = "stylesheet";
  link.href = cdn_stylesheet_link(v);
  document.head.appendChild(link);
  return null;
}
