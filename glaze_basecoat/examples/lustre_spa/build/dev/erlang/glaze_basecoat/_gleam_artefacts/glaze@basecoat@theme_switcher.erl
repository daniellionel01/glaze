-module(glaze@basecoat@theme_switcher).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/theme_switcher.gleam").
-export([init_script/0, toggle_script/0, set_dark_script/0, set_light_script/0, button/1, button_with_tooltip/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/theme-switcher/>\n"
    "\n"
    " Theme switcher helpers for toggling a light/dark class.\n"
    "\n"
    " **Note**: This component requires the theme script in the `<head>`.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/theme_switcher\n"
    " import lustre/element/html\n"
    "\n"
    " fn my_theme_switcher() {\n"
    "   theme_switcher.button([])\n"
    " }\n"
    " ```\n"
    "\n"
    " Add the initialization script once in your document `<head>`:\n"
    "\n"
    " ```gleam\n"
    " html.head([], [\n"
    "   theme_switcher.init_script(),\n"
    " ])\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN `prefers-color-scheme`: <https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme>\n"
).

-file("src/glaze/basecoat/theme_switcher.gleam", 35).
-spec init_script() -> lustre@vdom@vnode:element(any()).
init_script() ->
    lustre@element@html:script(
        [lustre@attribute:type_(<<"text/javascript"/utf8>>)],
        <<"(() => {
      try {
        const stored = localStorage.getItem('themeMode');
        if (stored ? stored === 'dark' : matchMedia('(prefers-color-scheme: dark)').matches) {
          document.documentElement.classList.add('dark');
        }
      } catch (_) {}

      const apply = (dark) => {
        document.documentElement.classList.toggle('dark', dark);
        try { localStorage.setItem('themeMode', dark ? 'dark' : 'light'); } catch (_) {}
      };

      document.addEventListener('basecoat:theme', (event) => {
        const mode = event.detail?.mode;
        apply(mode === 'dark' ? true : mode === 'light' ? false : !document.documentElement.classList.contains('dark'));
      });
    })();"/utf8>>
    ).

-file("src/glaze/basecoat/theme_switcher.gleam", 59).
-spec toggle_script() -> binary().
toggle_script() ->
    <<"document.dispatchEvent(new CustomEvent('basecoat:theme'))"/utf8>>.

-file("src/glaze/basecoat/theme_switcher.gleam", 63).
-spec set_dark_script() -> binary().
set_dark_script() ->
    <<"document.dispatchEvent(new CustomEvent('basecoat:theme', { detail: { mode: 'dark' } }))"/utf8>>.

-file("src/glaze/basecoat/theme_switcher.gleam", 67).
-spec set_light_script() -> binary().
set_light_script() ->
    <<"document.dispatchEvent(new CustomEvent('basecoat:theme', { detail: { mode: 'light' } }))"/utf8>>.

-file("src/glaze/basecoat/theme_switcher.gleam", 108).
-spec sun_icon() -> lustre@vdom@vnode:element(any()).
sun_icon() ->
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
            )],
        [lustre@element@svg:circle(
                [lustre@attribute:attribute(<<"cx"/utf8>>, <<"12"/utf8>>),
                    lustre@attribute:attribute(<<"cy"/utf8>>, <<"12"/utf8>>),
                    lustre@attribute:attribute(<<"r"/utf8>>, <<"4"/utf8>>)]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(<<"d"/utf8>>, <<"M12 2v2"/utf8>>)]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(<<"d"/utf8>>, <<"M12 20v2"/utf8>>)]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(
                        <<"d"/utf8>>,
                        <<"m4.93 4.93 1.41 1.41"/utf8>>
                    )]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(
                        <<"d"/utf8>>,
                        <<"m17.66 17.66 1.41 1.41"/utf8>>
                    )]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(<<"d"/utf8>>, <<"M2 12h2"/utf8>>)]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(<<"d"/utf8>>, <<"M20 12h2"/utf8>>)]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(
                        <<"d"/utf8>>,
                        <<"m6.34 17.66-1.41 1.41"/utf8>>
                    )]
            ),
            lustre@element@svg:path(
                [lustre@attribute:attribute(
                        <<"d"/utf8>>,
                        <<"m19.07 4.93-1.41 1.41"/utf8>>
                    )]
            )]
    ).

-file("src/glaze/basecoat/theme_switcher.gleam", 139).
-spec moon_icon() -> lustre@vdom@vnode:element(any()).
moon_icon() ->
    lustre@element:element(
        <<"svg"/utf8>>,
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
            )],
        [lustre@element@svg:path(
                [lustre@attribute:attribute(
                        <<"d"/utf8>>,
                        <<"M12 3a6 6 0 0 0 9 9 9 9 0 1 1-9-9Z"/utf8>>
                    )]
            )]
    ).

-file("src/glaze/basecoat/theme_switcher.gleam", 71).
-spec button(list(lustre@vdom@vattr:attribute(TLV))) -> lustre@vdom@vnode:element(TLV).
button(Attrs) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:aria_label(<<"Toggle dark mode"/utf8>>),
            lustre@attribute:attribute(<<"onclick"/utf8>>, toggle_script()),
            lustre@attribute:class(<<"btn-icon-outline size-8"/utf8>>) |
            Attrs],
        [lustre@element@html:span(
                [lustre@attribute:class(<<"hidden dark:block"/utf8>>)],
                [sun_icon()]
            ),
            lustre@element@html:span(
                [lustre@attribute:class(<<"block dark:hidden"/utf8>>)],
                [moon_icon()]
            )]
    ).

-file("src/glaze/basecoat/theme_switcher.gleam", 87).
-spec button_with_tooltip(binary(), list(lustre@vdom@vattr:attribute(TLZ))) -> lustre@vdom@vnode:element(TLZ).
button_with_tooltip(Tooltip_side, Attrs) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:aria_label(<<"Toggle dark mode"/utf8>>),
            lustre@attribute:data(
                <<"tooltip"/utf8>>,
                <<"Toggle dark mode"/utf8>>
            ),
            lustre@attribute:data(<<"side"/utf8>>, Tooltip_side),
            lustre@attribute:attribute(<<"onclick"/utf8>>, toggle_script()),
            lustre@attribute:class(<<"btn-icon-outline size-8"/utf8>>) |
            Attrs],
        [lustre@element@html:span(
                [lustre@attribute:class(<<"hidden dark:block"/utf8>>)],
                [sun_icon()]
            ),
            lustre@element@html:span(
                [lustre@attribute:class(<<"block dark:hidden"/utf8>>)],
                [moon_icon()]
            )]
    ).
