-module(glaze@basecoat@tabs).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/tabs.gleam").
-export([tabs/3, tab_list/2, tab_trigger/5, tab_panel/5, tab_set/3]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/tabs/>\n"
    "\n"
    " Tabs helpers for grouped content views.\n"
    "\n"
    " **Note**: This component requires JavaScript from Basecoat.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A tab view has a tablist of tab triggers and one or more matching tab panels.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/tabs\n"
    " import lustre/element/html\n"
    "\n"
    " fn settings_tabs() {\n"
    "   tabs.tab_set(\n"
    "     \"settings-tabs\",\n"
    "     [\n"
    "       #(\"account\", \"Account\", True, html.div([], [html.text(\"Account\")])),\n"
    "       #(\"password\", \"Password\", False, html.div([], [html.text(\"Password\")])),\n"
    "     ],\n"
    "     [],\n"
    "   )\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `tablist` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tablist_role>\n"
    " - MDN ARIA `tab` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tab_role>\n"
    " - MDN ARIA `tabpanel` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/tabpanel_role>\n"
).

-file("src/glaze/basecoat/tabs.gleam", 42).
-spec tabs(
    binary(),
    list(lustre@vdom@vattr:attribute(THA)),
    list(lustre@vdom@vnode:element(THA))
) -> lustre@vdom@vnode:element(THA).
tabs(Id, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"tabs w-full"/utf8>>),
            lustre@attribute:id(Id) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tabs.gleam", 53).
-spec tab_list(
    list(lustre@vdom@vattr:attribute(THG)),
    list(lustre@vdom@vnode:element(THG))
) -> lustre@vdom@vnode:element(THG).
tab_list(Attrs, Children) ->
    lustre@element@html:nav(
        [lustre@attribute:role(<<"tablist"/utf8>>),
            lustre@attribute:aria_orientation(<<"horizontal"/utf8>>),
            lustre@attribute:class(<<"w-full"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tabs.gleam", 68).
-spec tab_trigger(
    binary(),
    binary(),
    boolean(),
    list(lustre@vdom@vattr:attribute(THM)),
    list(lustre@vdom@vnode:element(THM))
) -> lustre@vdom@vnode:element(THM).
tab_trigger(Id, Panel_id, Is_selected, Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:role(<<"tab"/utf8>>),
            lustre@attribute:id(Id),
            lustre@attribute:attribute(<<"aria-controls"/utf8>>, Panel_id),
            lustre@attribute:tabindex(0),
            lustre@attribute:aria_selected(Is_selected) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/tabs.gleam", 89).
-spec tab_panel(
    binary(),
    binary(),
    boolean(),
    list(lustre@vdom@vattr:attribute(THS)),
    list(lustre@vdom@vnode:element(THS))
) -> lustre@vdom@vnode:element(THS).
tab_panel(Id, Tab_id, Is_selected, Attrs, Children) ->
    Selected_attr = case Is_selected of
        true ->
            [lustre@attribute:aria_selected(true)];

        false ->
            [lustre@attribute:aria_selected(false),
                lustre@attribute:hidden(true)]
    end,
    lustre@element@html:'div'(
        glaze@basecoat@internal@listx:append3(
            [lustre@attribute:role(<<"tabpanel"/utf8>>),
                lustre@attribute:id(Id),
                lustre@attribute:aria_labelledby(Tab_id),
                lustre@attribute:tabindex(-1)],
            Selected_attr,
            Attrs
        ),
        Children
    ).

-file("src/glaze/basecoat/tabs.gleam", 116).
-spec tab_set(
    binary(),
    list({binary(), binary(), boolean(), lustre@vdom@vnode:element(THY)}),
    list(lustre@vdom@vattr:attribute(THY))
) -> lustre@vdom@vnode:element(THY).
tab_set(Base_id, Items, Attrs) ->
    Triggers = begin
        _pipe = Items,
        gleam@list:index_map(
            _pipe,
            fun(Item, Index) ->
                {_, Label, Is_selected, _} = Item,
                tab_trigger(
                    <<<<Base_id/binary, "-tab-"/utf8>>/binary,
                        (erlang:integer_to_binary(Index))/binary>>,
                    <<<<Base_id/binary, "-panel-"/utf8>>/binary,
                        (erlang:integer_to_binary(Index))/binary>>,
                    Is_selected,
                    [],
                    [lustre@element@html:text(Label)]
                )
            end
        )
    end,
    Panels = begin
        _pipe@1 = Items,
        gleam@list:index_map(
            _pipe@1,
            fun(Item@1, Index@1) ->
                {_, _, Is_selected@1, Content} = Item@1,
                tab_panel(
                    <<<<Base_id/binary, "-panel-"/utf8>>/binary,
                        (erlang:integer_to_binary(Index@1))/binary>>,
                    <<<<Base_id/binary, "-tab-"/utf8>>/binary,
                        (erlang:integer_to_binary(Index@1))/binary>>,
                    Is_selected@1,
                    [],
                    [Content]
                )
            end
        )
    end,
    tabs(Base_id, Attrs, [tab_list([], Triggers) | Panels]).
