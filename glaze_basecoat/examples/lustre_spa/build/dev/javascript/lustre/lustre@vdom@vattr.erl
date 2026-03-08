-module(lustre@vdom@vattr).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/vdom/vattr.gleam").
-export([merge/2, compare/2, prepare/1, attribute/2, to_string_tree/4, property/2, event/7, to_json/1]).
-export_type([attribute/1, handler/1, event_behaviour/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type attribute(PTO) :: {attribute, integer(), binary(), binary()} |
    {property, integer(), binary(), gleam@json:json()} |
    {event,
        integer(),
        binary(),
        gleam@dynamic@decode:decoder(handler(PTO)),
        list(binary()),
        event_behaviour(),
        event_behaviour(),
        integer(),
        integer()}.

-type handler(PTP) :: {handler, boolean(), boolean(), PTP}.

-type event_behaviour() :: {never, integer()} |
    {possible, integer()} |
    {always, integer()}.

-file("src/lustre/vdom/vattr.gleam", 105).
?DOC(false).
-spec merge(list(attribute(PUE)), list(attribute(PUE))) -> list(attribute(PUE)).
merge(Attributes, Merged) ->
    case Attributes of
        [] ->
            Merged;

        [{attribute, _, <<""/utf8>>, _} | Rest] ->
            merge(Rest, Merged);

        [{attribute, _, <<"class"/utf8>>, <<""/utf8>>} | Rest] ->
            merge(Rest, Merged);

        [{attribute, _, <<"style"/utf8>>, <<""/utf8>>} | Rest] ->
            merge(Rest, Merged);

        [{attribute, Kind, <<"class"/utf8>>, Class1},
            {attribute, _, <<"class"/utf8>>, Class2} |
            Rest@1] ->
            Value = <<<<Class1/binary, " "/utf8>>/binary, Class2/binary>>,
            Attribute = {attribute, Kind, <<"class"/utf8>>, Value},
            merge([Attribute | Rest@1], Merged);

        [{attribute, Kind@1, <<"style"/utf8>>, Style1},
            {attribute, _, <<"style"/utf8>>, Style2} |
            Rest@2] ->
            Value@1 = <<<<Style1/binary, ";"/utf8>>/binary, Style2/binary>>,
            Attribute@1 = {attribute, Kind@1, <<"style"/utf8>>, Value@1},
            merge([Attribute@1 | Rest@2], Merged);

        [Attribute@2 | Rest@3] ->
            merge(Rest@3, [Attribute@2 | Merged])
    end.

-file("src/lustre/vdom/vattr.gleam", 144).
?DOC(false).
-spec compare(attribute(PUL), attribute(PUL)) -> gleam@order:order().
compare(A, B) ->
    gleam@string:compare(erlang:element(3, A), erlang:element(3, B)).

-file("src/lustre/vdom/vattr.gleam", 91).
?DOC(false).
-spec prepare(list(attribute(PTZ))) -> list(attribute(PTZ)).
prepare(Attributes) ->
    case Attributes of
        [] ->
            Attributes;

        [_] ->
            Attributes;

        _ ->
            _pipe = Attributes,
            _pipe@1 = gleam@list:sort(_pipe, fun(A, B) -> compare(B, A) end),
            merge(_pipe@1, [])
    end.

-file("src/lustre/vdom/vattr.gleam", 176).
?DOC(false).
-spec attribute_to_json(integer(), binary(), binary()) -> gleam@json:json().
attribute_to_json(Kind, Name, Value) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"name"/utf8>>,
        Name
    ),
    _pipe@2 = lustre@internals@json_object_builder:string(
        _pipe@1,
        <<"value"/utf8>>,
        Value
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/vattr.gleam", 183).
?DOC(false).
-spec property_to_json(integer(), binary(), gleam@json:json()) -> gleam@json:json().
property_to_json(Kind, Name, Value) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"name"/utf8>>,
        Name
    ),
    _pipe@2 = lustre@internals@json_object_builder:json(
        _pipe@1,
        <<"value"/utf8>>,
        Value
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/vattr.gleam", 44).
?DOC(false).
-spec attribute(binary(), binary()) -> attribute(any()).
attribute(Name, Value) ->
    {attribute, 0, Name, Value}.

-file("src/lustre/vdom/vattr.gleam", 231).
?DOC(false).
-spec to_string_tree(binary(), binary(), binary(), list(attribute(any()))) -> gleam@string_tree:string_tree().
to_string_tree(Key, Namespace, Parent_namespace, Attributes) ->
    Attributes@1 = case Key /= <<""/utf8>> of
        true ->
            [attribute(<<"data-lustre-key"/utf8>>, Key) | Attributes];

        false ->
            Attributes
    end,
    Attributes@2 = case Namespace /= Parent_namespace of
        true when Namespace =:= <<""/utf8>> ->
            [attribute(
                    <<"xmlns"/utf8>>,
                    <<"http://www.w3.org/1999/xhtml"/utf8>>
                ) |
                Attributes@1];

        true ->
            [attribute(<<"xmlns"/utf8>>, Namespace) | Attributes@1];

        false ->
            Attributes@1
    end,
    gleam@list:fold(
        Attributes@2,
        gleam@string_tree:new(),
        fun(Html, Attr) -> case Attr of
                {attribute, _, <<"virtual:defaultValue"/utf8>>, Value} ->
                    gleam@string_tree:append(
                        Html,
                        <<<<" value=\""/utf8, (houdini:escape(Value))/binary>>/binary,
                            "\""/utf8>>
                    );

                {attribute, _, <<"virtual:defaultChecked"/utf8>>, _} ->
                    gleam@string_tree:append(Html, <<" checked"/utf8>>);

                {attribute, _, <<"virtual:defaultSelected"/utf8>>, _} ->
                    gleam@string_tree:append(Html, <<" selected"/utf8>>);

                {attribute, _, <<""/utf8>>, _} ->
                    Html;

                {attribute, _, Name, <<""/utf8>>} ->
                    gleam@string_tree:append(Html, <<" "/utf8, Name/binary>>);

                {attribute, _, Name@1, Value@1} ->
                    gleam@string_tree:append(
                        Html,
                        (<<<<<<<<" "/utf8, Name@1/binary>>/binary, "=\""/utf8>>/binary,
                                (houdini:escape(Value@1))/binary>>/binary,
                            "\""/utf8>>)
                    );

                _ ->
                    Html
            end end
    ).

-file("src/lustre/vdom/vattr.gleam", 50).
?DOC(false).
-spec property(binary(), gleam@json:json()) -> attribute(any()).
property(Name, Value) ->
    {property, 1, Name, Value}.

-file("src/lustre/vdom/vattr.gleam", 56).
?DOC(false).
-spec event(
    binary(),
    gleam@dynamic@decode:decoder(handler(PTU)),
    list(binary()),
    event_behaviour(),
    event_behaviour(),
    integer(),
    integer()
) -> attribute(PTU).
event(
    Name,
    Handler,
    Include,
    Prevent_default,
    Stop_propagation,
    Debounce,
    Throttle
) ->
    {event,
        2,
        Name,
        Handler,
        Include,
        Prevent_default,
        Stop_propagation,
        Debounce,
        Throttle}.

-file("src/lustre/vdom/vattr.gleam", 213).
?DOC(false).
-spec event_behaviour_to_json_builder(event_behaviour()) -> list({binary(),
    gleam@json:json()}).
event_behaviour_to_json_builder(Behaviour) ->
    case Behaviour of
        {never, Kind} ->
            lustre@internals@json_object_builder:tagged(Kind);

        {possible, _} ->
            lustre@internals@json_object_builder:tagged(0);

        {always, Kind@1} ->
            lustre@internals@json_object_builder:tagged(Kind@1)
    end.

-file("src/lustre/vdom/vattr.gleam", 190).
?DOC(false).
-spec event_to_json(
    integer(),
    binary(),
    list(binary()),
    event_behaviour(),
    event_behaviour(),
    integer(),
    integer()
) -> gleam@json:json().
event_to_json(
    Kind,
    Name,
    Include,
    Prevent_default,
    Stop_propagation,
    Debounce,
    Throttle
) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"name"/utf8>>,
        Name
    ),
    _pipe@2 = lustre@internals@json_object_builder:list(
        _pipe@1,
        <<"include"/utf8>>,
        Include,
        fun gleam@json:string/1
    ),
    _pipe@3 = lustre@internals@json_object_builder:object(
        _pipe@2,
        <<"prevent_default"/utf8>>,
        (event_behaviour_to_json_builder(Prevent_default))
    ),
    _pipe@4 = lustre@internals@json_object_builder:object(
        _pipe@3,
        <<"stop_propagation"/utf8>>,
        (event_behaviour_to_json_builder(Stop_propagation))
    ),
    _pipe@5 = lustre@internals@json_object_builder:int(
        _pipe@4,
        <<"debounce"/utf8>>,
        Debounce
    ),
    _pipe@6 = lustre@internals@json_object_builder:int(
        _pipe@5,
        <<"throttle"/utf8>>,
        Throttle
    ),
    lustre@internals@json_object_builder:build(_pipe@6).

-file("src/lustre/vdom/vattr.gleam", 150).
?DOC(false).
-spec to_json(attribute(any())) -> gleam@json:json().
to_json(Attribute) ->
    case Attribute of
        {attribute, Kind, Name, Value} ->
            attribute_to_json(Kind, Name, Value);

        {property, Kind@1, Name@1, Value@1} ->
            property_to_json(Kind@1, Name@1, Value@1);

        {event,
            Kind@2,
            Name@2,
            _,
            Include,
            Prevent_default,
            Stop_propagation,
            Debounce,
            Throttle} ->
            event_to_json(
                Kind@2,
                Name@2,
                Include,
                Prevent_default,
                Stop_propagation,
                Debounce,
                Throttle
            )
    end.
