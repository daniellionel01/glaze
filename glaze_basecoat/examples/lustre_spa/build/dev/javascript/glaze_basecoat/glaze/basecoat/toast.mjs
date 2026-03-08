import * as $int from "../../../gleam_stdlib/gleam/int.mjs";
import * as $option from "../../../gleam_stdlib/gleam/option.mjs";
import { None, Some } from "../../../gleam_stdlib/gleam/option.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { toList, prepend as listPrepend, CustomType as $CustomType } from "../../gleam.mjs";

export class Success extends $CustomType {}
export const Category$Success = () => new Success();
export const Category$isSuccess = (value) => value instanceof Success;

export class Info extends $CustomType {}
export const Category$Info = () => new Info();
export const Category$isInfo = (value) => value instanceof Info;

export class Warning extends $CustomType {}
export const Category$Warning = () => new Warning();
export const Category$isWarning = (value) => value instanceof Warning;

export class Error extends $CustomType {}
export const Category$Error = () => new Error();
export const Category$isError = (value) => value instanceof Error;

export class Config extends $CustomType {
  constructor(category, title, description, action, cancel) {
    super();
    this.category = category;
    this.title = title;
    this.description = description;
    this.action = action;
    this.cancel = cancel;
  }
}
export const Config$Config = (category, title, description, action, cancel) =>
  new Config(category, title, description, action, cancel);
export const Config$isConfig = (value) => value instanceof Config;
export const Config$Config$category = (value) => value.category;
export const Config$Config$0 = (value) => value.category;
export const Config$Config$title = (value) => value.title;
export const Config$Config$1 = (value) => value.title;
export const Config$Config$description = (value) => value.description;
export const Config$Config$2 = (value) => value.description;
export const Config$Config$action = (value) => value.action;
export const Config$Config$3 = (value) => value.action;
export const Config$Config$cancel = (value) => value.cancel;
export const Config$Config$4 = (value) => value.cancel;

export class Action extends $CustomType {
  constructor(label, onclick) {
    super();
    this.label = label;
    this.onclick = onclick;
  }
}
export const Action$Action = (label, onclick) => new Action(label, onclick);
export const Action$isAction = (value) => value instanceof Action;
export const Action$Action$label = (value) => value.label;
export const Action$Action$0 = (value) => value.label;
export const Action$Action$onclick = (value) => value.onclick;
export const Action$Action$1 = (value) => value.onclick;

export class Cancel extends $CustomType {
  constructor(label, onclick) {
    super();
    this.label = label;
    this.onclick = onclick;
  }
}
export const Cancel$Cancel = (label, onclick) => new Cancel(label, onclick);
export const Cancel$isCancel = (value) => value instanceof Cancel;
export const Cancel$Cancel$label = (value) => value.label;
export const Cancel$Cancel$0 = (value) => value.label;
export const Cancel$Cancel$onclick = (value) => value.onclick;
export const Cancel$Cancel$1 = (value) => value.onclick;

/**
 * Add the toaster container required for toast notifications.
 *
 * Place this at the end of your body element.
 *
 * ### Example
 *
 * ```gleam
 * import glaze/basecoat
 *
 * html.body([], [
 *   // Your content...
 *   basecoat.toaster(),
 * ])
 * ```
 */
export function toaster(attrs) {
  return $html.div(
    listPrepend(
      $attribute.id("toaster"),
      listPrepend($attribute.class$("toaster"), attrs),
    ),
    toList([]),
  );
}

export function toaster_aligned(align, attrs) {
  return $html.div(
    listPrepend(
      $attribute.id("toaster"),
      listPrepend(
        $attribute.class$("toaster"),
        listPrepend($attribute.data("align", align), attrs),
      ),
    ),
    toList([]),
  );
}

export function toast(attrs, children) {
  return $html.div(
    listPrepend(
      $attribute.class$("toast"),
      listPrepend(
        $attribute.role("status"),
        listPrepend(
          $attribute.aria_atomic(true),
          listPrepend($attribute.aria_hidden(false), attrs),
        ),
      ),
    ),
    toList([$html.div(toList([$attribute.class$("toast-content")]), children)]),
  );
}

export function success() {
  return $attribute.data("category", "success");
}

export function info() {
  return $attribute.data("category", "info");
}

export function warning() {
  return $attribute.data("category", "warning");
}

export function error() {
  return $attribute.data("category", "error");
}

export function duration(ms) {
  return $attribute.data("duration", $int.to_string(ms));
}

export function title(attrs, children) {
  return $html.h2(attrs, children);
}

export function description(attrs, children) {
  return $html.p(attrs, children);
}

export function content(attrs, children) {
  return $html.section(attrs, children);
}

export function footer(attrs, children) {
  return $html.footer(attrs, children);
}

export function action_button(label, attrs) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend(
        $attribute.class$("btn"),
        listPrepend($attribute.data("toast-action", ""), attrs),
      ),
    ),
    toList([$html.text(label)]),
  );
}

export function cancel_button(label, attrs) {
  return $html.button(
    listPrepend(
      $attribute.type_("button"),
      listPrepend($attribute.class$("btn-outline"), attrs),
    ),
    toList([$html.text(label)]),
  );
}

function category_to_string(cat) {
  if (cat instanceof Success) {
    return "success";
  } else if (cat instanceof Info) {
    return "info";
  } else if (cat instanceof Warning) {
    return "warning";
  } else {
    return "error";
  }
}

function action_to_json(action) {
  let _block;
  let $ = action.onclick;
  if ($ instanceof Some) {
    let onclick = $[0];
    _block = (", \"onclick\": \"" + onclick) + "\"";
  } else {
    _block = "";
  }
  let onclick_json = _block;
  return ((("{\"label\": \"" + action.label) + "\"") + onclick_json) + "}";
}

function cancel_to_json(cancel) {
  let _block;
  let $ = cancel.label;
  if ($ instanceof Some) {
    let label = $[0];
    _block = ("\"label\": \"" + label) + "\"";
  } else {
    _block = "";
  }
  let label_json = _block;
  let _block$1;
  let $1 = cancel.onclick;
  if ($1 instanceof Some) {
    let onclick = $1[0];
    _block$1 = (", \"onclick\": \"" + onclick) + "\"";
  } else {
    _block$1 = "";
  }
  let onclick_json = _block$1;
  return (("{" + label_json) + onclick_json) + "}";
}

export function show(config) {
  let category_str = category_to_string(config.category);
  let _block;
  let $ = config.action;
  if ($ instanceof Some) {
    let action = $[0];
    _block = ", \"action\": " + action_to_json(action);
  } else {
    _block = "";
  }
  let action_json = _block;
  let _block$1;
  let $1 = config.cancel;
  if ($1 instanceof Some) {
    let cancel = $1[0];
    _block$1 = ", \"cancel\": " + cancel_to_json(cancel);
  } else {
    _block$1 = "";
  }
  let cancel_json = _block$1;
  return (((((((("document.dispatchEvent(new CustomEvent('basecoat:toast', { detail: { config: { category: '" + category_str) + "', title: '") + config.title) + "', description: '") + config.description) + "'") + action_json) + cancel_json) + " } } }));";
}

export function show_simple(category, title) {
  return show(new Config(category, title, "", new None(), new None()));
}

export function success_toast(title, description) {
  return show(
    new Config(new Success(), title, description, new None(), new None()),
  );
}

export function error_toast(title, description) {
  return show(
    new Config(new Error(), title, description, new None(), new None()),
  );
}
