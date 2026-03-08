import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import * as $svg from "../../../lustre/lustre/element/svg.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function header(attrs, children) {
  return $html.header(attrs, children);
}

export function dialog(id, title, attrs, children) {
  let title_id = id + "-title";
  return $html.dialog(
    listPrepend(
      $attribute.class$("dialog"),
      listPrepend(
        $attribute.id(id),
        listPrepend($attribute.aria_labelledby(title_id), attrs),
      ),
    ),
    toList([
      $html.div(
        toList([]),
        listPrepend(
          header(
            toList([]),
            toList([
              $html.h2(
                toList([$attribute.id(title_id)]),
                toList([$html.text(title)]),
              ),
            ]),
          ),
          children,
        ),
      ),
    ]),
  );
}

export function dialog_with_description(id, title, description, attrs, children) {
  let title_id = id + "-title";
  let desc_id = id + "-description";
  return $html.dialog(
    listPrepend(
      $attribute.class$("dialog"),
      listPrepend(
        $attribute.id(id),
        listPrepend(
          $attribute.aria_labelledby(title_id),
          listPrepend($attribute.aria_describedby(desc_id), attrs),
        ),
      ),
    ),
    toList([
      $html.div(
        toList([]),
        listPrepend(
          header(
            toList([]),
            toList([
              $html.h2(
                toList([$attribute.id(title_id)]),
                toList([$html.text(title)]),
              ),
              $html.p(
                toList([$attribute.id(desc_id)]),
                toList([$html.text(description)]),
              ),
            ]),
          ),
          children,
        ),
      ),
    ]),
  );
}

export function content(attrs, children) {
  return $html.section(attrs, children);
}

export function scrollable_content(attrs, children) {
  return $html.section(
    listPrepend($attribute.class$("overflow-y-auto scrollbar"), attrs),
    children,
  );
}

export function footer(attrs, children) {
  return $html.footer(attrs, children);
}

export function close_button(attrs) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.aria_label("Close dialog"),
        listPrepend(
          attribute("onclick", "this.closest('dialog').close()"),
          attrs,
        ),
      ),
    ),
    toList([
      $svg.svg(
        toList([
          attribute("xmlns", "http://www.w3.org/2000/svg"),
          attribute("width", "24"),
          attribute("height", "24"),
          attribute("viewBox", "0 0 24 24"),
          attribute("fill", "none"),
          attribute("stroke", "currentColor"),
          attribute("stroke-width", "2"),
          attribute("stroke-linecap", "round"),
          attribute("stroke-linejoin", "round"),
        ]),
        toList([
          $svg.path(toList([attribute("d", "M18 6 6 18")])),
          $svg.path(toList([attribute("d", "m6 6 12 12")])),
        ]),
      ),
    ]),
  );
}

export function max_width(width) {
  return $attribute.style("max-width", width);
}

export function max_height(height) {
  return $attribute.style("max-height", height);
}

export function full_width() {
  return $attribute.class$("w-full");
}

export function responsive_width(width) {
  return $attribute.class$(("w-full sm:max-w-[" + width) + "]");
}

export function close_on_backdrop() {
  return attribute("onclick", "if (event.target === this) this.close()");
}

export function open_script(dialog_id) {
  return ("document.getElementById('" + dialog_id) + "').showModal()";
}

export function close_script(dialog_id) {
  return ("document.getElementById('" + dialog_id) + "').close()";
}

export function trigger_button(dialog_id, attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(attribute("onclick", open_script(dialog_id)), attrs),
    ),
    children,
  );
}
