-module(glaze@basecoat@skeleton).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/skeleton.gleam").
-export([skeleton/1, text/1, circle/1, image/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/skeleton/>\n"
    "\n"
    " Skeleton placeholders for loading layouts.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/skeleton\n"
    " import lustre/attribute\n"
    "\n"
    " fn loading_state() {\n"
    "   skeleton.skeleton([attribute.class(\"h-4 w-full\")])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `status` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/status_role>\n"
).

-file("src/glaze/basecoat/skeleton.gleam", 24).
-spec skeleton(list(lustre@vdom@vattr:attribute(SXJ))) -> lustre@vdom@vnode:element(SXJ).
skeleton(Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"bg-accent animate-pulse rounded-md"/utf8>>) |
            Attrs],
        []
    ).

-file("src/glaze/basecoat/skeleton.gleam", 28).
-spec text(list(lustre@vdom@vattr:attribute(SXN))) -> lustre@vdom@vnode:element(SXN).
text(Attrs) ->
    skeleton([lustre@attribute:class(<<"h-4"/utf8>>) | Attrs]).

-file("src/glaze/basecoat/skeleton.gleam", 32).
-spec circle(list(lustre@vdom@vattr:attribute(SXR))) -> lustre@vdom@vnode:element(SXR).
circle(Attrs) ->
    skeleton(
        [lustre@attribute:class(<<"rounded-full size-10 shrink-0"/utf8>>) |
            Attrs]
    ).

-file("src/glaze/basecoat/skeleton.gleam", 36).
-spec image(list(lustre@vdom@vattr:attribute(SXV))) -> lustre@vdom@vnode:element(SXV).
image(Attrs) ->
    skeleton([lustre@attribute:class(<<"aspect-square w-full"/utf8>>) | Attrs]).
