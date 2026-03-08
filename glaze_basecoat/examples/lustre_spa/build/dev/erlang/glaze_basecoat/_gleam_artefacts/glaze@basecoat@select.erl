-module(glaze@basecoat@select).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/select.gleam").
-export([select/2, name/1, placeholder/1, disabled/0, required/0, multiple/0, optgroup/2, option/3, option_with_attrs/4, option_disabled/2, width/1, full_width/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/select/>\n"
    "\n"
    " Select helpers for choosing one option from a list.\n"
    "\n"
    " This module styles the native `<select>` element.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/select\n"
    "\n"
    " fn my_select() {\n"
    "   select.select([select.name(\"fruit\")], [\n"
    "     select.optgroup(\"Fruits\", [\n"
    "       select.option(\"apple\", \"Apple\", True),\n"
    "       select.option(\"banana\", \"Banana\", False),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/select.gleam", 28).
-spec select(
    list(lustre@vdom@vattr:attribute(SNN)),
    list(lustre@vdom@vnode:element(SNN))
) -> lustre@vdom@vnode:element(SNN).
select(Attrs, Children) ->
    lustre@element@html:select(
        [lustre@attribute:class(<<"select"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/select.gleam", 35).
-spec name(binary()) -> lustre@vdom@vattr:attribute(any()).
name(N) ->
    lustre@attribute:name(N).

-file("src/glaze/basecoat/select.gleam", 39).
-spec placeholder(binary()) -> lustre@vdom@vattr:attribute(any()).
placeholder(P) ->
    lustre@attribute:placeholder(P).

-file("src/glaze/basecoat/select.gleam", 43).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/select.gleam", 47).
-spec required() -> lustre@vdom@vattr:attribute(any()).
required() ->
    lustre@attribute:required(true).

-file("src/glaze/basecoat/select.gleam", 51).
-spec multiple() -> lustre@vdom@vattr:attribute(any()).
multiple() ->
    lustre@attribute:multiple(true).

-file("src/glaze/basecoat/select.gleam", 55).
-spec optgroup(binary(), list(lustre@vdom@vnode:element(SOD))) -> lustre@vdom@vnode:element(SOD).
optgroup(Label, Children) ->
    lustre@element@html:optgroup(
        [lustre@attribute:attribute(<<"label"/utf8>>, Label)],
        Children
    ).

-file("src/glaze/basecoat/select.gleam", 59).
-spec option(binary(), binary(), boolean()) -> lustre@vdom@vnode:element(any()).
option(Value, Label, Selected) ->
    Selected_attr = case Selected of
        true ->
            [lustre@attribute:selected(true)];

        false ->
            []
    end,
    lustre@element@html:option(
        [lustre@attribute:value(Value) | Selected_attr],
        Label
    ).

-file("src/glaze/basecoat/select.gleam", 67).
-spec option_with_attrs(
    binary(),
    binary(),
    boolean(),
    list(lustre@vdom@vattr:attribute(SOJ))
) -> lustre@vdom@vnode:element(SOJ).
option_with_attrs(Value, Label, Selected, Attrs) ->
    Selected_attr = case Selected of
        true ->
            [lustre@attribute:selected(true)];

        false ->
            []
    end,
    lustre@element@html:option(
        glaze@basecoat@internal@listx:append3(
            [lustre@attribute:value(Value)],
            Selected_attr,
            Attrs
        ),
        Label
    ).

-file("src/glaze/basecoat/select.gleam", 83).
-spec option_disabled(binary(), binary()) -> lustre@vdom@vnode:element(any()).
option_disabled(Value, Label) ->
    lustre@element@html:option(
        [lustre@attribute:value(Value), lustre@attribute:disabled(true)],
        Label
    ).

-file("src/glaze/basecoat/select.gleam", 87).
-spec width(binary()) -> lustre@vdom@vattr:attribute(any()).
width(W) ->
    lustre@attribute:style(<<"width"/utf8>>, W).

-file("src/glaze/basecoat/select.gleam", 91).
-spec full_width() -> lustre@vdom@vattr:attribute(any()).
full_width() ->
    lustre@attribute:class(<<"w-full"/utf8>>).
