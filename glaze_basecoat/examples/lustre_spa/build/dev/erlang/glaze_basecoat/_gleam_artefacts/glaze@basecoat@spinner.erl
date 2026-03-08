-module(glaze@basecoat@spinner).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/spinner.gleam").
-export([spinner/1, small/0, large/0, overlay/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/spinner/>\n"
    "\n"
    " Spinner attribute helpers for loading states.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/spinner\n"
    "\n"
    " fn loading() {\n"
    "   spinner.spinner([])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `status` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/status_role>\n"
    " - MDN `aria-busy`: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Attributes/aria-busy>\n"
).

-file("src/glaze/basecoat/spinner.gleam", 25).
-spec spinner(list(lustre@vdom@vattr:attribute(SZR))) -> lustre@vdom@vnode:element(SZR).
spinner(Attrs) ->
    lustre@element@svg:svg(
        [lustre@attribute:attribute(
                <<"xmlns"/utf8>>,
                <<"http://www.w3.org/2000/svg"/utf8>>
            ),
            lustre@attribute:attribute(<<"width"/utf8>>, <<"24"/utf8>>),
            lustre@attribute:attribute(<<"height"/utf8>>, <<"24"/utf8>>),
            lustre@attribute:attribute(<<"viewBox"/utf8>>, <<"0 0 24 24"/utf8>>),
            lustre@attribute:attribute(<<"fill"/utf8>>, <<"none"/utf8>>),
            lustre@attribute:attribute(
                <<"stroke"/utf8>>,
                <<"currentColor"/utf8>>
            ),
            lustre@attribute:attribute(<<"stroke-width"/utf8>>, <<"2"/utf8>>),
            lustre@attribute:attribute(
                <<"stroke-linecap"/utf8>>,
                <<"round"/utf8>>
            ),
            lustre@attribute:attribute(
                <<"stroke-linejoin"/utf8>>,
                <<"round"/utf8>>
            ),
            lustre@attribute:role(<<"status"/utf8>>),
            lustre@attribute:aria_label(<<"Loading"/utf8>>),
            lustre@attribute:class(<<"animate-spin size-4"/utf8>>) |
            Attrs],
        [lustre@element@svg:path(
                [lustre@attribute:attribute(
                        <<"d"/utf8>>,
                        <<"M21 12a9 9 0 1 1-6.219-8.56"/utf8>>
                    )]
            )]
    ).

-file("src/glaze/basecoat/spinner.gleam", 48).
-spec small() -> lustre@vdom@vattr:attribute(any()).
small() ->
    lustre@attribute:class(<<"size-3"/utf8>>).

-file("src/glaze/basecoat/spinner.gleam", 52).
-spec large() -> lustre@vdom@vattr:attribute(any()).
large() ->
    lustre@attribute:class(<<"size-8"/utf8>>).

-file("src/glaze/basecoat/spinner.gleam", 56).
-spec overlay(
    list(lustre@vdom@vattr:attribute(SZZ)),
    list(lustre@vdom@vnode:element(SZZ))
) -> lustre@vdom@vnode:element(SZZ).
overlay(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"relative"/utf8>>),
            lustre@attribute:attribute(<<"aria-busy"/utf8>>, <<"true"/utf8>>) |
            Attrs],
        [lustre@element@html:'div'(
                [lustre@attribute:class(
                        <<"absolute inset-0 flex items-center justify-center bg-background/80"/utf8>>
                    )],
                [spinner([])]
            ),
            lustre@element@html:'div'(
                [lustre@attribute:class(
                        <<"opacity-50 pointer-events-none"/utf8>>
                    )],
                Children
            )]
    ).
