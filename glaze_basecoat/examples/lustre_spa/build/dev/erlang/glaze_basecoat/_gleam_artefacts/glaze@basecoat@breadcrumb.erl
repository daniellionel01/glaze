-module(glaze@basecoat@breadcrumb).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/breadcrumb.gleam").
-export([breadcrumb/2, item/2, current/2, separator/1, with_items/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/breadcrumb/>\n"
    "\n"
    " The [`breadcrumb`](#breadcrumb) helpers render hierarchical navigation for\n"
    " showing where a user is in the app and how to move back up.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " Use [`breadcrumb`](#breadcrumb) as the ordered list container. Each step is\n"
    " typically an [`item`](#item) link, followed by a [`current`](#current)\n"
    " element.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/breadcrumb\n"
    " import lustre/attribute\n"
    " import lustre/element/html\n"
    "\n"
    " fn nav_breadcrumb() {\n"
    "   html.nav([attribute.aria_label(\"Breadcrumb\")], [\n"
    "     breadcrumb.breadcrumb([], [\n"
    "       breadcrumb.item([attribute.href(\"/\")], [html.text(\"Home\")]),\n"
    "       breadcrumb.separator([]),\n"
    "       breadcrumb.item([attribute.href(\"/docs\")], [html.text(\"Documentation\")]),\n"
    "       breadcrumb.separator([]),\n"
    "       breadcrumb.current([], [html.text(\"Components\")]),\n"
    "     ])\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/breadcrumb.gleam", 38).
-spec breadcrumb(
    list(lustre@vdom@vattr:attribute(QGE)),
    list(lustre@vdom@vnode:element(QGE))
) -> lustre@vdom@vnode:element(QGE).
breadcrumb(Attrs, Children) ->
    lustre@element@html:ol(
        [lustre@attribute:class(
                <<"text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/breadcrumb.gleam", 53).
-spec item(
    list(lustre@vdom@vattr:attribute(QGK)),
    list(lustre@vdom@vnode:element(QGK))
) -> lustre@vdom@vnode:element(QGK).
item(Attrs, Children) ->
    lustre@element@html:li(
        [lustre@attribute:class(<<"inline-flex items-center gap-1.5"/utf8>>)],
        [lustre@element@html:a(
                [lustre@attribute:class(
                        <<"hover:text-foreground transition-colors"/utf8>>
                    ) |
                    Attrs],
                Children
            )]
    ).

-file("src/glaze/basecoat/breadcrumb.gleam", 65).
-spec current(
    list(lustre@vdom@vattr:attribute(QGQ)),
    list(lustre@vdom@vnode:element(QGQ))
) -> lustre@vdom@vnode:element(QGQ).
current(Attrs, Children) ->
    lustre@element@html:li(
        [lustre@attribute:class(<<"inline-flex items-center gap-1.5"/utf8>>)],
        [lustre@element@html:span(
                [lustre@attribute:class(<<"text-foreground font-normal"/utf8>>) |
                    Attrs],
                Children
            )]
    ).

-file("src/glaze/basecoat/breadcrumb.gleam", 77).
-spec separator(list(lustre@vdom@vattr:attribute(QGW))) -> lustre@vdom@vnode:element(QGW).
separator(Attrs) ->
    lustre@element@html:li(
        Attrs,
        [lustre@element@html:span(
                [lustre@attribute:class(<<"size-3.5"/utf8>>)],
                [lustre@element@html:text(<<"›"/utf8>>)]
            )]
    ).

-file("src/glaze/basecoat/breadcrumb.gleam", 85).
-spec with_items(
    list({binary(), binary(), boolean()}),
    list(lustre@vdom@vattr:attribute(QHB))
) -> lustre@vdom@vnode:element(QHB).
with_items(Items, Attrs) ->
    Separated = begin
        _pipe = Items,
        _pipe@1 = gleam@list:map(
            _pipe,
            fun(I) ->
                {Href, Label, Is_current} = I,
                case Is_current of
                    true ->
                        current([], [lustre@element@html:text(Label)]);

                    false ->
                        item(
                            [lustre@attribute:href(Href)],
                            [lustre@element@html:text(Label)]
                        )
                end
            end
        ),
        gleam@list:intersperse(_pipe@1, separator([]))
    end,
    breadcrumb(Attrs, Separated).
