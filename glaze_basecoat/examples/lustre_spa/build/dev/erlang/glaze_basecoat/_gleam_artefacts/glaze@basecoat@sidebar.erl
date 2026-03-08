-module(glaze@basecoat@sidebar).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/sidebar.gleam").
-export([sidebar/3, left/0, right/0, hidden/0, visible/0, nav/2, nav_with_label/3, header/2, section/2, group/2, group_with_attrs/3, link/4, button/3, submenu/4, submenu_with_icon/5, footer/2, toggle_script/1, toggle_script_default/0, open_script/1, close_script/1]).
-export_type([side/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/sidebar/>\n"
    "\n"
    " Sidebar layout helpers for responsive app navigation.\n"
    "\n"
    " **Note**: This component requires JavaScript from Basecoat.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A sidebar is typically an `aside` with a `nav` containing groups and links.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/sidebar\n"
    " import lustre/element/html\n"
    "\n"
    " fn main_sidebar() {\n"
    "   sidebar.sidebar(\"main-nav\", [sidebar.left()], [\n"
    "     sidebar.nav([], [\n"
    "       sidebar.section([], [\n"
    "         sidebar.group(\"Getting started\", [\n"
    "           sidebar.link(\"#\", True, [], [html.text(\"Playground\")]),\n"
    "           sidebar.link(\"#\", False, [], [html.text(\"Models\")]),\n"
    "         ]),\n"
    "       ]),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN `aria-current`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-current>\n"
).

-type side() :: left | right.

-file("src/glaze/basecoat/sidebar.gleam", 45).
-spec sidebar(
    binary(),
    list(lustre@vdom@vattr:attribute(SQO)),
    list(lustre@vdom@vnode:element(SQO))
) -> lustre@vdom@vnode:element(SQO).
sidebar(Id, Attrs, Children) ->
    lustre@element@html:aside(
        [lustre@attribute:class(<<"sidebar"/utf8>>),
            lustre@attribute:id(Id),
            lustre@attribute:aria_hidden(false) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/sidebar.gleam", 61).
-spec left() -> lustre@vdom@vattr:attribute(any()).
left() ->
    lustre@attribute:data(<<"side"/utf8>>, <<"left"/utf8>>).

-file("src/glaze/basecoat/sidebar.gleam", 65).
-spec right() -> lustre@vdom@vattr:attribute(any()).
right() ->
    lustre@attribute:data(<<"side"/utf8>>, <<"right"/utf8>>).

-file("src/glaze/basecoat/sidebar.gleam", 69).
-spec hidden() -> lustre@vdom@vattr:attribute(any()).
hidden() ->
    lustre@attribute:aria_hidden(true).

-file("src/glaze/basecoat/sidebar.gleam", 73).
-spec visible() -> lustre@vdom@vattr:attribute(any()).
visible() ->
    lustre@attribute:aria_hidden(false).

-file("src/glaze/basecoat/sidebar.gleam", 77).
-spec nav(
    list(lustre@vdom@vattr:attribute(SRC)),
    list(lustre@vdom@vnode:element(SRC))
) -> lustre@vdom@vnode:element(SRC).
nav(Attrs, Children) ->
    lustre@element@html:nav(Attrs, Children).

-file("src/glaze/basecoat/sidebar.gleam", 84).
-spec nav_with_label(
    binary(),
    list(lustre@vdom@vattr:attribute(SRI)),
    list(lustre@vdom@vnode:element(SRI))
) -> lustre@vdom@vnode:element(SRI).
nav_with_label(Label, Attrs, Children) ->
    lustre@element@html:nav(
        [lustre@attribute:aria_label(Label) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/sidebar.gleam", 92).
-spec header(
    list(lustre@vdom@vattr:attribute(SRO)),
    list(lustre@vdom@vnode:element(SRO))
) -> lustre@vdom@vnode:element(SRO).
header(Attrs, Children) ->
    lustre@element@html:header(Attrs, Children).

-file("src/glaze/basecoat/sidebar.gleam", 99).
-spec section(
    list(lustre@vdom@vattr:attribute(SRU)),
    list(lustre@vdom@vnode:element(SRU))
) -> lustre@vdom@vnode:element(SRU).
section(Attrs, Children) ->
    lustre@element@html:section(
        [lustre@attribute:class(<<"scrollbar"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/sidebar.gleam", 106).
-spec group(binary(), list(lustre@vdom@vnode:element(SSA))) -> lustre@vdom@vnode:element(SSA).
group(Label, Items) ->
    Label_id = <<"group-label-"/utf8, Label/binary>>,
    lustre@element@html:'div'(
        [lustre@attribute:role(<<"group"/utf8>>),
            lustre@attribute:aria_labelledby(Label_id)],
        [lustre@element@html:h3(
                [lustre@attribute:id(Label_id),
                    lustre@attribute:class(<<"text-sm font-medium"/utf8>>)],
                [lustre@element@html:text(Label)]
            ),
            lustre@element@html:ul([], Items)]
    ).

-file("src/glaze/basecoat/sidebar.gleam", 122).
-spec group_with_attrs(
    binary(),
    list(lustre@vdom@vattr:attribute(SSE)),
    list(lustre@vdom@vnode:element(SSE))
) -> lustre@vdom@vnode:element(SSE).
group_with_attrs(Label, Attrs, Items) ->
    Label_id = <<"group-label-"/utf8, Label/binary>>,
    lustre@element@html:'div'(
        [lustre@attribute:role(<<"group"/utf8>>),
            lustre@attribute:aria_labelledby(Label_id) |
            Attrs],
        [lustre@element@html:h3(
                [lustre@attribute:id(Label_id),
                    lustre@attribute:class(<<"text-sm font-medium"/utf8>>)],
                [lustre@element@html:text(Label)]
            ),
            lustre@element@html:ul([], Items)]
    ).

-file("src/glaze/basecoat/sidebar.gleam", 139).
-spec link(
    binary(),
    boolean(),
    list(lustre@vdom@vattr:attribute(SSK)),
    list(lustre@vdom@vnode:element(SSK))
) -> lustre@vdom@vnode:element(SSK).
link(Href, Is_current, Attrs, Children) ->
    Current_attr = case Is_current of
        true ->
            [lustre@attribute:aria_current(<<"page"/utf8>>)];

        false ->
            []
    end,
    lustre@element@html:li(
        [],
        [lustre@element@html:a(
                glaze@basecoat@internal@listx:append3(
                    [lustre@attribute:href(Href)],
                    Current_attr,
                    Attrs
                ),
                Children
            )]
    ).

-file("src/glaze/basecoat/sidebar.gleam", 154).
-spec button(
    boolean(),
    list(lustre@vdom@vattr:attribute(SSQ)),
    list(lustre@vdom@vnode:element(SSQ))
) -> lustre@vdom@vnode:element(SSQ).
button(Is_current, Attrs, Children) ->
    Current_attr = case Is_current of
        true ->
            [lustre@attribute:aria_current(<<"page"/utf8>>)];

        false ->
            []
    end,
    lustre@element@html:li(
        [],
        [lustre@element@html:button(
                glaze@basecoat@internal@listx:append3(
                    [lustre@attribute:type_(<<"button"/utf8>>),
                        lustre@attribute:class(<<"w-full text-left"/utf8>>)],
                    Current_attr,
                    Attrs
                ),
                Children
            )]
    ).

-file("src/glaze/basecoat/sidebar.gleam", 175).
-spec submenu(
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(SSW)),
    list(lustre@vdom@vnode:element(SSW))
) -> lustre@vdom@vnode:element(SSW).
submenu(Id, Label, Attrs, Items) ->
    lustre@element@html:li(
        [],
        [lustre@element@html:details(
                [lustre@attribute:id(Id) | Attrs],
                [lustre@element@html:summary(
                        [lustre@attribute:aria_controls(
                                <<Id/binary, "-content"/utf8>>
                            )],
                        [lustre@element@html:text(Label)]
                    ),
                    lustre@element@html:ul(
                        [lustre@attribute:id(<<Id/binary, "-content"/utf8>>)],
                        Items
                    )]
            )]
    ).

-file("src/glaze/basecoat/sidebar.gleam", 191).
-spec submenu_with_icon(
    binary(),
    lustre@vdom@vnode:element(STC),
    binary(),
    list(lustre@vdom@vattr:attribute(STC)),
    list(lustre@vdom@vnode:element(STC))
) -> lustre@vdom@vnode:element(STC).
submenu_with_icon(Id, Icon, Label, Attrs, Items) ->
    lustre@element@html:li(
        [],
        [lustre@element@html:details(
                [lustre@attribute:id(Id) | Attrs],
                [lustre@element@html:summary(
                        [lustre@attribute:aria_controls(
                                <<Id/binary, "-content"/utf8>>
                            )],
                        [Icon, lustre@element@html:text(Label)]
                    ),
                    lustre@element@html:ul(
                        [lustre@attribute:id(<<Id/binary, "-content"/utf8>>)],
                        Items
                    )]
            )]
    ).

-file("src/glaze/basecoat/sidebar.gleam", 209).
-spec footer(
    list(lustre@vdom@vattr:attribute(STJ)),
    list(lustre@vdom@vnode:element(STJ))
) -> lustre@vdom@vnode:element(STJ).
footer(Attrs, Children) ->
    lustre@element@html:footer(Attrs, Children).

-file("src/glaze/basecoat/sidebar.gleam", 216).
-spec toggle_script(binary()) -> binary().
toggle_script(Sidebar_id) ->
    <<<<"document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '"/utf8,
            Sidebar_id/binary>>/binary,
        "' } }));"/utf8>>.

-file("src/glaze/basecoat/sidebar.gleam", 222).
-spec toggle_script_default() -> binary().
toggle_script_default() ->
    <<"document.dispatchEvent(new CustomEvent('basecoat:sidebar'));"/utf8>>.

-file("src/glaze/basecoat/sidebar.gleam", 226).
-spec open_script(binary()) -> binary().
open_script(Sidebar_id) ->
    <<<<"document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '"/utf8,
            Sidebar_id/binary>>/binary,
        "', action: 'open' } }));"/utf8>>.

-file("src/glaze/basecoat/sidebar.gleam", 232).
-spec close_script(binary()) -> binary().
close_script(Sidebar_id) ->
    <<<<"document.dispatchEvent(new CustomEvent('basecoat:sidebar', { detail: { id: '"/utf8,
            Sidebar_id/binary>>/binary,
        "', action: 'close' } }));"/utf8>>.
