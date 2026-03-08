-module(glaze@basecoat@radio_group).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/radio_group.gleam").
-export([group/3, item/5, radio/3, checked/0, disabled/0, invalid/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/radio-group/>\n"
    "\n"
    " Radio group helpers for mutually exclusive choices.\n"
    "\n"
    " Use [`group`](#group) to render a `fieldset` of radio options.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/radio_group\n"
    " import lustre/attribute\n"
    "\n"
    " fn notification_preference() {\n"
    "   radio_group.group(\"notifications\", [\n"
    "     radio_group.item(\"all\", \"All new messages\", False),\n"
    "     radio_group.item(\"direct\", \"Direct messages only\", True),\n"
    "     radio_group.item(\"none\", \"Nothing\", False),\n"
    "   ], [])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/radio_group.gleam", 54).
-spec item_(
    binary(),
    binary(),
    binary(),
    boolean(),
    list(lustre@vdom@vattr:attribute(SLQ))
) -> lustre@vdom@vnode:element(SLQ).
item_(Name, Value, Label_text, Checked, Attrs) ->
    Checked_attr = case Checked of
        true ->
            [lustre@attribute:checked(true)];

        false ->
            []
    end,
    lustre@element@html:label(
        [lustre@attribute:class(<<"label"/utf8>>)],
        [lustre@element@html:input(
                glaze@basecoat@internal@listx:append3(
                    [lustre@attribute:type_(<<"radio"/utf8>>),
                        lustre@attribute:name(Name),
                        lustre@attribute:value(Value),
                        lustre@attribute:class(<<"input"/utf8>>)],
                    Checked_attr,
                    Attrs
                )
            ),
            lustre@element@html:text(Label_text)]
    ).

-file("src/glaze/basecoat/radio_group.gleam", 29).
-spec group(
    binary(),
    list({binary(), binary(), boolean()}),
    list(lustre@vdom@vattr:attribute(SLI))
) -> lustre@vdom@vnode:element(SLI).
group(Name, Items, Attrs) ->
    Options = begin
        _pipe = Items,
        gleam@list:map(
            _pipe,
            fun(Item) ->
                {Value, Label, Checked} = Item,
                item_(Name, Value, Label, Checked, [])
            end
        )
    end,
    lustre@element@html:fieldset(
        [lustre@attribute:class(<<"grid gap-3"/utf8>>) | Attrs],
        Options
    ).

-file("src/glaze/basecoat/radio_group.gleam", 44).
-spec item(
    binary(),
    binary(),
    binary(),
    boolean(),
    list(lustre@vdom@vattr:attribute(SLM))
) -> lustre@vdom@vnode:element(SLM).
item(Name, Value, Label_text, Checked, Attrs) ->
    item_(Name, Value, Label_text, Checked, Attrs).

-file("src/glaze/basecoat/radio_group.gleam", 81).
-spec radio(binary(), binary(), list(lustre@vdom@vattr:attribute(SLU))) -> lustre@vdom@vnode:element(SLU).
radio(Name, Value, Attrs) ->
    lustre@element@html:input(
        [lustre@attribute:type_(<<"radio"/utf8>>),
            lustre@attribute:name(Name),
            lustre@attribute:value(Value),
            lustre@attribute:class(<<"input"/utf8>>) |
            Attrs]
    ).

-file("src/glaze/basecoat/radio_group.gleam", 95).
-spec checked() -> lustre@vdom@vattr:attribute(any()).
checked() ->
    lustre@attribute:checked(true).

-file("src/glaze/basecoat/radio_group.gleam", 99).
-spec disabled() -> lustre@vdom@vattr:attribute(any()).
disabled() ->
    lustre@attribute:disabled(true).

-file("src/glaze/basecoat/radio_group.gleam", 103).
-spec invalid() -> lustre@vdom@vattr:attribute(any()).
invalid() ->
    lustre@attribute:aria_invalid(<<"true"/utf8>>).
