-module(glaze@basecoat@avatar).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/avatar.gleam").
-export([avatar/1, rounded/1, initials/2, group/2, small/0, large/0, extra_large/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/avatar/>\n"
    "\n"
    " Avatar helpers for user/profile images.\n"
    "\n"
    " These helpers style regular `<img>` elements (and a few common fallbacks)\n"
    " so avatars look consistent across your UI.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " - [`avatar`](#avatar) / [`rounded`](#rounded): image-based avatar\n"
    " - [`initials`](#initials): text fallback\n"
    " - [`group`](#group): stacked/overlapping avatar rows\n"
    "\n"
    " ## Recipes\n"
    "\n"
    " ### A user avatar\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/avatar\n"
    " import lustre/attribute\n"
    "\n"
    " fn user_avatar() {\n"
    "   avatar.avatar([\n"
    "     attribute.src(\"https://github.com/user.png\"),\n"
    "     attribute.alt(\"User name\"),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ### An avatar group\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/avatar\n"
    " import lustre/attribute\n"
    "\n"
    " fn team_avatars() {\n"
    "   avatar.group([], [\n"
    "     avatar.avatar([attribute.src(\"https://github.com/user1.png\"), attribute.alt(\"User 1\")]),\n"
    "     avatar.avatar([attribute.src(\"https://github.com/user2.png\"), attribute.alt(\"User 2\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/avatar.gleam", 49).
-spec avatar(list(lustre@vdom@vattr:attribute(QBI))) -> lustre@vdom@vnode:element(QBI).
avatar(Attrs) ->
    lustre@element@html:img(
        [lustre@attribute:class(
                <<"size-8 shrink-0 object-cover rounded-full"/utf8>>
            ) |
            Attrs]
    ).

-file("src/glaze/basecoat/avatar.gleam", 56).
-spec rounded(list(lustre@vdom@vattr:attribute(QBM))) -> lustre@vdom@vnode:element(QBM).
rounded(Attrs) ->
    lustre@element@html:img(
        [lustre@attribute:class(
                <<"size-8 shrink-0 object-cover rounded-lg"/utf8>>
            ) |
            Attrs]
    ).

-file("src/glaze/basecoat/avatar.gleam", 60).
-spec initials(binary(), list(lustre@vdom@vattr:attribute(QBQ))) -> lustre@vdom@vnode:element(QBQ).
initials(Text, Attrs) ->
    lustre@element@html:span(
        [lustre@attribute:class(
                <<"size-8 shrink-0 rounded-full bg-muted flex items-center justify-center text-sm font-medium"/utf8>>
            ) |
            Attrs],
        [lustre@element@html:text(Text)]
    ).

-file("src/glaze/basecoat/avatar.gleam", 72).
-spec group(
    list(lustre@vdom@vattr:attribute(QBU)),
    list(lustre@vdom@vnode:element(QBU))
) -> lustre@vdom@vnode:element(QBU).
group(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(
                <<"flex -space-x-2 [&_img]:ring-2 [&_img]:ring-background [&_img]:size-8 [&_img]:shrink-0 [&_img]:object-cover [&_img]:rounded-full"/utf8>>
            ) |
            Attrs],
        Children
    ).

-file("src/glaze/basecoat/avatar.gleam", 87).
-spec small() -> lustre@vdom@vattr:attribute(any()).
small() ->
    lustre@attribute:class(<<"size-6"/utf8>>).

-file("src/glaze/basecoat/avatar.gleam", 91).
-spec large() -> lustre@vdom@vattr:attribute(any()).
large() ->
    lustre@attribute:class(<<"size-12"/utf8>>).

-file("src/glaze/basecoat/avatar.gleam", 95).
-spec extra_large() -> lustre@vdom@vattr:attribute(any()).
extra_large() ->
    lustre@attribute:class(<<"size-16"/utf8>>).
