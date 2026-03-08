-module(glaze@basecoat@checkbox).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/checkbox.gleam").
-export([checkbox/1, with_label/3, with_description/4, checked/0, disabled/0, name/1, value/1, id/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/checkbox/>\n"
    "\n"
    " Checkbox helpers for boolean selections.\n"
    "\n"
    " Use [`checkbox`](#checkbox) for the input itself, or the convenience helpers\n"
    " for common label/description layouts.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/checkbox\n"
    " import lustre/attribute\n"
    " import lustre/element/html\n"
    "\n"
    " fn terms_checkbox() {\n"
    "   checkbox.with_label(\"terms\", \"Accept terms\", [\n"
    "     attribute.checked(True),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/checkbox.gleam", 27).
-spec checkbox(list(lustre@vdom@vattr:attribute(QRT))) -> lustre@vdom@vnode:element(QRT).
checkbox(Attrs) ->
    lustre@element@html:input(
        [lustre@attribute:type_(<<"checkbox"/utf8>>),
            lustre@attribute:class(<<"input"/utf8>>) |
            Attrs]
    ).

-file("src/glaze/basecoat/checkbox.gleam", 31).
-spec with_label(binary(), binary(), list(lustre@vdom@vattr:attribute(QRX))) -> lustre@vdom@vnode:element(QRX).
with_label(Id, Label_text, Attrs) ->
    lustre@element@html:label(
        [lustre@attribute:class(<<"label gap-3"/utf8>>)],
        [checkbox([lustre@attribute:id(Id) | Attrs]),
            lustre@element@html:text(Label_text)]
    ).

-file("src/glaze/basecoat/checkbox.gleam", 42).
-spec with_description(
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(QSB))
) -> lustre@vdom@vnode:element(QSB).
with_description(Id, Label_text, Description, Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"flex items-start gap-3"/utf8>>)],
        [checkbox([lustre@attribute:id(Id) | Attrs]),
            lustre@element@html:'div'(
                [lustre@attribute:class(<<"grid gap-2"/utf8>>)],
                [lustre@element@html:label(
                        [lustre@attribute:for(Id),
                            lustre@attribute:class(<<"label"/utf8>>)],
                        [lustre@element@html:text(Label_text)]
                    ),
                    lustre@element@html:p(
                        [lustre@attribute:class(
                                <<"text-muted-foreground text-sm"/utf8>>
                            )],
                        [lustre@element@html:text(Description)]
                    )]
            )]
    ).

-file("src/glaze/basecoat/checkbox.gleam", 61).
-spec checked() -> lustre@vdom@vattr:attribute(any()).
checked() ->
    lustre@attribute:checked(true).

-file("src/glaze/basecoat/checkbox.gleam", 65).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/checkbox.gleam", 69).
-spec name(binary()) -> lustre@vdom@vattr:attribute(any()).
name(N) ->
    lustre@attribute:name(N).

-file("src/glaze/basecoat/checkbox.gleam", 73).
-spec value(binary()) -> lustre@vdom@vattr:attribute(any()).
value(V) ->
    lustre@attribute:value(V).

-file("src/glaze/basecoat/checkbox.gleam", 77).
-spec id(binary()) -> lustre@vdom@vattr:attribute(any()).
id(Id) ->
    lustre@attribute:id(Id).
