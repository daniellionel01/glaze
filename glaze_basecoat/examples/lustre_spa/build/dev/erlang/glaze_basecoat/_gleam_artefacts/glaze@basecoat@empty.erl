-module(glaze@basecoat@empty).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/empty.gleam").
-export([empty/2, outlined/2, header/2, icon/2, title/2, description/2, actions/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/empty/>\n"
    "\n"
    " Empty state helpers for \"nothing here yet\" screens.\n"
    "\n"
    " Use empty states in lists, tables, or dashboards when there is no data to\n"
    " show, and pair them with an action that helps the user recover.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " Compose an empty state from:\n"
    " - [`icon`](#icon) (optional)\n"
    " - [`title`](#title)\n"
    " - [`description`](#description)\n"
    " - [`actions`](#actions)\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/empty\n"
    " import glaze/basecoat/icon\n"
    " import glaze/basecoat/button\n"
    " import lustre/element/html\n"
    "\n"
    " fn no_projects() {\n"
    "   empty.empty([], [\n"
    "     empty.icon([], [icon.folder([])]),\n"
    "     empty.title([], [html.text(\"No Projects Yet\")]),\n"
    "     empty.description([], [html.text(\"Create your first project to get started.\")]),\n"
    "     empty.actions([], [\n"
    "       button.button([], [html.text(\"Create Project\")]),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/empty.gleam", 41).
-spec empty(
    list(lustre@vdom@vattr:attribute(ROB)),
    list(lustre@vdom@vnode:element(ROB))
) -> lustre@vdom@vnode:element(ROB).
empty(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(
                <<"flex min-w-0 flex-1 flex-col items-center justify-center gap-6 rounded-lg border-dashed p-6 text-center text-balance md:p-12"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/empty.gleam", 56).
-spec outlined(
    list(lustre@vdom@vattr:attribute(ROH)),
    list(lustre@vdom@vnode:element(ROH))
) -> lustre@vdom@vnode:element(ROH).
outlined(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(
                <<"flex min-w-0 flex-1 flex-col items-center justify-center gap-6 rounded-lg border-dashed border p-6 text-center text-balance md:p-12"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/empty.gleam", 71).
-spec header(
    list(lustre@vdom@vattr:attribute(RON)),
    list(lustre@vdom@vnode:element(RON))
) -> lustre@vdom@vnode:element(RON).
header(Attrs, Children) ->
    lustre@element@html:header(
        [lustre@attribute:class(
                <<"flex max-w-sm flex-col items-center gap-2 text-center"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/empty.gleam", 84).
-spec icon(
    list(lustre@vdom@vattr:attribute(ROT)),
    list(lustre@vdom@vnode:element(ROT))
) -> lustre@vdom@vnode:element(ROT).
icon(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(
                <<"mb-2 bg-muted text-foreground flex size-10 shrink-0 items-center justify-center rounded-lg"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/empty.gleam", 99).
-spec title(
    list(lustre@vdom@vattr:attribute(ROZ)),
    list(lustre@vdom@vnode:element(ROZ))
) -> lustre@vdom@vnode:element(ROZ).
title(Attrs, Children) ->
    lustre@element@html:h3(
        [lustre@attribute:class(<<"text-lg font-medium tracking-tight"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/empty.gleam", 109).
-spec description(
    list(lustre@vdom@vattr:attribute(RPF)),
    list(lustre@vdom@vnode:element(RPF))
) -> lustre@vdom@vnode:element(RPF).
description(Attrs, Children) ->
    lustre@element@html:p(
        [lustre@attribute:class(
                <<"text-muted-foreground text-sm/relaxed"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/empty.gleam", 119).
-spec actions(
    list(lustre@vdom@vattr:attribute(RPL)),
    list(lustre@vdom@vnode:element(RPL))
) -> lustre@vdom@vnode:element(RPL).
actions(Attrs, Children) ->
    lustre@element@html:section(
        [lustre@attribute:class(
                <<"flex w-full max-w-sm min-w-0 flex-col items-center gap-4 text-sm"/utf8>>
            ) |
            Attrs],
        Children
    ).
