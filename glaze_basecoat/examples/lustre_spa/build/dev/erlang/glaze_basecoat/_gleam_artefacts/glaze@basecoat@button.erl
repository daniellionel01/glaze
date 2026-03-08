-module(glaze@basecoat@button).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/button.gleam").
-export([group/2, button/2, secondary/2, destructive/2, outline/2, ghost/2, link_style/2, icon/2, icon_outline/2, icon_destructive/2, link/2, link_secondary/2, link_outline/2, link_ghost/2, link_destructive/2, small/0, large/0, full_width/0, disabled/0, loading/0, submit/2, reset/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/button/>\n"
    "\n"
    " The [`button`](#button) helpers style interactive actions and links with a\n"
    " consistent API.\n"
    "\n"
    " Use regular buttons for in-page actions, and use [`link`](#link) when the\n"
    " interaction navigates to a different location.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A button setup usually has one interactive element and optional button groups.\n"
    " `group` wraps multiple actions in a semantic menu/list structure so spacing\n"
    " and alignment stay consistent.\n"
    "\n"
    " ## Recipes\n"
    "\n"
    " ### A primary action button\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/button\n"
    " import lustre/element/html\n"
    "\n"
    " fn save_button() {\n"
    "   button.button([], [html.text(\"Save\")])\n"
    " }\n"
    " ```\n"
    "\n"
    " ### A grouped action row\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/button\n"
    " import lustre/element/html\n"
    "\n"
    " fn actions() {\n"
    "   button.group([], [\n"
    "     button.button([button.outline()], [html.text(\"Cancel\")]),\n"
    "     button.button([], [html.text(\"Continue\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ### A link styled as button\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/button\n"
    " import lustre/attribute\n"
    " import lustre/element/html\n"
    "\n"
    " fn docs_link() {\n"
    "   button.link([attribute.href(\"/docs\"), button.outline()], [\n"
    "     html.text(\"Read docs\"),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## Variants\n"
    "\n"
    " - [`primary`](#primary) - Primary button (default `btn`)\n"
    " - [`secondary`](#secondary) - Secondary button\n"
    " - [`destructive`](#destructive) - Destructive/danger button\n"
    " - [`outline`](#outline) - Outline button\n"
    " - [`ghost`](#ghost) - Ghost button\n"
    " - [`link`](#link) - Link-styled button\n"
    "\n"
    " ## Sizes\n"
    "\n"
    " - [`small`](#small) - Small button\n"
    " - [`large`](#large) - Large button\n"
    "\n"
).

-file("src/glaze/basecoat/button.gleam", 75).
-spec group(
    list(lustre@vdom@vattr:attribute(QIV)),
    list(lustre@vdom@vnode:element(QIV))
) -> lustre@vdom@vnode:element(QIV).
group(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"flex items-center gap-2"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 82).
-spec button(
    list(lustre@vdom@vattr:attribute(QJB)),
    list(lustre@vdom@vnode:element(QJB))
) -> lustre@vdom@vnode:element(QJB).
button(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 92).
-spec secondary(
    list(lustre@vdom@vattr:attribute(QJH)),
    list(lustre@vdom@vnode:element(QJH))
) -> lustre@vdom@vnode:element(QJH).
secondary(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-secondary"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 102).
-spec destructive(
    list(lustre@vdom@vattr:attribute(QJN)),
    list(lustre@vdom@vnode:element(QJN))
) -> lustre@vdom@vnode:element(QJN).
destructive(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-destructive"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 112).
-spec outline(
    list(lustre@vdom@vattr:attribute(QJT)),
    list(lustre@vdom@vnode:element(QJT))
) -> lustre@vdom@vnode:element(QJT).
outline(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-outline"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 122).
-spec ghost(
    list(lustre@vdom@vattr:attribute(QJZ)),
    list(lustre@vdom@vnode:element(QJZ))
) -> lustre@vdom@vnode:element(QJZ).
ghost(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-ghost"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 132).
-spec link_style(
    list(lustre@vdom@vattr:attribute(QKF)),
    list(lustre@vdom@vnode:element(QKF))
) -> lustre@vdom@vnode:element(QKF).
link_style(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-link"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 142).
-spec icon(
    list(lustre@vdom@vattr:attribute(QKL)),
    list(lustre@vdom@vnode:element(QKL))
) -> lustre@vdom@vnode:element(QKL).
icon(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-icon"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 152).
-spec icon_outline(
    list(lustre@vdom@vattr:attribute(QKR)),
    list(lustre@vdom@vnode:element(QKR))
) -> lustre@vdom@vnode:element(QKR).
icon_outline(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-icon-outline"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 162).
-spec icon_destructive(
    list(lustre@vdom@vattr:attribute(QKX)),
    list(lustre@vdom@vnode:element(QKX))
) -> lustre@vdom@vnode:element(QKX).
icon_destructive(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn-icon-destructive"/utf8>>),
            lustre@attribute:type_(<<"button"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 176).
-spec link(
    list(lustre@vdom@vattr:attribute(QLD)),
    list(lustre@vdom@vnode:element(QLD))
) -> lustre@vdom@vnode:element(QLD).
link(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"btn"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 183).
-spec link_secondary(
    list(lustre@vdom@vattr:attribute(QLJ)),
    list(lustre@vdom@vnode:element(QLJ))
) -> lustre@vdom@vnode:element(QLJ).
link_secondary(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"btn-secondary"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 190).
-spec link_outline(
    list(lustre@vdom@vattr:attribute(QLP)),
    list(lustre@vdom@vnode:element(QLP))
) -> lustre@vdom@vnode:element(QLP).
link_outline(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"btn-outline"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 197).
-spec link_ghost(
    list(lustre@vdom@vattr:attribute(QLV)),
    list(lustre@vdom@vnode:element(QLV))
) -> lustre@vdom@vnode:element(QLV).
link_ghost(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"btn-ghost"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 204).
-spec link_destructive(
    list(lustre@vdom@vattr:attribute(QMB)),
    list(lustre@vdom@vnode:element(QMB))
) -> lustre@vdom@vnode:element(QMB).
link_destructive(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"btn-destructive"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 211).
-spec small() -> lustre@vdom@vattr:attribute(any()).
small() ->
    lustre@attribute:class(<<"btn-sm"/utf8>>).

-file("src/glaze/basecoat/button.gleam", 215).
-spec large() -> lustre@vdom@vattr:attribute(any()).
large() ->
    lustre@attribute:class(<<"btn-lg"/utf8>>).

-file("src/glaze/basecoat/button.gleam", 219).
-spec full_width() -> lustre@vdom@vattr:attribute(any()).
full_width() ->
    lustre@attribute:class(<<"w-full"/utf8>>).

-file("src/glaze/basecoat/button.gleam", 223).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/button.gleam", 227).
-spec loading() -> lustre@vdom@vattr:attribute(any()).
loading() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/button.gleam", 231).
-spec submit(
    list(lustre@vdom@vattr:attribute(QMR)),
    list(lustre@vdom@vnode:element(QMR))
) -> lustre@vdom@vnode:element(QMR).
submit(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn"/utf8>>),
            lustre@attribute:type_(<<"submit"/utf8>>) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/button.gleam", 241).
-spec reset(
    list(lustre@vdom@vattr:attribute(QMX)),
    list(lustre@vdom@vnode:element(QMX))
) -> lustre@vdom@vnode:element(QMX).
reset(Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:class(<<"btn"/utf8>>),
            lustre@attribute:type_(<<"reset"/utf8>>) |
            Attrs],
        Children
    ).
