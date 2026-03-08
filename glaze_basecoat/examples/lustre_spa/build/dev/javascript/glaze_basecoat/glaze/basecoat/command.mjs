import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend } from "../../gleam.mjs";

export function command(id, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.id(id),
      listPrepend(
        $attribute.class$("command"),
        listPrepend($attribute.aria_label("Command menu"), attrs),
      ),
    ),
    children,
  );
}

export function command_styled(id, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.id(id),
      listPrepend(
        $attribute.class$("command rounded-lg border shadow-md"),
        listPrepend($attribute.aria_label("Command menu"), attrs),
      ),
    ),
    children,
  );
}

export function dialog(id, attrs, children) {
  return $html.dialog(
    listPrepend(
      $attribute.id(id),
      listPrepend(
        $attribute.class$("command-dialog"),
        listPrepend(
          $attribute.aria_label("Command menu"),
          listPrepend(
            attribute("onclick", "if (event.target === this) this.close()"),
            attrs,
          ),
        ),
      ),
    ),
    children,
  );
}

export function header(attrs, children) {
  return $html.header(attrs, children);
}

export function search_input(id, placeholder, menu_id, attrs) {
  return $html.input(
    listPrepend(
      $attribute.type_("text"),
      listPrepend(
        $attribute.id(id),
        listPrepend(
          $attribute.placeholder(placeholder),
          listPrepend(
            $attribute.autocomplete("off"),
            listPrepend(
              $attribute.autocorrect(false),
              listPrepend(
                $attribute.spellcheck(false),
                listPrepend(
                  $attribute.aria_autocomplete("list"),
                  listPrepend(
                    $attribute.role("combobox"),
                    listPrepend(
                      $attribute.aria_expanded(true),
                      listPrepend($attribute.aria_controls(menu_id), attrs),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

export function menu(id, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.id(id),
      listPrepend(
        $attribute.role("menu"),
        listPrepend(
          $attribute.aria_orientation("vertical"),
          listPrepend($attribute.class$("scrollbar"), attrs),
        ),
      ),
    ),
    children,
  );
}

export function menu_with_empty(id, empty_message, attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.id(id),
      listPrepend(
        $attribute.role("menu"),
        listPrepend(
          $attribute.aria_orientation("vertical"),
          listPrepend(
            $attribute.data("empty", empty_message),
            listPrepend($attribute.class$("scrollbar"), attrs),
          ),
        ),
      ),
    ),
    children,
  );
}

export function item(attrs, children) {
  return $html.div(listPrepend($attribute.role("menuitem"), attrs), children);
}

export function item_with_shortcut(shortcut, attrs, children) {
  return $html.div(
    listPrepend($attribute.role("menuitem"), attrs),
    $list.append(
      children,
      toList([
        $html.kbd(
          toList([
            $attribute.class$(
              "ml-auto text-muted-foreground bg-transparent tracking-widest",
            ),
          ]),
          toList([$html.text(shortcut)]),
        ),
      ]),
    ),
  );
}

export function item_disabled(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.role("menuitem"),
      listPrepend($attribute.aria_disabled(true), attrs),
    ),
    children,
  );
}

export function item_link(href, attrs, children) {
  return $html.a(
    listPrepend(
      $attribute.href(href),
      listPrepend($attribute.role("menuitem"), attrs),
    ),
    children,
  );
}

export function group(label, items) {
  let label_id = "group-label-" + label;
  return $html.div(
    toList([$attribute.role("group"), $attribute.aria_labelledby(label_id)]),
    listPrepend(
      $html.span(
        toList([$attribute.role("heading"), $attribute.id(label_id)]),
        toList([$html.text(label)]),
      ),
      items,
    ),
  );
}

export function separator() {
  return $html.hr(toList([$attribute.role("separator")]));
}

export function disabled() {
  return $attribute.aria_disabled(true);
}

export function filter(text) {
  return $attribute.data("filter", text);
}

export function keywords(text) {
  return $attribute.data("keywords", text);
}

export function force_show() {
  return $attribute.data("force", "");
}

export function open_script(dialog_id) {
  return ("document.getElementById('" + dialog_id) + "').showModal()";
}

export function close_script(dialog_id) {
  return ("document.getElementById('" + dialog_id) + "').close()";
}
