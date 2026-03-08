-module(glaze@basecoat@popover).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/popover.gleam").
-export([popover/2, trigger/2, trigger_with_id/3, content/2, content_with_id/3, side/1, align/1, side_top/0, side_bottom/0, side_left/0, side_right/0, align_start/0, align_center/0, align_end/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/popover/>\n"
    "\n"
    " Popover helpers for rich floating content.\n"
    "\n"
    " A popover typically has a trigger control and a floating content panel.\n"
    "\n"
    " **Note**: This component requires JavaScript from Basecoat.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " - [`trigger`](#trigger): the control that opens the popover\n"
    " - [`content`](#content): the floating panel\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/popover\n"
    " import lustre/element/html\n"
    "\n"
    " fn my_popover() {\n"
    "   popover.popover(\"my-popover\", [\n"
    "     popover.trigger([button.outline()], [html.text(\"Open\")]),\n"
    "     popover.content([], [\n"
    "       html.p([], [html.text(\"Popover content here.\")]),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN Popover API: <https://developer.mozilla.org/en-US/docs/Web/API/Popover_API>\n"
    " - MDN `popovertarget`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/button#popovertarget>\n"
).

-file("src/glaze/basecoat/popover.gleam", 39).
-spec popover(binary(), list(lustre@vdom@vnode:element(SHQ))) -> lustre@vdom@vnode:element(SHQ).
popover(Id, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"popover"/utf8>>), lustre@attribute:id(Id)],
        Children
    ).

-file("src/glaze/basecoat/popover.gleam", 43).
-spec trigger(
    list(lustre@vdom@vattr:attribute(SHU)),
    list(lustre@vdom@vnode:element(SHU))
) -> lustre@vdom@vnode:element(SHU).
trigger(Attrs, Children) ->
    Popover_id = <<"popover"/utf8>>,
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:popovertarget(Popover_id) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/popover.gleam", 54).
-spec trigger_with_id(
    binary(),
    list(lustre@vdom@vattr:attribute(SIA)),
    list(lustre@vdom@vnode:element(SIA))
) -> lustre@vdom@vnode:element(SIA).
trigger_with_id(Popover_id, Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:popovertarget(Popover_id) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/popover.gleam", 65).
-spec content(
    list(lustre@vdom@vattr:attribute(SIG)),
    list(lustre@vdom@vnode:element(SIG))
) -> lustre@vdom@vnode:element(SIG).
content(Attrs, Children) ->
    Popover_id = <<"popover"/utf8>>,
    lustre@element@html:'div'(
        [lustre@attribute:id(Popover_id),
            lustre@attribute:popover(<<""/utf8>>),
            lustre@attribute:data(<<"popover"/utf8>>, <<""/utf8>>),
            lustre@attribute:aria_hidden(true) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/popover.gleam", 82).
-spec content_with_id(
    binary(),
    list(lustre@vdom@vattr:attribute(SIM)),
    list(lustre@vdom@vnode:element(SIM))
) -> lustre@vdom@vnode:element(SIM).
content_with_id(Popover_id, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(Popover_id),
            lustre@attribute:popover(<<""/utf8>>),
            lustre@attribute:data(<<"popover"/utf8>>, <<""/utf8>>),
            lustre@attribute:aria_hidden(true) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/popover.gleam", 99).
-spec side(binary()) -> lustre@vdom@vattr:attribute(any()).
side(S) ->
    lustre@attribute:data(<<"side"/utf8>>, S).

-file("src/glaze/basecoat/popover.gleam", 103).
-spec align(binary()) -> lustre@vdom@vattr:attribute(any()).
align(A) ->
    lustre@attribute:data(<<"align"/utf8>>, A).

-file("src/glaze/basecoat/popover.gleam", 107).
-spec side_top() -> lustre@vdom@vattr:attribute(any()).
side_top() ->
    side(<<"top"/utf8>>).

-file("src/glaze/basecoat/popover.gleam", 111).
-spec side_bottom() -> lustre@vdom@vattr:attribute(any()).
side_bottom() ->
    side(<<"bottom"/utf8>>).

-file("src/glaze/basecoat/popover.gleam", 115).
-spec side_left() -> lustre@vdom@vattr:attribute(any()).
side_left() ->
    side(<<"left"/utf8>>).

-file("src/glaze/basecoat/popover.gleam", 119).
-spec side_right() -> lustre@vdom@vattr:attribute(any()).
side_right() ->
    side(<<"right"/utf8>>).

-file("src/glaze/basecoat/popover.gleam", 123).
-spec align_start() -> lustre@vdom@vattr:attribute(any()).
align_start() ->
    align(<<"start"/utf8>>).

-file("src/glaze/basecoat/popover.gleam", 127).
-spec align_center() -> lustre@vdom@vattr:attribute(any()).
align_center() ->
    align(<<"center"/utf8>>).

-file("src/glaze/basecoat/popover.gleam", 131).
-spec align_end() -> lustre@vdom@vattr:attribute(any()).
align_end() ->
    align(<<"end"/utf8>>).
