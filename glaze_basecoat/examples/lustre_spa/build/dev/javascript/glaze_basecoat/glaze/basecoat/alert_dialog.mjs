import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function title(attrs, children) {
  return $html.h2(attrs, children);
}

export function description(attrs, children) {
  return $html.p(attrs, children);
}

export function header(attrs, children) {
  return $html.header(attrs, children);
}

export function alert_dialog(id, attrs, children) {
  let title_id = id + "-title";
  let desc_id = id + "-description";
  return $html.dialog(
    listPrepend(
      $attribute.class$("alert-dialog"),
      listPrepend(
        $attribute.id(id),
        listPrepend(
          $attribute.aria_labelledby(title_id),
          listPrepend(
            $attribute.aria_describedby(desc_id),
            listPrepend(
              attribute("onclick", "if (event.target === this) this.close()"),
              attrs,
            ),
          ),
        ),
      ),
    ),
    toList([
      $html.div(
        toList([]),
        listPrepend(
          header(
            toList([]),
            toList([$html.h2(toList([$attribute.id(title_id)]), toList([]))]),
          ),
          listPrepend(
            $html.p(
              toList([$attribute.id(desc_id), $attribute.class$("sr-only")]),
              toList([]),
            ),
            children,
          ),
        ),
      ),
    ]),
  );
}

export function alert_dialog_with_text(id, title, description, attrs, children) {
  let title_id = id + "-title";
  let desc_id = id + "-description";
  return $html.dialog(
    listPrepend(
      $attribute.class$("alert-dialog"),
      listPrepend(
        $attribute.id(id),
        listPrepend(
          $attribute.aria_labelledby(title_id),
          listPrepend(
            $attribute.aria_describedby(desc_id),
            listPrepend(
              attribute("onclick", "if (event.target === this) this.close()"),
              attrs,
            ),
          ),
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
            ]),
          ),
          listPrepend(
            $html.p(
              toList([$attribute.id(desc_id)]),
              toList([$html.text(description)]),
            ),
            children,
          ),
        ),
      ),
    ]),
  );
}

export function content(attrs, children) {
  return $html.section(attrs, children);
}

export function footer(attrs, children) {
  return $html.footer(attrs, children);
}

export function action(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend($attribute.class$("btn"), attrs),
    ),
    children,
  );
}

export function cancel(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.class$("btn-outline"),
        listPrepend(
          attribute("onclick", "this.closest('dialog').close()"),
          attrs,
        ),
      ),
    ),
    children,
  );
}

export function destructive(attrs, children) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.class$("btn-destructive"),
        listPrepend(
          attribute("onclick", "this.closest('dialog').close()"),
          attrs,
        ),
      ),
    ),
    children,
  );
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
