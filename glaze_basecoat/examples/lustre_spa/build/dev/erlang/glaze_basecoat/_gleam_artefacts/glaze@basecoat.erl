-module(glaze@basecoat).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat.gleam").
-export([cdn_script_link/1, cdn_script/1, cdn_stylesheet_link/1, cdn_stylesheet/1, register/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-file("src/glaze/basecoat.gleam", 57).
?DOC(false).
-spec cdn_script_link(binary()) -> binary().
cdn_script_link(V) ->
    <<<<"https://cdn.jsdelivr.net/npm/basecoat-css@"/utf8, V/binary>>/binary,
        "/dist/js/all.min.js"/utf8>>.

-file("src/glaze/basecoat.gleam", 46).
?DOC(
    " <style> element that imports the Basecoat JavaScript from a CDN.\n"
    "\n"
    " This includes the JavaScript for all components.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat\n"
    "\n"
    " html.head([], [\n"
    "   // Your Tailwind CSS import...\n"
    "   basecoat.cdn_script(basecoat.version),\n"
    " ])\n"
    " ```\n"
).
-spec cdn_script(binary()) -> lustre@vdom@vnode:element(any()).
cdn_script(V) ->
    lustre@element@html:script(
        [lustre@attribute:attribute(<<"defer"/utf8>>, <<"defer"/utf8>>),
            lustre@attribute:src(cdn_script_link(V))],
        <<""/utf8>>
    ).

-file("src/glaze/basecoat.gleam", 62).
?DOC(false).
-spec cdn_stylesheet_link(binary()) -> binary().
cdn_stylesheet_link(V) ->
    <<<<"https://cdn.jsdelivr.net/npm/basecoat-css@"/utf8, V/binary>>/binary,
        "/dist/basecoat.cdn.min.css"/utf8>>.

-file("src/glaze/basecoat.gleam", 96).
?DOC(
    " Ensure the <script> tag that loads the Basecoat JavaScript.\n"
    "\n"
    " Available on the JavaScript target.\n"
    "\n"
    " Ensure the <style> tag that loads the Basecoat CSS.\n"
    "\n"
    " Available on the JavaScript target.\n"
    "\n"
    " <style> tag that loads the Basecoat CSS from a CDN.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat\n"
    "\n"
    " html.head([], [\n"
    "   basecoat.cdn_stylesheet(basecoat.version),\n"
    " ])\n"
    " ```\n"
).
-spec cdn_stylesheet(binary()) -> lustre@vdom@vnode:element(any()).
cdn_stylesheet(V) ->
    lustre@element:fragment(
        [lustre@element@html:link(
                [lustre@attribute:rel(<<"stylesheet"/utf8>>),
                    lustre@attribute:href(cdn_stylesheet_link(V))]
            ),
            glaze@basecoat@theme:tailwind_v4_bridge_style_tag()]
    ).

-file("src/glaze/basecoat.gleam", 27).
?DOC(
    " Register Basecoat UI CSS and JavaScript from a CDN.\n"
    "\n"
    " This includes the styles and logic for all components.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat\n"
    "\n"
    " html.head([], [\n"
    "   basecoat.register(basecoat.version),\n"
    " ])\n"
    " ```\n"
).
-spec register(binary()) -> lustre@vdom@vnode:element(any()).
register(V) ->
    lustre@element:fragment([cdn_stylesheet(V), cdn_script(V)]).
