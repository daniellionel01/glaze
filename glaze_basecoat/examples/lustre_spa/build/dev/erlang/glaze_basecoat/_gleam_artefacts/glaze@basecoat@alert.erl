-module(glaze@basecoat@alert).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/alert.gleam").
-export([alert/2, destructive/2, icon/2, title/2, description/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/alert/>\n"
    "\n"
    " The [`alert`](#alert) element, sometimes called a \"callout\", is used to draw\n"
    " attention to important information without interrupting page flow.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " An alert is typically a container with optional `icon`, `title`, and\n"
    " `description` content.\n"
    "\n"
    " ## Recipes\n"
    "\n"
    " ### A basic alert\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/alert\n"
    " import lustre/element/html\n"
    "\n"
    " fn info_alert() {\n"
    "   alert.alert([], [\n"
    "     alert.title([], [html.text(\"Heads up\")]),\n"
    "     alert.description([], [html.text(\"This setting applies to all projects.\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ### A destructive alert\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/alert\n"
    " import lustre/element/html\n"
    "\n"
    " fn delete_warning() {\n"
    "   alert.destructive([], [\n"
    "     alert.title([], [html.text(\"Delete project\")]),\n"
    "     alert.description([], [html.text(\"This action cannot be undone.\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## Variants\n"
    "\n"
    " - [`destructive`](#destructive)\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `alert` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/alert_role>\n"
).

-file("src/glaze/basecoat/alert.gleam", 53).
-spec alert(
    list(lustre@vdom@vattr:attribute(PTT)),
    list(lustre@vdom@vnode:element(PTT))
) -> lustre@vdom@vnode:element(PTT).
alert(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"alert"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/alert.gleam", 60).
-spec destructive(
    list(lustre@vdom@vattr:attribute(PTZ)),
    list(lustre@vdom@vnode:element(PTZ))
) -> lustre@vdom@vnode:element(PTZ).
destructive(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"alert-destructive"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/alert.gleam", 67).
-spec icon(
    list(lustre@vdom@vattr:attribute(PUF)),
    list(lustre@vdom@vnode:element(PUF))
) -> lustre@vdom@vnode:element(PUF).
icon(Attrs, Children) ->
    lustre@element@html:'div'(Attrs, Children).

-file("src/glaze/basecoat/alert.gleam", 74).
-spec title(
    list(lustre@vdom@vattr:attribute(PUL)),
    list(lustre@vdom@vnode:element(PUL))
) -> lustre@vdom@vnode:element(PUL).
title(Attrs, Children) ->
    lustre@element@html:h2(Attrs, Children).

-file("src/glaze/basecoat/alert.gleam", 81).
-spec description(
    list(lustre@vdom@vattr:attribute(PUR)),
    list(lustre@vdom@vnode:element(PUR))
) -> lustre@vdom@vnode:element(PUR).
description(Attrs, Children) ->
    lustre@element@html:section(Attrs, Children).
