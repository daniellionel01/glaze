-module(glaze@basecoat@slider).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/slider.gleam").
-export([slider/1, min/1, max/1, value/1, step/1, name/1, id/1, disabled/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/slider/>\n"
    "\n"
    " Range slider helpers built on `<input type=\"range\">`.\n"
    "\n"
    " Use sliders when you need to pick a numeric value within a bounded range.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/slider\n"
    "\n"
    " fn volume_slider() {\n"
    "   slider.slider([\n"
    "     slider.min(0),\n"
    "     slider.max(100),\n"
    "     slider.value(50),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/slider.gleam", 27).
-spec slider(list(lustre@vdom@vattr:attribute(SYN))) -> lustre@vdom@vnode:element(SYN).
slider(Attrs) ->
    lustre@element@html:input(
        [lustre@attribute:type_(<<"range"/utf8>>),
            lustre@attribute:class(<<"slider"/utf8>>) |
            Attrs]
    ).

-file("src/glaze/basecoat/slider.gleam", 31).
-spec min(integer()) -> lustre@vdom@vattr:attribute(any()).
min(Val) ->
    lustre@attribute:min(erlang:integer_to_binary(Val)).

-file("src/glaze/basecoat/slider.gleam", 35).
-spec max(integer()) -> lustre@vdom@vattr:attribute(any()).
max(Val) ->
    lustre@attribute:max(erlang:integer_to_binary(Val)).

-file("src/glaze/basecoat/slider.gleam", 39).
-spec value(integer()) -> lustre@vdom@vattr:attribute(any()).
value(Val) ->
    lustre@attribute:value(erlang:integer_to_binary(Val)).

-file("src/glaze/basecoat/slider.gleam", 43).
-spec step(integer()) -> lustre@vdom@vattr:attribute(any()).
step(Val) ->
    lustre@attribute:step(erlang:integer_to_binary(Val)).

-file("src/glaze/basecoat/slider.gleam", 47).
-spec name(binary()) -> lustre@vdom@vattr:attribute(any()).
name(N) ->
    lustre@attribute:name(N).

-file("src/glaze/basecoat/slider.gleam", 51).
-spec id(binary()) -> lustre@vdom@vattr:attribute(any()).
id(Id) ->
    lustre@attribute:id(Id).

-file("src/glaze/basecoat/slider.gleam", 55).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).
