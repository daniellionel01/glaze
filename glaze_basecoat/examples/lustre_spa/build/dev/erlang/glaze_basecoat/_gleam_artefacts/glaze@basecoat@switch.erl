-module(glaze@basecoat@switch).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/switch.gleam").
-export([switch/1, with_label/3, with_description/4, checked/0, disabled/0, name/1, id/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/switch/>\n"
    "\n"
    " Switch helpers for binary on/off controls.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/switch\n"
    " import lustre/attribute\n"
    "\n"
    " fn airplane_mode() {\n"
    "   switch.switch([\n"
    "     attribute.id(\"airplane-mode\"),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `switch` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/switch_role>\n"
).

-file("src/glaze/basecoat/switch.gleam", 26).
-spec switch(list(lustre@vdom@vattr:attribute(TBW))) -> lustre@vdom@vnode:element(TBW).
switch(Attrs) ->
    lustre@element@html:input(
        [lustre@attribute:type_(<<"checkbox"/utf8>>),
            lustre@attribute:class(<<"input"/utf8>>),
            lustre@attribute:role(<<"switch"/utf8>>) |
            Attrs]
    ).

-file("src/glaze/basecoat/switch.gleam", 35).
-spec with_label(binary(), binary(), list(lustre@vdom@vattr:attribute(TCA))) -> lustre@vdom@vnode:element(TCA).
with_label(Id, Label_text, Attrs) ->
    lustre@element@html:label(
        [lustre@attribute:class(<<"label"/utf8>>)],
        [switch([lustre@attribute:id(Id) | Attrs]),
            lustre@element@html:text(Label_text)]
    ).

-file("src/glaze/basecoat/switch.gleam", 46).
-spec with_description(
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(TCE))
) -> lustre@vdom@vnode:element(TCE).
with_description(Id, Label_text, Description, Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(
                <<"flex flex-row items-start justify-between rounded-lg border p-4 shadow-xs gap-2"/utf8>>
            )],
        [lustre@element@html:'div'(
                [lustre@attribute:class(<<"flex flex-col gap-0.5"/utf8>>)],
                [lustre@element@html:label(
                        [lustre@attribute:for(Id),
                            lustre@attribute:class(<<"leading-normal"/utf8>>)],
                        [lustre@element@html:text(Label_text)]
                    ),
                    lustre@element@html:p(
                        [lustre@attribute:class(
                                <<"text-muted-foreground text-sm"/utf8>>
                            )],
                        [lustre@element@html:text(Description)]
                    )]
            ),
            switch([lustre@attribute:id(Id) | Attrs])]
    ).

-file("src/glaze/basecoat/switch.gleam", 72).
-spec checked() -> lustre@vdom@vattr:attribute(any()).
checked() ->
    lustre@attribute:checked(true).

-file("src/glaze/basecoat/switch.gleam", 76).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/switch.gleam", 80).
-spec name(binary()) -> lustre@vdom@vattr:attribute(any()).
name(N) ->
    lustre@attribute:name(N).

-file("src/glaze/basecoat/switch.gleam", 84).
-spec id(binary()) -> lustre@vdom@vattr:attribute(any()).
id(Id) ->
    lustre@attribute:id(Id).
