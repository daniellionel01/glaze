-module(glaze@basecoat@accordion).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/accordion.gleam").
-export([accordion/2, item/3, item_open/3]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/accordion/>\n"
    "\n"
    " The [`accordion`](#accordion) helpers render semantic HTML accordion markup\n"
    " using `<details>` and `<summary>` elements.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " Each accordion `item` is a `<details>` with a `<summary>` title and a\n"
    " content section.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/accordion\n"
    " import lustre/element/html\n"
    "\n"
    " fn my_accordion() {\n"
    "   accordion.accordion([], [\n"
    "     accordion.item(\"Is it accessible?\", [], [\n"
    "       html.p([], [html.text(\"Yes. It adheres to the WAI-ARIA design pattern.\")]),\n"
    "     ]),\n"
    "     accordion.item(\"Is it styled?\", [], [\n"
    "       html.p([], [html.text(\"Yes. It comes with default styles.\")]),\n"
    "     ]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN `<details>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details>\n"
    " - MDN `<summary>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/summary>\n"
).

-file("src/glaze/basecoat/accordion.gleam", 39).
-spec accordion(
    list(lustre@vdom@vattr:attribute(PPY)),
    list(lustre@vdom@vnode:element(PPY))
) -> lustre@vdom@vnode:element(PPY).
accordion(Attrs, Children) ->
    lustre@element@html:section(
        [lustre@attribute:class(<<"accordion"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/accordion.gleam", 46).
-spec item(
    binary(),
    list(lustre@vdom@vattr:attribute(PQE)),
    list(lustre@vdom@vnode:element(PQE))
) -> lustre@vdom@vnode:element(PQE).
item(Title, Attrs, Children) ->
    lustre@element@html:details(
        [lustre@attribute:class(<<"group border-b last:border-b-0"/utf8>>) |
            Attrs],
        [lustre@element@html:summary(
                [lustre@attribute:class(
                        <<"w-full focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] transition-all outline-none rounded-md"/utf8>>
                    )],
                [lustre@element@html:h2(
                        [lustre@attribute:class(
                                <<"flex flex-1 items-start justify-between gap-4 py-4 text-left text-sm font-medium hover:underline"/utf8>>
                            )],
                        [lustre@element@html:text(Title),
                            lustre@element@svg:svg(
                                [lustre@attribute:attribute(
                                        <<"xmlns"/utf8>>,
                                        <<"http://www.w3.org/2000/svg"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"width"/utf8>>,
                                        <<"24"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"height"/utf8>>,
                                        <<"24"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"viewBox"/utf8>>,
                                        <<"0 0 24 24"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"fill"/utf8>>,
                                        <<"none"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke"/utf8>>,
                                        <<"currentColor"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke-width"/utf8>>,
                                        <<"2"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke-linecap"/utf8>>,
                                        <<"round"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke-linejoin"/utf8>>,
                                        <<"round"/utf8>>
                                    ),
                                    lustre@attribute:class(
                                        <<"text-muted-foreground pointer-events-none size-4 shrink-0 translate-y-0.5 transition-transform duration-200 group-open:rotate-180"/utf8>>
                                    )],
                                [lustre@element@svg:path(
                                        [lustre@attribute:attribute(
                                                <<"d"/utf8>>,
                                                <<"m6 9 6 6 6-6"/utf8>>
                                            )]
                                    )]
                            )]
                    )]
            ),
            lustre@element@html:section(
                [lustre@attribute:class(<<"pb-4"/utf8>>)],
                Children
            )]
    ).

-file("src/glaze/basecoat/accordion.gleam", 94).
-spec item_open(
    binary(),
    list(lustre@vdom@vattr:attribute(PQK)),
    list(lustre@vdom@vnode:element(PQK))
) -> lustre@vdom@vnode:element(PQK).
item_open(Title, Attrs, Children) ->
    lustre@element@html:details(
        [lustre@attribute:class(<<"group border-b last:border-b-0"/utf8>>),
            lustre@attribute:open(true) |
            Attrs],
        [lustre@element@html:summary(
                [lustre@attribute:class(
                        <<"w-full focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] transition-all outline-none rounded-md"/utf8>>
                    )],
                [lustre@element@html:h2(
                        [lustre@attribute:class(
                                <<"flex flex-1 items-start justify-between gap-4 py-4 text-left text-sm font-medium hover:underline"/utf8>>
                            )],
                        [lustre@element@html:text(Title),
                            lustre@element@svg:svg(
                                [lustre@attribute:attribute(
                                        <<"xmlns"/utf8>>,
                                        <<"http://www.w3.org/2000/svg"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"width"/utf8>>,
                                        <<"24"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"height"/utf8>>,
                                        <<"24"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"viewBox"/utf8>>,
                                        <<"0 0 24 24"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"fill"/utf8>>,
                                        <<"none"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke"/utf8>>,
                                        <<"currentColor"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke-width"/utf8>>,
                                        <<"2"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke-linecap"/utf8>>,
                                        <<"round"/utf8>>
                                    ),
                                    lustre@attribute:attribute(
                                        <<"stroke-linejoin"/utf8>>,
                                        <<"round"/utf8>>
                                    ),
                                    lustre@attribute:class(
                                        <<"text-muted-foreground pointer-events-none size-4 shrink-0 translate-y-0.5 transition-transform duration-200 group-open:rotate-180"/utf8>>
                                    )],
                                [lustre@element@svg:path(
                                        [lustre@attribute:attribute(
                                                <<"d"/utf8>>,
                                                <<"m6 9 6 6 6-6"/utf8>>
                                            )]
                                    )]
                            )]
                    )]
            ),
            lustre@element@html:section(
                [lustre@attribute:class(<<"pb-4"/utf8>>)],
                Children
            )]
    ).
