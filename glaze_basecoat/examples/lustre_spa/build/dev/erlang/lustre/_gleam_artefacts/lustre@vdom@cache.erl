-module(lustre@vdom@cache).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/vdom/cache.gleam").
-export([compose_mapper/2, new_events/0, new/0, tick/1, events/1, update_events/2, memos/1, get_old_memo/3, keep_memo/3, add_memo/3, get_subtree/3, update_subtree/4, add_event/4, remove_event/3, add_children/5, add_child/5, from_node/1, remove_child/5, replace_child/6, dispatch/2, has_dispatched_events/2, decode/4, handle/4]).
-export_type([cache/1, events/1, child/1, added_children/1, decoded_event/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-opaque cache(JQX) :: {cache,
        events(JQX),
        lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(JQX)), lustre@vdom@vnode:element(JQX)),
        lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(JQX)), lustre@vdom@vnode:element(JQX)),
        list(binary()),
        list(binary())}.

-opaque events(JQY) :: {events,
        lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JQY))),
        lustre@internals@mutable_map:mutable_map(binary(), child(JQY))}.

-type child(JQZ) :: {child,
        fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
        events(JQZ)}.

-type added_children(JRA) :: {added_children,
        lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JRA))),
        lustre@internals@mutable_map:mutable_map(binary(), child(JRA)),
        lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(JRA)), lustre@vdom@vnode:element(JRA))}.

-opaque decoded_event(JRB) :: {decoded_event,
        binary(),
        lustre@vdom@vattr:handler(JRB)} |
    {dispatched_event, binary()}.

-file("src/lustre/vdom/cache.gleam", 64).
?DOC(false).
-spec compose_mapper(
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_())
) -> fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()).
compose_mapper(Mapper, Child_mapper) ->
    fun(Msg) -> Mapper(Child_mapper(Msg)) end.

-file("src/lustre/vdom/cache.gleam", 82).
?DOC(false).
-spec new_events() -> events(any()).
new_events() ->
    {events, maps:new(), maps:new()}.

-file("src/lustre/vdom/cache.gleam", 72).
?DOC(false).
-spec new() -> cache(any()).
new() ->
    {cache, new_events(), maps:new(), maps:new(), [], []}.

-file("src/lustre/vdom/cache.gleam", 92).
?DOC(false).
-spec tick(cache(JRJ)) -> cache(JRJ).
tick(Cache) ->
    {cache,
        erlang:element(2, Cache),
        maps:new(),
        erlang:element(3, Cache),
        erlang:element(6, Cache),
        []}.

-file("src/lustre/vdom/cache.gleam", 102).
?DOC(false).
-spec events(cache(JRM)) -> events(JRM).
events(Cache) ->
    erlang:element(2, Cache).

-file("src/lustre/vdom/cache.gleam", 106).
?DOC(false).
-spec update_events(cache(JRP), events(JRP)) -> cache(JRP).
update_events(Cache, Events) ->
    {cache,
        Events,
        erlang:element(3, Cache),
        erlang:element(4, Cache),
        erlang:element(5, Cache),
        erlang:element(6, Cache)}.

-file("src/lustre/vdom/cache.gleam", 114).
?DOC(false).
-spec memos(cache(JRT)) -> lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(JRT)), lustre@vdom@vnode:element(JRT)).
memos(Cache) ->
    erlang:element(3, Cache).

-file("src/lustre/vdom/cache.gleam", 120).
?DOC(false).
-spec get_old_memo(
    cache(JRW),
    fun(() -> lustre@vdom@vnode:element(JRW)),
    fun(() -> lustre@vdom@vnode:element(JRW))
) -> lustre@vdom@vnode:element(JRW).
get_old_memo(Cache, Old, New) ->
    lustre@internals@mutable_map:get_or_compute(
        erlang:element(4, Cache),
        Old,
        New
    ).

-file("src/lustre/vdom/cache.gleam", 129).
?DOC(false).
-spec keep_memo(
    cache(JSB),
    fun(() -> lustre@vdom@vnode:element(JSB)),
    fun(() -> lustre@vdom@vnode:element(JSB))
) -> cache(JSB).
keep_memo(Cache, Old, New) ->
    Node = lustre@internals@mutable_map:get_or_compute(
        erlang:element(4, Cache),
        Old,
        New
    ),
    Vdoms = lustre@internals@mutable_map:insert(
        erlang:element(3, Cache),
        New,
        Node
    ),
    {cache,
        erlang:element(2, Cache),
        Vdoms,
        erlang:element(4, Cache),
        erlang:element(5, Cache),
        erlang:element(6, Cache)}.

-file("src/lustre/vdom/cache.gleam", 136).
?DOC(false).
-spec add_memo(
    cache(JSG),
    fun(() -> lustre@vdom@vnode:element(JSG)),
    lustre@vdom@vnode:element(JSG)
) -> cache(JSG).
add_memo(Cache, New, Node) ->
    Vdoms = lustre@internals@mutable_map:insert(
        erlang:element(3, Cache),
        New,
        Node
    ),
    {cache,
        erlang:element(2, Cache),
        Vdoms,
        erlang:element(4, Cache),
        erlang:element(5, Cache),
        erlang:element(6, Cache)}.

-file("src/lustre/vdom/cache.gleam", 146).
?DOC(false).
-spec get_subtree(
    events(JSL),
    binary(),
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_())
) -> events(JSL).
get_subtree(Events, Path, Old_mapper) ->
    Child = lustre@internals@mutable_map:get_or_compute(
        erlang:element(3, Events),
        Path,
        fun() -> {child, Old_mapper, new_events()} end
    ),
    erlang:element(3, Child).

-file("src/lustre/vdom/cache.gleam", 160).
?DOC(false).
-spec update_subtree(
    events(JSO),
    binary(),
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
    events(JSO)
) -> events(JSO).
update_subtree(Parent, Path, Mapper, Events) ->
    New_child = {child, Mapper, Events},
    Children = lustre@internals@mutable_map:insert(
        erlang:element(3, Parent),
        Path,
        New_child
    ),
    {events, erlang:element(2, Parent), Children}.

-file("src/lustre/vdom/cache.gleam", 183).
?DOC(false).
-spec do_add_event(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JSX))),
    lustre@vdom@path:path(),
    binary(),
    gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JSX))
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JSX))).
do_add_event(Handlers, Path, Name, Handler) ->
    lustre@internals@mutable_map:insert(
        Handlers,
        lustre@vdom@path:event(Path, Name),
        Handler
    ).

-file("src/lustre/vdom/cache.gleam", 173).
?DOC(false).
-spec add_event(
    events(JSS),
    lustre@vdom@path:path(),
    binary(),
    gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JSS))
) -> events(JSS).
add_event(Events, Path, Name, Handler) ->
    Handlers = do_add_event(erlang:element(2, Events), Path, Name, Handler),
    {events, Handlers, erlang:element(3, Events)}.

-file("src/lustre/vdom/cache.gleam", 201).
?DOC(false).
-spec do_remove_event(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JTL))),
    lustre@vdom@path:path(),
    binary()
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JTL))).
do_remove_event(Handlers, Path, Name) ->
    lustre@internals@mutable_map:delete(
        Handlers,
        lustre@vdom@path:event(Path, Name)
    ).

-file("src/lustre/vdom/cache.gleam", 192).
?DOC(false).
-spec remove_event(events(JTI), lustre@vdom@path:path(), binary()) -> events(JTI).
remove_event(Events, Path, Name) ->
    Handlers = do_remove_event(erlang:element(2, Events), Path, Name),
    {events, Handlers, erlang:element(3, Events)}.

-file("src/lustre/vdom/cache.gleam", 220).
?DOC(false).
-spec add_attributes(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JUA))),
    lustre@vdom@path:path(),
    list(lustre@vdom@vattr:attribute(JUA))
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JUA))).
add_attributes(Handlers, Path, Attributes) ->
    gleam@list:fold(
        Attributes,
        Handlers,
        fun(Events, Attribute) -> case Attribute of
                {event, _, Name, Handler, _, _, _, _, _} ->
                    do_add_event(Events, Path, Name, Handler);

                _ ->
                    Events
            end end
    ).

-file("src/lustre/vdom/cache.gleam", 256).
?DOC(false).
-spec do_add_children(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JUS))),
    lustre@internals@mutable_map:mutable_map(binary(), child(JUS)),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(JUS)), lustre@vdom@vnode:element(JUS)),
    lustre@vdom@path:path(),
    integer(),
    list(lustre@vdom@vnode:element(JUS))
) -> added_children(JUS).
do_add_children(Handlers, Children, Vdoms, Parent, Child_index, Nodes) ->
    Next = Child_index + 1,
    case Nodes of
        [] ->
            {added_children, Handlers, Children, Vdoms};

        [{element, _, Key, _, _, Attributes, Nodes@1, _, _, _} | Rest] ->
            Path = lustre@vdom@path:add(Parent, Child_index, Key),
            Handlers@1 = add_attributes(Handlers, Path, Attributes),
            {added_children, Handlers@2, Children@1, Vdoms@1} = do_add_children(
                Handlers@1,
                Children,
                Vdoms,
                Path,
                0,
                Nodes@1
            ),
            do_add_children(Handlers@2, Children@1, Vdoms@1, Parent, Next, Rest);

        [{fragment, _, Key@1, Nodes@2, _} | Rest@1] ->
            Path@1 = lustre@vdom@path:add(Parent, Child_index, Key@1),
            {added_children, Handlers@3, Children@2, Vdoms@2} = do_add_children(
                Handlers,
                Children,
                Vdoms,
                Path@1,
                0,
                Nodes@2
            ),
            do_add_children(
                Handlers@3,
                Children@2,
                Vdoms@2,
                Parent,
                Next,
                Rest@1
            );

        [{unsafe_inner_html, _, Key@2, _, _, Attributes@1, _} | Rest@2] ->
            Path@2 = lustre@vdom@path:add(Parent, Child_index, Key@2),
            Handlers@4 = add_attributes(Handlers, Path@2, Attributes@1),
            do_add_children(Handlers@4, Children, Vdoms, Parent, Next, Rest@2);

        [{map, _, Key@3, Mapper, Child} | Rest@3] ->
            Path@3 = lustre@vdom@path:add(Parent, Child_index, Key@3),
            Added = do_add_children(
                maps:new(),
                maps:new(),
                Vdoms,
                lustre@vdom@path:subtree(Path@3),
                0,
                [Child | []]
            ),
            Vdoms@3 = erlang:element(4, Added),
            Child_events = {events,
                erlang:element(2, Added),
                erlang:element(3, Added)},
            Child@1 = {child, Mapper, Child_events},
            Children@3 = lustre@internals@mutable_map:insert(
                Children,
                lustre@vdom@path:child(Path@3),
                Child@1
            ),
            do_add_children(Handlers, Children@3, Vdoms@3, Parent, Next, Rest@3);

        [{memo, _, _, _, View} | Rest@4] ->
            Child_node = View(),
            Vdoms@4 = lustre@internals@mutable_map:insert(
                Vdoms,
                View,
                Child_node
            ),
            Next@1 = Child_index,
            Rest@5 = [Child_node | Rest@4],
            do_add_children(Handlers, Children, Vdoms@4, Parent, Next@1, Rest@5);

        [{text, _, _, _} | Rest@6] ->
            do_add_children(Handlers, Children, Vdoms, Parent, Next, Rest@6)
    end.

-file("src/lustre/vdom/cache.gleam", 242).
?DOC(false).
-spec add_children(
    cache(JUL),
    events(JUL),
    lustre@vdom@path:path(),
    integer(),
    list(lustre@vdom@vnode:element(JUL))
) -> {cache(JUL), events(JUL)}.
add_children(Cache, Events, Path, Child_index, Nodes) ->
    Vdoms = erlang:element(3, Cache),
    {events, Handlers, Children} = Events,
    {added_children, Handlers@1, Children@1, Vdoms@1} = do_add_children(
        Handlers,
        Children,
        Vdoms,
        Path,
        Child_index,
        Nodes
    ),
    {{cache,
            erlang:element(2, Cache),
            Vdoms@1,
            erlang:element(4, Cache),
            erlang:element(5, Cache),
            erlang:element(6, Cache)},
        {events, Handlers@1, Children@1}}.

-file("src/lustre/vdom/cache.gleam", 209).
?DOC(false).
-spec add_child(
    cache(JTU),
    events(JTU),
    lustre@vdom@path:path(),
    integer(),
    lustre@vdom@vnode:element(JTU)
) -> {cache(JTU), events(JTU)}.
add_child(Cache, Events, Parent, Index, Child) ->
    Children = [Child | []],
    add_children(Cache, Events, Parent, Index, Children).

-file("src/lustre/vdom/cache.gleam", 86).
?DOC(false).
-spec from_node(lustre@vdom@vnode:element(JRG)) -> cache(JRG).
from_node(Root) ->
    Cache = new(),
    {Cache@1, Events} = add_child(
        Cache,
        erlang:element(2, Cache),
        root,
        0,
        Root
    ),
    {cache,
        Events,
        erlang:element(3, Cache@1),
        erlang:element(4, Cache@1),
        erlang:element(5, Cache@1),
        erlang:element(6, Cache@1)}.

-file("src/lustre/vdom/cache.gleam", 351).
?DOC(false).
-spec remove_attributes(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JVJ))),
    lustre@vdom@path:path(),
    list(lustre@vdom@vattr:attribute(JVJ))
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JVJ))).
remove_attributes(Handlers, Path, Attributes) ->
    gleam@list:fold(
        Attributes,
        Handlers,
        fun(Events, Attribute) -> case Attribute of
                {event, _, Name, _, _, _, _, _, _} ->
                    do_remove_event(Events, Path, Name);

                _ ->
                    Events
            end end
    ).

-file("src/lustre/vdom/cache.gleam", 363).
?DOC(false).
-spec do_remove_children(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(JVU))),
    lustre@internals@mutable_map:mutable_map(binary(), child(JVU)),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(JVU)), lustre@vdom@vnode:element(JVU)),
    lustre@vdom@path:path(),
    integer(),
    list(lustre@vdom@vnode:element(JVU))
) -> events(JVU).
do_remove_children(Handlers, Children, Vdoms, Parent, Index, Nodes) ->
    Next = Index + 1,
    case Nodes of
        [] ->
            {events, Handlers, Children};

        [{element, _, Key, _, _, Attributes, Nodes@1, _, _, _} | Rest] ->
            Path = lustre@vdom@path:add(Parent, Index, Key),
            Handlers@1 = remove_attributes(Handlers, Path, Attributes),
            {events, Handlers@2, Children@1} = do_remove_children(
                Handlers@1,
                Children,
                Vdoms,
                Path,
                0,
                Nodes@1
            ),
            do_remove_children(
                Handlers@2,
                Children@1,
                Vdoms,
                Parent,
                Next,
                Rest
            );

        [{fragment, _, Key@1, Nodes@2, _} | Rest@1] ->
            Path@1 = lustre@vdom@path:add(Parent, Index, Key@1),
            {events, Handlers@3, Children@2} = do_remove_children(
                Handlers,
                Children,
                Vdoms,
                Path@1,
                0,
                Nodes@2
            ),
            do_remove_children(
                Handlers@3,
                Children@2,
                Vdoms,
                Parent,
                Next,
                Rest@1
            );

        [{unsafe_inner_html, _, Key@2, _, _, Attributes@1, _} | Rest@2] ->
            Path@2 = lustre@vdom@path:add(Parent, Index, Key@2),
            Handlers@4 = remove_attributes(Handlers, Path@2, Attributes@1),
            do_remove_children(
                Handlers@4,
                Children,
                Vdoms,
                Parent,
                Next,
                Rest@2
            );

        [{map, _, Key@3, _, _} | Rest@3] ->
            Path@3 = lustre@vdom@path:add(Parent, Index, Key@3),
            Children@3 = lustre@internals@mutable_map:delete(
                Children,
                lustre@vdom@path:child(Path@3)
            ),
            do_remove_children(
                Handlers,
                Children@3,
                Vdoms,
                Parent,
                Next,
                Rest@3
            );

        [{memo, _, _, _, View} | Rest@4] ->
            case lustre@internals@mutable_map:has_key(Vdoms, View) of
                true ->
                    Child = lustre@internals@mutable_map:unsafe_get(Vdoms, View),
                    Nodes@3 = [Child | Rest@4],
                    do_remove_children(
                        Handlers,
                        Children,
                        Vdoms,
                        Parent,
                        Index,
                        Nodes@3
                    );

                false ->
                    do_remove_children(
                        Handlers,
                        Children,
                        Vdoms,
                        Parent,
                        Next,
                        Rest@4
                    )
            end;

        [{text, _, _, _} | Rest@5] ->
            do_remove_children(Handlers, Children, Vdoms, Parent, Next, Rest@5)
    end.

-file("src/lustre/vdom/cache.gleam", 334).
?DOC(false).
-spec remove_child(
    cache(JVE),
    events(JVE),
    lustre@vdom@path:path(),
    integer(),
    lustre@vdom@vnode:element(JVE)
) -> events(JVE).
remove_child(Cache, Events, Parent, Child_index, Child) ->
    do_remove_children(
        erlang:element(2, Events),
        erlang:element(3, Events),
        erlang:element(4, Cache),
        Parent,
        Child_index,
        [Child | []]
    ).

-file("src/lustre/vdom/cache.gleam", 428).
?DOC(false).
-spec replace_child(
    cache(JWG),
    events(JWG),
    lustre@vdom@path:path(),
    integer(),
    lustre@vdom@vnode:element(JWG),
    lustre@vdom@vnode:element(JWG)
) -> {cache(JWG), events(JWG)}.
replace_child(Cache, Events, Parent, Child_index, Prev, Next) ->
    Events@1 = remove_child(Cache, Events, Parent, Child_index, Prev),
    add_child(Cache, Events@1, Parent, Child_index, Next).

-file("src/lustre/vdom/cache.gleam", 492).
?DOC(false).
-spec dispatch(cache(JWU), decoded_event(JWU)) -> {cache(JWU),
    {ok, lustre@vdom@vattr:handler(JWU)} | {error, nil}}.
dispatch(Cache, Event) ->
    Next_dispatched_paths = [erlang:element(2, Event) |
        erlang:element(6, Cache)],
    Cache@1 = {cache,
        erlang:element(2, Cache),
        erlang:element(3, Cache),
        erlang:element(4, Cache),
        erlang:element(5, Cache),
        Next_dispatched_paths},
    case Event of
        {decoded_event, _, Handler} ->
            {Cache@1, {ok, Handler}};

        {dispatched_event, _} ->
            {Cache@1, {error, nil}}
    end.

-file("src/lustre/vdom/cache.gleam", 514).
?DOC(false).
-spec has_dispatched_events(cache(any()), lustre@vdom@path:path()) -> boolean().
has_dispatched_events(Cache, Path) ->
    lustre@vdom@path:matches(Path, erlang:element(5, Cache)).

-file("src/lustre/vdom/cache.gleam", 461).
?DOC(false).
-spec get_handler(
    events(any()),
    list(binary()),
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_())
) -> {ok, gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(any()))} |
    {error, nil}.
get_handler(Events, Path, Mapper) ->
    case Path of
        [] ->
            {error, nil};

        [Key] ->
            case lustre@internals@mutable_map:has_key(
                erlang:element(2, Events),
                Key
            ) of
                false ->
                    {error, nil};

                true ->
                    Handler = lustre@internals@mutable_map:unsafe_get(
                        erlang:element(2, Events),
                        Key
                    ),
                    {ok,
                        gleam@dynamic@decode:map(
                            Handler,
                            fun(Handler@1) ->
                                {handler,
                                    erlang:element(2, Handler@1),
                                    erlang:element(3, Handler@1),
                                    (gleam@function:identity(Mapper))(
                                        erlang:element(4, Handler@1)
                                    )}
                            end
                        )}
            end;

        [Key@1 | Path@1] ->
            case lustre@internals@mutable_map:has_key(
                erlang:element(3, Events),
                Key@1
            ) of
                false ->
                    {error, nil};

                true ->
                    Child = lustre@internals@mutable_map:unsafe_get(
                        erlang:element(3, Events),
                        Key@1
                    ),
                    Mapper@1 = compose_mapper(Mapper, erlang:element(2, Child)),
                    get_handler(erlang:element(3, Child), Path@1, Mapper@1)
            end
    end.

-file("src/lustre/vdom/cache.gleam", 447).
?DOC(false).
-spec decode(cache(any()), binary(), binary(), gleam@dynamic:dynamic_()) -> decoded_event(any()).
decode(Cache, Path, Name, Event) ->
    Parts = lustre@vdom@path:split_subtree_path(
        <<<<Path/binary, (<<"\n"/utf8>>)/binary>>/binary, Name/binary>>
    ),
    case get_handler(
        erlang:element(2, Cache),
        Parts,
        fun gleam@function:identity/1
    ) of
        {ok, Handler} ->
            case gleam@dynamic@decode:run(Event, Handler) of
                {ok, Handler@1} ->
                    {decoded_event, Path, Handler@1};

                {error, _} ->
                    {dispatched_event, Path}
            end;

        {error, _} ->
            {dispatched_event, Path}
    end.

-file("src/lustre/vdom/cache.gleam", 504).
?DOC(false).
-spec handle(cache(JWY), binary(), binary(), gleam@dynamic:dynamic_()) -> {cache(JWY),
    {ok, lustre@vdom@vattr:handler(JWY)} | {error, nil}}.
handle(Cache, Path, Name, Event) ->
    _pipe = decode(Cache, Path, Name, Event),
    dispatch(Cache, _pipe).
