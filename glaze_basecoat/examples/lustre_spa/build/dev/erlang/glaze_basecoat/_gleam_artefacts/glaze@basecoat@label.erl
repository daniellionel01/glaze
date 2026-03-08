-module(glaze@basecoat@label).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/label.gleam").
-export([label/2, with_input/3]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/label/>\n"
    "\n"
    " Label helpers for form controls.\n"
    "\n"
    " Pair a label with an input by using `attribute.for(...)` and a matching\n"
    " input `id`.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/label\n"
    " import lustre/attribute\n"
    " import lustre/element/html\n"
    "\n"
    " fn email_field() {\n"
    "   label.label([attribute.for(\"email\")], [html.text(\"Email\")])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/label.gleam", 25).
-spec label(
    list(lustre@vdom@vattr:attribute(SEB)),
    list(lustre@vdom@vnode:element(SEB))
) -> lustre@vdom@vnode:element(SEB).
label(Attrs, Children) ->
    lustre@element@html:label(
        [lustre@attribute:class(<<"label"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/label.gleam", 32).
-spec with_input(binary(), binary(), list(lustre@vdom@vattr:attribute(SEH))) -> lustre@vdom@vnode:element(SEH).
with_input(Id, Label_text, Input_attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"grid gap-2"/utf8>>)],
        [label(
                [lustre@attribute:for(Id)],
                [lustre@element@html:text(Label_text)]
            ),
            lustre@element@html:input(
                [lustre@attribute:id(Id),
                    lustre@attribute:type_(<<"text"/utf8>>),
                    lustre@attribute:class(<<"input"/utf8>>) |
                    Input_attrs]
            )]
    ).
