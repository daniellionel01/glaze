-module(glaze@basecoat@progress).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/progress.gleam").
-export([progress/1, value/1, max/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/progress/>\n"
    "\n"
    " Progress helpers for linear completion indicators.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/progress\n"
    "\n"
    " fn download_progress() {\n"
    "   progress.progress([\n"
    "     progress.value(75),\n"
    "     progress.max(100),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN `<progress>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/progress>\n"
).

-file("src/glaze/basecoat/progress.gleam", 27).
-spec progress(list(lustre@vdom@vattr:attribute(SKS))) -> lustre@vdom@vnode:element(SKS).
progress(Attrs) ->
    lustre@element@html:progress(
        [lustre@attribute:class(<<"progress"/utf8>>) | Attrs],
        []
    ).

-file("src/glaze/basecoat/progress.gleam", 31).
-spec value(integer()) -> lustre@vdom@vattr:attribute(any()).
value(Val) ->
    lustre@attribute:value(erlang:integer_to_binary(Val)).

-file("src/glaze/basecoat/progress.gleam", 35).
-spec max(integer()) -> lustre@vdom@vattr:attribute(any()).
max(Val) ->
    lustre@attribute:max(erlang:integer_to_binary(Val)).
