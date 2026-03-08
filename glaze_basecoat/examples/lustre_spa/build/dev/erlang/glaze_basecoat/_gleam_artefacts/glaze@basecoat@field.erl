-module(glaze@basecoat@field).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/field.gleam").
-export([field/2, label/2, description/2, error/2, with_label/4, with_description/5]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/field/>\n"
    "\n"
    " Form field layout helpers for labels, descriptions, and errors.\n"
    "\n"
    " These helpers don't replace your input components; they provide a consistent\n"
    " wrapper structure around them.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A typical field has a `label`, optional `description` or `error`, and an\n"
    " input element (from `glaze/basecoat/input`, `glaze/basecoat/select`, etc.).\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/field\n"
    " import glaze/basecoat/input\n"
    " import lustre/attribute\n"
    " import lustre/element/html\n"
    "\n"
    " fn email_field() {\n"
    "   field.field([], [\n"
    "     field.label([attribute.for(\"email\")], [html.text(\"Email\")]),\n"
    "     field.description([], [html.text(\"Enter your email address.\")]),\n"
    "     input.email([\n"
    "       attribute.id(\"email\"),\n"
    "       input.placeholder(\"you@example.com\"),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/field.gleam", 38).
-spec field(
    list(lustre@vdom@vattr:attribute(RQN)),
    list(lustre@vdom@vnode:element(RQN))
) -> lustre@vdom@vnode:element(RQN).
field(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"grid gap-3"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/field.gleam", 45).
-spec label(
    list(lustre@vdom@vattr:attribute(RQT)),
    list(lustre@vdom@vnode:element(RQT))
) -> lustre@vdom@vnode:element(RQT).
label(Attrs, Children) ->
    lustre@element@html:label(
        [lustre@attribute:class(<<"label"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/field.gleam", 52).
-spec description(
    list(lustre@vdom@vattr:attribute(RQZ)),
    list(lustre@vdom@vnode:element(RQZ))
) -> lustre@vdom@vnode:element(RQZ).
description(Attrs, Children) ->
    lustre@element@html:p(
        [lustre@attribute:class(<<"text-muted-foreground text-sm"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/field.gleam", 59).
-spec error(
    list(lustre@vdom@vattr:attribute(RRF)),
    list(lustre@vdom@vnode:element(RRF))
) -> lustre@vdom@vnode:element(RRF).
error(Attrs, Children) ->
    lustre@element@html:p(
        [lustre@attribute:class(<<"text-destructive text-sm"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/field.gleam", 66).
-spec with_label(
    binary(),
    binary(),
    lustre@vdom@vnode:element(RRL),
    list(lustre@vdom@vattr:attribute(RRL))
) -> lustre@vdom@vnode:element(RRL).
with_label(Id, Label_text, Input_element, Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"grid gap-3"/utf8>>) | Attrs],
        [label(
                [lustre@attribute:for(Id)],
                [lustre@element@html:text(Label_text)]
            ),
            Input_element]
    ).

-file("src/glaze/basecoat/field.gleam", 78).
-spec with_description(
    binary(),
    binary(),
    binary(),
    lustre@vdom@vnode:element(RRQ),
    list(lustre@vdom@vattr:attribute(RRQ))
) -> lustre@vdom@vnode:element(RRQ).
with_description(Id, Label_text, Description_text, Input_element, Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"grid gap-3"/utf8>>) | Attrs],
        [label(
                [lustre@attribute:for(Id)],
                [lustre@element@html:text(Label_text)]
            ),
            Input_element,
            lustre@element@html:p(
                [lustre@attribute:class(
                        <<"text-muted-foreground text-sm"/utf8>>
                    )],
                [lustre@element@html:text(Description_text)]
            )]
    ).
