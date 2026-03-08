-module(glaze@basecoat@tooltip).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/tooltip.gleam").
-export([tooltip/2, trigger/2, trigger_with_id/3, content/2, content_with_id/3, side/1, align/1, side_top/0, side_bottom/0, side_left/0, side_right/0, align_start/0, align_center/0, align_end/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/tooltip/>\n"
    "\n"
    " Tooltip helpers for short helper text on interactive elements.\n"
    "\n"
    " **Note**: This component requires JavaScript from Basecoat.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A tooltip setup usually includes a `trigger` element and a `content` panel.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/tooltip\n"
    " import lustre/element/html\n"
    "\n"
    " fn my_tooltip() {\n"
    "   tooltip.tooltip(\"my-tooltip\", [\n"
    "     tooltip.trigger([], [html.text(\"Hover me\")]),\n"
    "     tooltip.content([], [html.text(\"Tooltip text\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `tooltip` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tooltip_role>\n"
    " - MDN Popover API: <https://developer.mozilla.org/en-US/docs/Web/API/Popover_API>\n"
).

-file("src/glaze/basecoat/tooltip.gleam", 34).
-spec tooltip(binary(), list(lustre@vdom@vnode:element(TVJ))) -> lustre@vdom@vnode:element(TVJ).
tooltip(Id, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"tooltip"/utf8>>), lustre@attribute:id(Id)],
        Children
    ).

-file("src/glaze/basecoat/tooltip.gleam", 38).
-spec trigger(
    list(lustre@vdom@vattr:attribute(TVN)),
    list(lustre@vdom@vnode:element(TVN))
) -> lustre@vdom@vnode:element(TVN).
trigger(Attrs, Children) ->
    Tooltip_id = <<"tooltip"/utf8>>,
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:aria_describedby(Tooltip_id) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tooltip.gleam", 49).
-spec trigger_with_id(
    binary(),
    list(lustre@vdom@vattr:attribute(TVT)),
    list(lustre@vdom@vnode:element(TVT))
) -> lustre@vdom@vnode:element(TVT).
trigger_with_id(Tooltip_id, Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:aria_describedby(Tooltip_id) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tooltip.gleam", 60).
-spec content(
    list(lustre@vdom@vattr:attribute(TVZ)),
    list(lustre@vdom@vnode:element(TVZ))
) -> lustre@vdom@vnode:element(TVZ).
content(Attrs, Children) ->
    Tooltip_id = <<"tooltip"/utf8>>,
    lustre@element@html:'div'(
        [lustre@attribute:id(Tooltip_id),
            lustre@attribute:role(<<"tooltip"/utf8>>),
            lustre@attribute:data(<<"popover"/utf8>>, <<""/utf8>>),
            lustre@attribute:aria_hidden(true) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tooltip.gleam", 77).
-spec content_with_id(
    binary(),
    list(lustre@vdom@vattr:attribute(TWF)),
    list(lustre@vdom@vnode:element(TWF))
) -> lustre@vdom@vnode:element(TWF).
content_with_id(Tooltip_id, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(Tooltip_id),
            lustre@attribute:role(<<"tooltip"/utf8>>),
            lustre@attribute:data(<<"popover"/utf8>>, <<""/utf8>>),
            lustre@attribute:aria_hidden(true) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tooltip.gleam", 94).
-spec side(binary()) -> lustre@vdom@vattr:attribute(any()).
side(S) ->
    lustre@attribute:data(<<"side"/utf8>>, S).

-file("src/glaze/basecoat/tooltip.gleam", 98).
-spec align(binary()) -> lustre@vdom@vattr:attribute(any()).
align(A) ->
    lustre@attribute:data(<<"align"/utf8>>, A).

-file("src/glaze/basecoat/tooltip.gleam", 102).
-spec side_top() -> lustre@vdom@vattr:attribute(any()).
side_top() ->
    side(<<"top"/utf8>>).

-file("src/glaze/basecoat/tooltip.gleam", 106).
-spec side_bottom() -> lustre@vdom@vattr:attribute(any()).
side_bottom() ->
    side(<<"bottom"/utf8>>).

-file("src/glaze/basecoat/tooltip.gleam", 110).
-spec side_left() -> lustre@vdom@vattr:attribute(any()).
side_left() ->
    side(<<"left"/utf8>>).

-file("src/glaze/basecoat/tooltip.gleam", 114).
-spec side_right() -> lustre@vdom@vattr:attribute(any()).
side_right() ->
    side(<<"right"/utf8>>).

-file("src/glaze/basecoat/tooltip.gleam", 118).
-spec align_start() -> lustre@vdom@vattr:attribute(any()).
align_start() ->
    align(<<"start"/utf8>>).

-file("src/glaze/basecoat/tooltip.gleam", 122).
-spec align_center() -> lustre@vdom@vattr:attribute(any()).
align_center() ->
    align(<<"center"/utf8>>).

-file("src/glaze/basecoat/tooltip.gleam", 126).
-spec align_end() -> lustre@vdom@vattr:attribute(any()).
align_end() ->
    align(<<"end"/utf8>>).
