-module(glaze@basecoat@badge).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/badge.gleam").
-export([badge/2, secondary/2, outline/2, destructive/2, link/2, link_secondary/2, link_outline/2, link_destructive/2, with_icon/3]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/badge/>\n"
    "\n"
    " The [`badge`](#badge) element, sometimes called a \"tag\", is used to attach\n"
    " short contextual information to nearby content.\n"
    "\n"
    " Common examples include labels like \"New\", \"Beta\", \"Paid\", or status chips\n"
    " in lists and cards.\n"
    "\n"
    " ## Variants\n"
    "\n"
    " - [`secondary`](#secondary)\n"
    " - [`outline`](#outline)\n"
    " - [`destructive`](#destructive)\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/badge\n"
    " import lustre/element/html\n"
    "\n"
    " fn status() {\n"
    "   badge.badge([], [html.text(\"New\")])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/badge.gleam", 31).
-spec badge(
    list(lustre@vdom@vattr:attribute(QCY)),
    list(lustre@vdom@vnode:element(QCY))
) -> lustre@vdom@vnode:element(QCY).
badge(Attrs, Children) ->
    lustre@element@html:span(
        [lustre@attribute:class(<<"badge"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 38).
-spec secondary(
    list(lustre@vdom@vattr:attribute(QDE)),
    list(lustre@vdom@vnode:element(QDE))
) -> lustre@vdom@vnode:element(QDE).
secondary(Attrs, Children) ->
    lustre@element@html:span(
        [lustre@attribute:class(<<"badge-secondary"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 45).
-spec outline(
    list(lustre@vdom@vattr:attribute(QDK)),
    list(lustre@vdom@vnode:element(QDK))
) -> lustre@vdom@vnode:element(QDK).
outline(Attrs, Children) ->
    lustre@element@html:span(
        [lustre@attribute:class(<<"badge-outline"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 52).
-spec destructive(
    list(lustre@vdom@vattr:attribute(QDQ)),
    list(lustre@vdom@vnode:element(QDQ))
) -> lustre@vdom@vnode:element(QDQ).
destructive(Attrs, Children) ->
    lustre@element@html:span(
        [lustre@attribute:class(<<"badge-destructive"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 59).
-spec link(
    list(lustre@vdom@vattr:attribute(QDW)),
    list(lustre@vdom@vnode:element(QDW))
) -> lustre@vdom@vnode:element(QDW).
link(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"badge"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 66).
-spec link_secondary(
    list(lustre@vdom@vattr:attribute(QEC)),
    list(lustre@vdom@vnode:element(QEC))
) -> lustre@vdom@vnode:element(QEC).
link_secondary(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"badge-secondary"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 73).
-spec link_outline(
    list(lustre@vdom@vattr:attribute(QEI)),
    list(lustre@vdom@vnode:element(QEI))
) -> lustre@vdom@vnode:element(QEI).
link_outline(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"badge-outline"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 80).
-spec link_destructive(
    list(lustre@vdom@vattr:attribute(QEO)),
    list(lustre@vdom@vnode:element(QEO))
) -> lustre@vdom@vnode:element(QEO).
link_destructive(Attrs, Children) ->
    lustre@element@html:a(
        [lustre@attribute:class(<<"badge-destructive"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/badge.gleam", 87).
-spec with_icon(
    lustre@vdom@vnode:element(QEU),
    list(lustre@vdom@vattr:attribute(QEU)),
    list(lustre@vdom@vnode:element(QEU))
) -> lustre@vdom@vnode:element(QEU).
with_icon(Icon, Attrs, Children) ->
    lustre@element@html:span(
        [lustre@attribute:class(<<"badge"/utf8>>) | Attrs],
        [Icon | Children]
    ).
