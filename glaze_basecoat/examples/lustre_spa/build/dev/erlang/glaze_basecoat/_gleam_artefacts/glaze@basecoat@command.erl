-module(glaze@basecoat@command).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/command.gleam").
-export([command/3, command_styled/3, dialog/3, header/2, search_input/4, menu/3, menu_with_empty/4, item/2, item_with_shortcut/3, item_disabled/2, item_link/3, group/2, separator/0, disabled/0, filter/1, keywords/1, force_show/0, open_script/1, close_script/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/command/>\n"
    "\n"
    " Fast, composable command menu for quick navigation and actions.\n"
    "\n"
    " **Note**: This component requires JavaScript from Basecoat.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A command menu usually includes a search input and a menu of items grouped\n"
    " into sections.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/command\n"
    " import lustre/element/html\n"
    "\n"
    " fn my_command() {\n"
    "   command.command(\"my-command\", [], [\n"
    "     command.group(\"Suggestions\", [\n"
    "       command.item([], [html.text(\"Calendar\")]),\n"
    "       command.item([], [html.text(\"Search Emoji\")]),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `combobox` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/combobox_role>\n"
    " - MDN ARIA `menu` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/menu_role>\n"
    " - MDN ARIA `menuitem` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/menuitem_role>\n"
    " - MDN `<dialog>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog>\n"
).

-file("src/glaze/basecoat/command.gleam", 40).
-spec command(
    binary(),
    list(lustre@vdom@vattr:attribute(QUD)),
    list(lustre@vdom@vnode:element(QUD))
) -> lustre@vdom@vnode:element(QUD).
command(Id, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(Id),
            lustre@attribute:class(<<"command"/utf8>>),
            lustre@attribute:aria_label(<<"Command menu"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 56).
-spec command_styled(
    binary(),
    list(lustre@vdom@vattr:attribute(QUJ)),
    list(lustre@vdom@vnode:element(QUJ))
) -> lustre@vdom@vnode:element(QUJ).
command_styled(Id, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(Id),
            lustre@attribute:class(
                <<"command rounded-lg border shadow-md"/utf8>>
            ),
            lustre@attribute:aria_label(<<"Command menu"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 72).
-spec dialog(
    binary(),
    list(lustre@vdom@vattr:attribute(QUP)),
    list(lustre@vdom@vnode:element(QUP))
) -> lustre@vdom@vnode:element(QUP).
dialog(Id, Attrs, Children) ->
    lustre@element@html:dialog(
        [lustre@attribute:id(Id),
            lustre@attribute:class(<<"command-dialog"/utf8>>),
            lustre@attribute:aria_label(<<"Command menu"/utf8>>),
            lustre@attribute:attribute(
                <<"onclick"/utf8>>,
                <<"if (event.target === this) this.close()"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 89).
-spec header(
    list(lustre@vdom@vattr:attribute(QUV)),
    list(lustre@vdom@vnode:element(QUV))
) -> lustre@vdom@vnode:element(QUV).
header(Attrs, Children) ->
    lustre@element@html:header(Attrs, Children).

-file("src/glaze/basecoat/command.gleam", 96).
-spec search_input(
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(QVB))
) -> lustre@vdom@vnode:element(QVB).
search_input(Id, Placeholder, Menu_id, Attrs) ->
    lustre@element@html:input(
        [lustre@attribute:type_(<<"text"/utf8>>),
            lustre@attribute:id(Id),
            lustre@attribute:placeholder(Placeholder),
            lustre@attribute:autocomplete(<<"off"/utf8>>),
            lustre@attribute:autocorrect(false),
            lustre@attribute:spellcheck(false),
            lustre@attribute:aria_autocomplete(<<"list"/utf8>>),
            lustre@attribute:role(<<"combobox"/utf8>>),
            lustre@attribute:aria_expanded(true),
            lustre@attribute:aria_controls(Menu_id) |
            Attrs]
    ).

-file("src/glaze/basecoat/command.gleam", 117).
-spec menu(
    binary(),
    list(lustre@vdom@vattr:attribute(QVF)),
    list(lustre@vdom@vnode:element(QVF))
) -> lustre@vdom@vnode:element(QVF).
menu(Id, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(Id),
            lustre@attribute:role(<<"menu"/utf8>>),
            lustre@attribute:aria_orientation(<<"vertical"/utf8>>),
            lustre@attribute:class(<<"scrollbar"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 134).
-spec menu_with_empty(
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(QVL)),
    list(lustre@vdom@vnode:element(QVL))
) -> lustre@vdom@vnode:element(QVL).
menu_with_empty(Id, Empty_message, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(Id),
            lustre@attribute:role(<<"menu"/utf8>>),
            lustre@attribute:aria_orientation(<<"vertical"/utf8>>),
            lustre@attribute:data(<<"empty"/utf8>>, Empty_message),
            lustre@attribute:class(<<"scrollbar"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 153).
-spec item(
    list(lustre@vdom@vattr:attribute(QVR)),
    list(lustre@vdom@vnode:element(QVR))
) -> lustre@vdom@vnode:element(QVR).
item(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:role(<<"menuitem"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 160).
-spec item_with_shortcut(
    binary(),
    list(lustre@vdom@vattr:attribute(QVX)),
    list(lustre@vdom@vnode:element(QVX))
) -> lustre@vdom@vnode:element(QVX).
item_with_shortcut(Shortcut, Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:role(<<"menuitem"/utf8>>) | Attrs],
        lists:append(
            Children,
            [lustre@element@html:kbd(
                    [lustre@attribute:class(
                            <<"ml-auto text-muted-foreground bg-transparent tracking-widest"/utf8>>
                        )],
                    [lustre@element@html:text(Shortcut)]
                )]
        )
    ).

-file("src/glaze/basecoat/command.gleam", 180).
-spec item_disabled(
    list(lustre@vdom@vattr:attribute(QWD)),
    list(lustre@vdom@vnode:element(QWD))
) -> lustre@vdom@vnode:element(QWD).
item_disabled(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:role(<<"menuitem"/utf8>>),
            lustre@attribute:aria_disabled(true) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 190).
-spec item_link(
    binary(),
    list(lustre@vdom@vattr:attribute(QWJ)),
    list(lustre@vdom@vnode:element(QWJ))
) -> lustre@vdom@vnode:element(QWJ).
item_link(Href, Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:href(Href),
            lustre@attribute:role(<<"menuitem"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/command.gleam", 198).
-spec group(binary(), list(lustre@vdom@vnode:element(QWP))) -> lustre@vdom@vnode:element(QWP).
group(Label, Items) ->
    Label_id = <<"group-label-"/utf8, Label/binary>>,
    lustre@element@html:'div'(
        [lustre@attribute:role(<<"group"/utf8>>),
            lustre@attribute:aria_labelledby(Label_id)],
        [lustre@element@html:span(
                [lustre@attribute:role(<<"heading"/utf8>>),
                    lustre@attribute:id(Label_id)],
                [lustre@element@html:text(Label)]
            ) |
            Items]
    ).

-file("src/glaze/basecoat/command.gleam", 208).
-spec separator() -> lustre@vdom@vnode:element(any()).
separator() ->
    lustre@element@html:hr([lustre@attribute:role(<<"separator"/utf8>>)]).

-file("src/glaze/basecoat/command.gleam", 212).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:aria_disabled(true).

-file("src/glaze/basecoat/command.gleam", 216).
-spec filter(binary()) -> lustre@vdom@vattr:attribute(any()).
filter(Text) ->
    lustre@attribute:data(<<"filter"/utf8>>, Text).

-file("src/glaze/basecoat/command.gleam", 220).
-spec keywords(binary()) -> lustre@vdom@vattr:attribute(any()).
keywords(Text) ->
    lustre@attribute:data(<<"keywords"/utf8>>, Text).

-file("src/glaze/basecoat/command.gleam", 224).
-spec force_show() -> lustre@vdom@vattr:attribute(any()).
force_show() ->
    lustre@attribute:data(<<"force"/utf8>>, <<""/utf8>>).

-file("src/glaze/basecoat/command.gleam", 228).
-spec open_script(binary()) -> binary().
open_script(Dialog_id) ->
    <<<<"document.getElementById('"/utf8, Dialog_id/binary>>/binary,
        "').showModal()"/utf8>>.

-file("src/glaze/basecoat/command.gleam", 232).
-spec close_script(binary()) -> binary().
close_script(Dialog_id) ->
    <<<<"document.getElementById('"/utf8, Dialog_id/binary>>/binary,
        "').close()"/utf8>>.
