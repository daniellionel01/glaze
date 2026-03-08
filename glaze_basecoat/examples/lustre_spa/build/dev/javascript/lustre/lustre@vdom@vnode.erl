-module(lustre@vdom@vnode).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/vdom/vnode.gleam").
-export([is_void_html_element/2, to_keyed/2, fragment/3, element/8, text/2, unsafe_inner_html/5, map/2, memo/3, to_snapshot/2, to_string_tree/2, to_string/1, to_json/2]).
-export_type([element/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type element(RCH) :: {fragment,
        integer(),
        binary(),
        list(element(RCH)),
        lustre@internals@mutable_map:mutable_map(binary(), element(RCH))} |
    {element,
        integer(),
        binary(),
        binary(),
        binary(),
        list(lustre@vdom@vattr:attribute(RCH)),
        list(element(RCH)),
        lustre@internals@mutable_map:mutable_map(binary(), element(RCH)),
        boolean(),
        boolean()} |
    {text, integer(), binary(), binary()} |
    {unsafe_inner_html,
        integer(),
        binary(),
        binary(),
        binary(),
        list(lustre@vdom@vattr:attribute(RCH)),
        binary()} |
    {map,
        integer(),
        binary(),
        fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
        element(RCH)} |
    {memo,
        integer(),
        binary(),
        list(lustre@internals@ref:ref()),
        fun(() -> element(RCH))}.

-file("src/lustre/vdom/vnode.gleam", 115).
?DOC(false).
-spec is_void_html_element(binary(), binary()) -> boolean().
is_void_html_element(Tag, Namespace) ->
    case Namespace of
        <<""/utf8>> ->
            case Tag of
                <<"area"/utf8>> ->
                    true;

                <<"base"/utf8>> ->
                    true;

                <<"br"/utf8>> ->
                    true;

                <<"col"/utf8>> ->
                    true;

                <<"embed"/utf8>> ->
                    true;

                <<"hr"/utf8>> ->
                    true;

                <<"img"/utf8>> ->
                    true;

                <<"input"/utf8>> ->
                    true;

                <<"link"/utf8>> ->
                    true;

                <<"meta"/utf8>> ->
                    true;

                <<"param"/utf8>> ->
                    true;

                <<"source"/utf8>> ->
                    true;

                <<"track"/utf8>> ->
                    true;

                <<"wbr"/utf8>> ->
                    true;

                _ ->
                    false
            end;

        _ ->
            false
    end.

-file("src/lustre/vdom/vnode.gleam", 201).
?DOC(false).
-spec to_keyed(binary(), element(RDV)) -> element(RDV).
to_keyed(Key, Node) ->
    case Node of
        {element, _, _, _, _, _, _, _, _, _} ->
            {element,
                erlang:element(2, Node),
                Key,
                erlang:element(4, Node),
                erlang:element(5, Node),
                erlang:element(6, Node),
                erlang:element(7, Node),
                erlang:element(8, Node),
                erlang:element(9, Node),
                erlang:element(10, Node)};

        {text, _, _, _} ->
            {text, erlang:element(2, Node), Key, erlang:element(4, Node)};

        {unsafe_inner_html, _, _, _, _, _, _} ->
            {unsafe_inner_html,
                erlang:element(2, Node),
                Key,
                erlang:element(4, Node),
                erlang:element(5, Node),
                erlang:element(6, Node),
                erlang:element(7, Node)};

        {fragment, _, _, _, _} ->
            {fragment,
                erlang:element(2, Node),
                Key,
                erlang:element(4, Node),
                erlang:element(5, Node)};

        {memo, _, _, _, View} ->
            {memo,
                erlang:element(2, Node),
                Key,
                erlang:element(4, Node),
                fun() -> to_keyed(Key, View()) end};

        {map, _, _, _, Child} ->
            {map,
                erlang:element(2, Node),
                Key,
                erlang:element(4, Node),
                to_keyed(Key, Child)}
    end.

-file("src/lustre/vdom/vnode.gleam", 255).
?DOC(false).
-spec text_to_json(integer(), binary(), binary()) -> gleam@json:json().
text_to_json(Kind, Key, Content) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"key"/utf8>>,
        Key
    ),
    _pipe@2 = lustre@internals@json_object_builder:string(
        _pipe@1,
        <<"content"/utf8>>,
        Content
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/vnode.gleam", 262).
?DOC(false).
-spec unsafe_inner_html_to_json(
    integer(),
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(any())),
    binary()
) -> gleam@json:json().
unsafe_inner_html_to_json(Kind, Key, Namespace, Tag, Attributes, Inner_html) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"key"/utf8>>,
        Key
    ),
    _pipe@2 = lustre@internals@json_object_builder:string(
        _pipe@1,
        <<"namespace"/utf8>>,
        Namespace
    ),
    _pipe@3 = lustre@internals@json_object_builder:string(
        _pipe@2,
        <<"tag"/utf8>>,
        Tag
    ),
    _pipe@4 = lustre@internals@json_object_builder:list(
        _pipe@3,
        <<"attributes"/utf8>>,
        Attributes,
        fun lustre@vdom@vattr:to_json/1
    ),
    _pipe@5 = lustre@internals@json_object_builder:string(
        _pipe@4,
        <<"inner_html"/utf8>>,
        Inner_html
    ),
    lustre@internals@json_object_builder:build(_pipe@5).

-file("src/lustre/vdom/vnode.gleam", 570).
?DOC(false).
-spec marker_comment(binary(), binary()) -> gleam@string_tree:string_tree().
marker_comment(Label, Key) ->
    case Key of
        <<""/utf8>> ->
            gleam_stdlib:identity(
                <<<<"<!-- "/utf8, Label/binary>>/binary, " -->"/utf8>>
            );

        _ ->
            _pipe = gleam_stdlib:identity(
                <<<<"<!-- "/utf8, Label/binary>>/binary, " key=\""/utf8>>
            ),
            _pipe@1 = gleam@string_tree:append(_pipe, houdini:escape(Key)),
            gleam@string_tree:append(_pipe@1, <<"\" -->"/utf8>>)
    end.

-file("src/lustre/vdom/vnode.gleam", 82).
?DOC(false).
-spec fragment(
    binary(),
    list(element(RCP)),
    lustre@internals@mutable_map:mutable_map(binary(), element(RCP))
) -> element(RCP).
fragment(Key, Children, Keyed_children) ->
    {fragment, 0, Key, Children, Keyed_children}.

-file("src/lustre/vdom/vnode.gleam", 92).
?DOC(false).
-spec element(
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RCW)),
    list(element(RCW)),
    lustre@internals@mutable_map:mutable_map(binary(), element(RCW)),
    boolean(),
    boolean()
) -> element(RCW).
element(
    Key,
    Namespace,
    Tag,
    Attributes,
    Children,
    Keyed_children,
    Self_closing,
    Void
) ->
    {element,
        1,
        Key,
        Namespace,
        Tag,
        lustre@vdom@vattr:prepare(Attributes),
        Children,
        Keyed_children,
        Self_closing,
        Void}.

-file("src/lustre/vdom/vnode.gleam", 141).
?DOC(false).
-spec text(binary(), binary()) -> element(any()).
text(Key, Content) ->
    {text, 2, Key, Content}.

-file("src/lustre/vdom/vnode.gleam", 147).
?DOC(false).
-spec unsafe_inner_html(
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RDH)),
    binary()
) -> element(RDH).
unsafe_inner_html(Key, Namespace, Tag, Attributes, Inner_html) ->
    {unsafe_inner_html,
        3,
        Key,
        Namespace,
        Tag,
        lustre@vdom@vattr:prepare(Attributes),
        Inner_html}.

-file("src/lustre/vdom/vnode.gleam", 166).
?DOC(false).
-spec map(element(RDL), fun((RDL) -> RDN)) -> element(RDN).
map(Element, Mapper) ->
    case Element of
        {map, _, _, Child_mapper, _} ->
            {map,
                4,
                erlang:element(3, Element),
                fun(Handler) ->
                    (gleam@function:identity(Mapper))(Child_mapper(Handler))
                end,
                gleam@function:identity(erlang:element(5, Element))};

        _ ->
            {map,
                4,
                erlang:element(3, Element),
                gleam@function:identity(Mapper),
                gleam@function:identity(Element)}
    end.

-file("src/lustre/vdom/vnode.gleam", 187).
?DOC(false).
-spec memo(binary(), list(lustre@internals@ref:ref()), fun(() -> element(RDQ))) -> element(RDQ).
memo(Key, Dependencies, View) ->
    {memo, 5, Key, Dependencies, View}.

-file("src/lustre/vdom/vnode.gleam", 534).
?DOC(false).
-spec children_to_snapshot_builder(
    gleam@string_tree:string_tree(),
    list(element(any())),
    boolean(),
    boolean(),
    binary(),
    integer()
) -> gleam@string_tree:string_tree().
children_to_snapshot_builder(Html, Children, Raw, Debug, Namespace, Indent) ->
    case Children of
        [{text, _, _, A}, {text, _, _, B} | Rest] ->
            children_to_snapshot_builder(
                Html,
                [{text, 2, <<""/utf8>>, <<A/binary, B/binary>>} | Rest],
                Raw,
                Debug,
                Namespace,
                Indent
            );

        [Child | Rest@1] ->
            _pipe = Child,
            _pipe@1 = do_to_snapshot_builder(
                _pipe,
                Raw,
                Debug,
                Namespace,
                Indent
            ),
            _pipe@2 = gleam@string_tree:append(_pipe@1, <<"\n"/utf8>>),
            _pipe@3 = gleam@string_tree:prepend_tree(_pipe@2, Html),
            children_to_snapshot_builder(
                _pipe@3,
                Rest@1,
                Raw,
                Debug,
                Namespace,
                Indent
            );

        [] ->
            Html
    end.

-file("src/lustre/vdom/vnode.gleam", 382).
?DOC(false).
-spec do_to_snapshot_builder(
    element(any()),
    boolean(),
    boolean(),
    binary(),
    integer()
) -> gleam@string_tree:string_tree().
do_to_snapshot_builder(Node, Raw, Debug, Parent_namespace, Indent) ->
    Spaces = gleam@string:repeat(<<"  "/utf8>>, Indent),
    case Node of
        {text, _, _, <<""/utf8>>} ->
            gleam@string_tree:new();

        {text, _, _, Content} when Raw ->
            gleam_stdlib:identity([Spaces, Content]);

        {text, _, _, Content@1} ->
            gleam_stdlib:identity([Spaces, houdini:escape(Content@1)]);

        {element, _, Key, Namespace, Tag, Attributes, _, _, true, _} ->
            Html = gleam_stdlib:identity(<<"<"/utf8, Tag/binary>>),
            Attributes@1 = lustre@vdom@vattr:to_string_tree(
                Key,
                Namespace,
                Parent_namespace,
                Attributes
            ),
            _pipe = Html,
            _pipe@1 = gleam@string_tree:prepend(_pipe, Spaces),
            _pipe@2 = gleam_stdlib:iodata_append(_pipe@1, Attributes@1),
            gleam@string_tree:append(_pipe@2, <<"/>"/utf8>>);

        {element, _, Key@1, Namespace@1, Tag@1, Attributes@2, _, _, _, true} ->
            Html@1 = gleam_stdlib:identity(<<"<"/utf8, Tag@1/binary>>),
            Attributes@3 = lustre@vdom@vattr:to_string_tree(
                Key@1,
                Namespace@1,
                Parent_namespace,
                Attributes@2
            ),
            _pipe@3 = Html@1,
            _pipe@4 = gleam@string_tree:prepend(_pipe@3, Spaces),
            _pipe@5 = gleam_stdlib:iodata_append(_pipe@4, Attributes@3),
            gleam@string_tree:append(_pipe@5, <<">"/utf8>>);

        {element, _, Key@2, Namespace@2, Tag@2, Attributes@4, [], _, _, _} ->
            Html@2 = gleam_stdlib:identity(<<"<"/utf8, Tag@2/binary>>),
            Attributes@5 = lustre@vdom@vattr:to_string_tree(
                Key@2,
                Namespace@2,
                Parent_namespace,
                Attributes@4
            ),
            _pipe@6 = Html@2,
            _pipe@7 = gleam@string_tree:prepend(_pipe@6, Spaces),
            _pipe@8 = gleam_stdlib:iodata_append(_pipe@7, Attributes@5),
            _pipe@9 = gleam@string_tree:append(_pipe@8, <<">"/utf8>>),
            gleam@string_tree:append(
                _pipe@9,
                <<<<"</"/utf8, Tag@2/binary>>/binary, ">"/utf8>>
            );

        {element, _, Key@3, Namespace@3, Tag@3, Attributes@6, Children, _, _, _} ->
            Html@3 = gleam_stdlib:identity(<<"<"/utf8, Tag@3/binary>>),
            Attributes@7 = lustre@vdom@vattr:to_string_tree(
                Key@3,
                Namespace@3,
                Parent_namespace,
                Attributes@6
            ),
            _pipe@10 = Html@3,
            _pipe@11 = gleam@string_tree:prepend(_pipe@10, Spaces),
            _pipe@12 = gleam_stdlib:iodata_append(_pipe@11, Attributes@7),
            _pipe@13 = gleam@string_tree:append(_pipe@12, <<">\n"/utf8>>),
            _pipe@14 = children_to_snapshot_builder(
                _pipe@13,
                Children,
                Raw,
                Debug,
                Namespace@3,
                Indent + 1
            ),
            _pipe@15 = gleam@string_tree:append(_pipe@14, Spaces),
            gleam@string_tree:append(
                _pipe@15,
                <<<<"</"/utf8, Tag@3/binary>>/binary, ">"/utf8>>
            );

        {unsafe_inner_html,
            _,
            Key@4,
            Namespace@4,
            Tag@4,
            Attributes@8,
            Inner_html} ->
            Html@4 = gleam_stdlib:identity(<<"<"/utf8, Tag@4/binary>>),
            Attributes@9 = lustre@vdom@vattr:to_string_tree(
                Key@4,
                Namespace@4,
                Parent_namespace,
                Attributes@8
            ),
            _pipe@16 = Html@4,
            _pipe@17 = gleam@string_tree:prepend(_pipe@16, Spaces),
            _pipe@18 = gleam_stdlib:iodata_append(_pipe@17, Attributes@9),
            _pipe@19 = gleam@string_tree:append(_pipe@18, <<">"/utf8>>),
            _pipe@20 = gleam@string_tree:append(_pipe@19, Inner_html),
            gleam@string_tree:append(
                _pipe@20,
                <<<<"</"/utf8, Tag@4/binary>>/binary, ">"/utf8>>
            );

        {fragment, _, Key@5, Children@1, _} when Debug ->
            _pipe@21 = marker_comment(<<"lustre:fragment"/utf8>>, Key@5),
            _pipe@22 = gleam@string_tree:prepend(_pipe@21, Spaces),
            _pipe@23 = gleam@string_tree:append(_pipe@22, <<"\n"/utf8>>),
            _pipe@24 = children_to_snapshot_builder(
                _pipe@23,
                Children@1,
                Raw,
                Debug,
                Parent_namespace,
                Indent + 1
            ),
            _pipe@25 = gleam@string_tree:append(_pipe@24, Spaces),
            gleam_stdlib:iodata_append(
                _pipe@25,
                marker_comment(<<"/lustre:fragment"/utf8>>, <<""/utf8>>)
            );

        {fragment, _, _, Children@2, _} ->
            children_to_snapshot_builder(
                gleam@string_tree:new(),
                Children@2,
                Raw,
                Debug,
                Parent_namespace,
                Indent
            );

        {map, _, Key@6, _, Child} when Debug ->
            _pipe@26 = marker_comment(<<"lustre:map"/utf8>>, Key@6),
            _pipe@27 = gleam@string_tree:prepend(_pipe@26, Spaces),
            _pipe@28 = gleam@string_tree:append(_pipe@27, <<"\n"/utf8>>),
            gleam_stdlib:iodata_append(
                _pipe@28,
                do_to_snapshot_builder(
                    Child,
                    Raw,
                    Debug,
                    Parent_namespace,
                    Indent + 1
                )
            );

        {map, _, _, _, Child@1} ->
            do_to_snapshot_builder(
                Child@1,
                Raw,
                Debug,
                Parent_namespace,
                Indent
            );

        {memo, _, Key@7, _, View} when Debug ->
            _pipe@29 = marker_comment(<<"lustre:memo"/utf8>>, Key@7),
            _pipe@30 = gleam@string_tree:prepend(_pipe@29, Spaces),
            _pipe@31 = gleam@string_tree:append(_pipe@30, <<"\n"/utf8>>),
            gleam_stdlib:iodata_append(
                _pipe@31,
                do_to_snapshot_builder(
                    View(),
                    Raw,
                    Debug,
                    Parent_namespace,
                    Indent + 1
                )
            );

        {memo, _, _, _, View@1} ->
            do_to_snapshot_builder(
                View@1(),
                Raw,
                Debug,
                Parent_namespace,
                Indent
            )
    end.

-file("src/lustre/vdom/vnode.gleam", 377).
?DOC(false).
-spec to_snapshot(element(any()), boolean()) -> binary().
to_snapshot(Node, Debug) ->
    _pipe = do_to_snapshot_builder(Node, false, Debug, <<""/utf8>>, 0),
    unicode:characters_to_binary(_pipe).

-file("src/lustre/vdom/vnode.gleam", 368).
?DOC(false).
-spec children_to_string_tree(
    gleam@string_tree:string_tree(),
    list(element(any())),
    binary()
) -> gleam@string_tree:string_tree().
children_to_string_tree(Html, Children, Namespace) ->
    gleam@list:fold(
        Children,
        Html,
        fun(Html@1, Child) ->
            gleam_stdlib:iodata_append(Html@1, to_string_tree(Child, Namespace))
        end
    ).

-file("src/lustre/vdom/vnode.gleam", 296).
?DOC(false).
-spec to_string_tree(element(any()), binary()) -> gleam@string_tree:string_tree().
to_string_tree(Node, Parent_namespace) ->
    case Node of
        {text, _, _, <<""/utf8>>} ->
            gleam@string_tree:new();

        {text, _, _, Content} ->
            gleam_stdlib:identity(houdini:escape(Content));

        {element, _, Key, Namespace, Tag, Attributes, _, _, Self_closing, _} when Self_closing ->
            Html = gleam_stdlib:identity(<<"<"/utf8, Tag/binary>>),
            Attributes@1 = lustre@vdom@vattr:to_string_tree(
                Key,
                Namespace,
                Parent_namespace,
                Attributes
            ),
            _pipe = Html,
            _pipe@1 = gleam_stdlib:iodata_append(_pipe, Attributes@1),
            gleam@string_tree:append(_pipe@1, <<"/>"/utf8>>);

        {element, _, Key@1, Namespace@1, Tag@1, Attributes@2, _, _, _, Void} when Void ->
            Html@1 = gleam_stdlib:identity(<<"<"/utf8, Tag@1/binary>>),
            Attributes@3 = lustre@vdom@vattr:to_string_tree(
                Key@1,
                Namespace@1,
                Parent_namespace,
                Attributes@2
            ),
            _pipe@2 = Html@1,
            _pipe@3 = gleam_stdlib:iodata_append(_pipe@2, Attributes@3),
            gleam@string_tree:append(_pipe@3, <<">"/utf8>>);

        {element, _, Key@2, Namespace@2, Tag@2, Attributes@4, Children, _, _, _} ->
            Html@2 = gleam_stdlib:identity(<<"<"/utf8, Tag@2/binary>>),
            Attributes@5 = lustre@vdom@vattr:to_string_tree(
                Key@2,
                Namespace@2,
                Parent_namespace,
                Attributes@4
            ),
            _pipe@4 = Html@2,
            _pipe@5 = gleam_stdlib:iodata_append(_pipe@4, Attributes@5),
            _pipe@6 = gleam@string_tree:append(_pipe@5, <<">"/utf8>>),
            _pipe@7 = children_to_string_tree(_pipe@6, Children, Namespace@2),
            gleam@string_tree:append(
                _pipe@7,
                <<<<"</"/utf8, Tag@2/binary>>/binary, ">"/utf8>>
            );

        {unsafe_inner_html,
            _,
            Key@3,
            Namespace@3,
            Tag@3,
            Attributes@6,
            Inner_html} ->
            Html@3 = gleam_stdlib:identity(<<"<"/utf8, Tag@3/binary>>),
            Attributes@7 = lustre@vdom@vattr:to_string_tree(
                Key@3,
                Namespace@3,
                Parent_namespace,
                Attributes@6
            ),
            _pipe@8 = Html@3,
            _pipe@9 = gleam_stdlib:iodata_append(_pipe@8, Attributes@7),
            _pipe@10 = gleam@string_tree:append(_pipe@9, <<">"/utf8>>),
            _pipe@11 = gleam@string_tree:append(_pipe@10, Inner_html),
            gleam@string_tree:append(
                _pipe@11,
                <<<<"</"/utf8, Tag@3/binary>>/binary, ">"/utf8>>
            );

        {fragment, _, Key@4, Children@1, _} ->
            _pipe@12 = marker_comment(<<"lustre:fragment"/utf8>>, Key@4),
            _pipe@13 = children_to_string_tree(
                _pipe@12,
                Children@1,
                Parent_namespace
            ),
            gleam_stdlib:iodata_append(
                _pipe@13,
                marker_comment(<<"/lustre:fragment"/utf8>>, <<""/utf8>>)
            );

        {map, _, Key@5, _, Child} ->
            _pipe@14 = marker_comment(<<"lustre:map"/utf8>>, Key@5),
            gleam_stdlib:iodata_append(
                _pipe@14,
                to_string_tree(Child, Parent_namespace)
            );

        {memo, _, Key@6, _, View} ->
            _pipe@15 = marker_comment(<<"lustre:memo"/utf8>>, Key@6),
            gleam_stdlib:iodata_append(
                _pipe@15,
                to_string_tree(View(), Parent_namespace)
            )
    end.

-file("src/lustre/vdom/vnode.gleam", 290).
?DOC(false).
-spec to_string(element(any())) -> binary().
to_string(Node) ->
    _pipe = Node,
    _pipe@1 = to_string_tree(_pipe, <<""/utf8>>),
    unicode:characters_to_binary(_pipe@1).

-file("src/lustre/vdom/vnode.gleam", 238).
?DOC(false).
-spec fragment_to_json(
    integer(),
    binary(),
    list(element(RDY)),
    lustre@internals@mutable_map:mutable_map(fun(() -> element(RDY)), element(RDY))
) -> gleam@json:json().
fragment_to_json(Kind, Key, Children, Memos) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"key"/utf8>>,
        Key
    ),
    _pipe@2 = lustre@internals@json_object_builder:list(
        _pipe@1,
        <<"children"/utf8>>,
        Children,
        fun(_capture) -> to_json(_capture, Memos) end
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/vnode.gleam", 217).
?DOC(false).
-spec to_json(
    element(RDY),
    lustre@internals@mutable_map:mutable_map(fun(() -> element(RDY)), element(RDY))
) -> gleam@json:json().
to_json(Node, Memos) ->
    case Node of
        {fragment, Kind, Key, Children, _} ->
            fragment_to_json(Kind, Key, Children, Memos);

        {element,
            Kind@1,
            Key@1,
            Namespace,
            Tag,
            Attributes,
            Children@1,
            _,
            _,
            _} ->
            element_to_json(
                Kind@1,
                Key@1,
                Namespace,
                Tag,
                Attributes,
                Children@1,
                Memos
            );

        {text, Kind@2, Key@2, Content} ->
            text_to_json(Kind@2, Key@2, Content);

        {unsafe_inner_html,
            Kind@3,
            Key@3,
            Namespace@1,
            Tag@1,
            Attributes@1,
            Inner_html} ->
            unsafe_inner_html_to_json(
                Kind@3,
                Key@3,
                Namespace@1,
                Tag@1,
                Attributes@1,
                Inner_html
            );

        {map, Kind@4, Key@4, _, Child} ->
            map_to_json(Kind@4, Key@4, Child, Memos);

        {memo, _, _, _, View} ->
            memo_to_json(View, Memos)
    end.

-file("src/lustre/vdom/vnode.gleam", 245).
?DOC(false).
-spec element_to_json(
    integer(),
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RDY)),
    list(element(RDY)),
    lustre@internals@mutable_map:mutable_map(fun(() -> element(RDY)), element(RDY))
) -> gleam@json:json().
element_to_json(Kind, Key, Namespace, Tag, Attributes, Children, Memos) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"key"/utf8>>,
        Key
    ),
    _pipe@2 = lustre@internals@json_object_builder:string(
        _pipe@1,
        <<"namespace"/utf8>>,
        Namespace
    ),
    _pipe@3 = lustre@internals@json_object_builder:string(
        _pipe@2,
        <<"tag"/utf8>>,
        Tag
    ),
    _pipe@4 = lustre@internals@json_object_builder:list(
        _pipe@3,
        <<"attributes"/utf8>>,
        Attributes,
        fun lustre@vdom@vattr:to_json/1
    ),
    _pipe@5 = lustre@internals@json_object_builder:list(
        _pipe@4,
        <<"children"/utf8>>,
        Children,
        fun(_capture) -> to_json(_capture, Memos) end
    ),
    lustre@internals@json_object_builder:build(_pipe@5).

-file("src/lustre/vdom/vnode.gleam", 272).
?DOC(false).
-spec memo_to_json(
    fun(() -> element(RDY)),
    lustre@internals@mutable_map:mutable_map(fun(() -> element(RDY)), element(RDY))
) -> gleam@json:json().
memo_to_json(View, Memos) ->
    Child = lustre@internals@mutable_map:get_or_compute(Memos, View, View),
    to_json(Child, Memos).

-file("src/lustre/vdom/vnode.gleam", 279).
?DOC(false).
-spec map_to_json(
    integer(),
    binary(),
    element(RDY),
    lustre@internals@mutable_map:mutable_map(fun(() -> element(RDY)), element(RDY))
) -> gleam@json:json().
map_to_json(Kind, Key, Child, Memos) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"key"/utf8>>,
        Key
    ),
    _pipe@2 = lustre@internals@json_object_builder:json(
        _pipe@1,
        <<"child"/utf8>>,
        to_json(Child, Memos)
    ),
    lustre@internals@json_object_builder:build(_pipe@2).
