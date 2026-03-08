-module(glaze@basecoat@textarea).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/textarea.gleam").
-export([textarea/2, invalid/0, disabled/0, placeholder/1, name/1, id/1, rows/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/textarea/>\n"
    "\n"
    " Textarea helpers for multi-line text input.\n"
    "\n"
    " Use `textarea` when the input is expected to span multiple lines (notes,\n"
    " descriptions, messages).\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/textarea\n"
    " import lustre/attribute\n"
    "\n"
    " fn message_field() {\n"
    "   textarea.textarea([\n"
    "     attribute.placeholder(\"Type your message here\"),\n"
    "   ], \"\")\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN `aria-invalid`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-invalid>\n"
).

-file("src/glaze/basecoat/textarea.gleam", 29).
-spec textarea(list(lustre@vdom@vattr:attribute(TKT)), binary()) -> lustre@vdom@vnode:element(TKT).
textarea(Attrs, Content) ->
    lustre@element@html:textarea(
        [lustre@attribute:class(<<"textarea"/utf8>>) | Attrs],
        Content
    ).

-file("src/glaze/basecoat/textarea.gleam", 33).
-spec invalid() -> lustre@vdom@vattr:attribute(any()).
invalid() ->
    lustre@attribute:aria_invalid(<<"true"/utf8>>).

-file("src/glaze/basecoat/textarea.gleam", 37).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/textarea.gleam", 41).
-spec placeholder(binary()) -> lustre@vdom@vattr:attribute(any()).
placeholder(Text) ->
    lustre@attribute:placeholder(Text).

-file("src/glaze/basecoat/textarea.gleam", 45).
-spec name(binary()) -> lustre@vdom@vattr:attribute(any()).
name(N) ->
    lustre@attribute:name(N).

-file("src/glaze/basecoat/textarea.gleam", 49).
-spec id(binary()) -> lustre@vdom@vattr:attribute(any()).
id(Id) ->
    lustre@attribute:id(Id).

-file("src/glaze/basecoat/textarea.gleam", 53).
-spec rows(integer()) -> lustre@vdom@vattr:attribute(any()).
rows(N) ->
    lustre@attribute:rows(N).
