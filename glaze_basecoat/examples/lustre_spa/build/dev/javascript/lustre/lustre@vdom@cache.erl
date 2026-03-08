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

-opaque cache(THN) :: {cache,
        events(THN),
        lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(THN)), lustre@vdom@vnode:element(THN)),
        lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(THN)), lustre@vdom@vnode:element(THN)),
        list(binary()),
        list(binary())}.

-opaque events(THO) :: {events,
        lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(THO))),
        lustre@internals@mutable_map:mutable_map(binary(), child(THO))}.

-type child(THP) :: {child,
        fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
        events(THP)}.

-type added_children(THQ) :: {added_children,
        lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(THQ))),
        lustre@internals@mutable_map:mutable_map(binary(), child(THQ)),
        lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(THQ)), lustre@vdom@vnode:element(THQ))}.

-opaque decoded_event(THR) :: {decoded_event,
        binary(),
        lustre@vdom@vattr:handler(THR)} |
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
-spec tick(cache(THZ)) -> cache(THZ).
tick(Cache) ->
    {cache,
        erlang:element(2, Cache),
        maps:new(),
        erlang:element(3, Cache),
        erlang:element(6, Cache),
        []}.

-file("src/lustre/vdom/cache.gleam", 102).
?DOC(false).
-spec events(cache(TIC)) -> events(TIC).
events(Cache) ->
    erlang:element(2, Cache).

-file("src/lustre/vdom/cache.gleam", 106).
?DOC(false).
-spec update_events(cache(TIF), events(TIF)) -> cache(TIF).
update_events(Cache, Events) ->
    {cache,
        Events,
        erlang:element(3, Cache),
        erlang:element(4, Cache),
        erlang:element(5, Cache),
        erlang:element(6, Cache)}.

-file("src/lustre/vdom/cache.gleam", 114).
?DOC(false).
-spec memos(cache(TIJ)) -> lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(TIJ)), lustre@vdom@vnode:element(TIJ)).
memos(Cache) ->
    erlang:element(3, Cache).

-file("src/lustre/vdom/cache.gleam", 120).
?DOC(false).
-spec get_old_memo(
    cache(TIM),
    fun(() -> lustre@vdom@vnode:element(TIM)),
    fun(() -> lustre@vdom@vnode:element(TIM))
) -> lustre@vdom@vnode:element(TIM).
get_old_memo(Cache, Old, New) ->
    lustre@internals@mutable_map:get_or_compute(
        erlang:element(4, Cache),
        Old,
        New
    ).

-file("src/lustre/vdom/cache.gleam", 129).
?DOC(false).
-spec keep_memo(
    cache(TIR),
    fun(() -> lustre@vdom@vnode:element(TIR)),
    fun(() -> lustre@vdom@vnode:element(TIR))
) -> cache(TIR).
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
    cache(TIW),
    fun(() -> lustre@vdom@vnode:element(TIW)),
    lustre@vdom@vnode:element(TIW)
) -> cache(TIW).
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
    events(TJB),
    binary(),
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_())
) -> events(TJB).
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
    events(TJE),
    binary(),
    fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
    events(TJE)
) -> events(TJE).
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
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TJN))),
    lustre@vdom@path:path(),
    binary(),
    gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TJN))
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TJN))).
do_add_event(Handlers, Path, Name, Handler) ->
    lustre@internals@mutable_map:insert(
        Handlers,
        lustre@vdom@path:event(Path, Name),
        Handler
    ).

-file("src/lustre/vdom/cache.gleam", 173).
?DOC(false).
-spec add_event(
    events(TJI),
    lustre@vdom@path:path(),
    binary(),
    gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TJI))
) -> events(TJI).
add_event(Events, Path, Name, Handler) ->
    Handlers = do_add_event(erlang:element(2, Events), Path, Name, Handler),
    {events, Handlers, erlang:element(3, Events)}.

-file("src/lustre/vdom/cache.gleam", 201).
?DOC(false).
-spec do_remove_event(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TKB))),
    lustre@vdom@path:path(),
    binary()
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TKB))).
do_remove_event(Handlers, Path, Name) ->
    lustre@internals@mutable_map:delete(
        Handlers,
        lustre@vdom@path:event(Path, Name)
    ).

-file("src/lustre/vdom/cache.gleam", 192).
?DOC(false).
-spec remove_event(events(TJY), lustre@vdom@path:path(), binary()) -> events(TJY).
remove_event(Events, Path, Name) ->
    Handlers = do_remove_event(erlang:element(2, Events), Path, Name),
    {events, Handlers, erlang:element(3, Events)}.

-file("src/lustre/vdom/cache.gleam", 220).
?DOC(false).
-spec add_attributes(
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TKQ))),
    lustre@vdom@path:path(),
    list(lustre@vdom@vattr:attribute(TKQ))
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TKQ))).
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
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TLI))),
    lustre@internals@mutable_map:mutable_map(binary(), child(TLI)),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(TLI)), lustre@vdom@vnode:element(TLI)),
    lustre@vdom@path:path(),
    integer(),
    list(lustre@vdom@vnode:element(TLI))
) -> added_children(TLI).
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
    cache(TLB),
    events(TLB),
    lustre@vdom@path:path(),
    integer(),
    list(lustre@vdom@vnode:element(TLB))
) -> {cache(TLB), events(TLB)}.
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
    cache(TKK),
    events(TKK),
    lustre@vdom@path:path(),
    integer(),
    lustre@vdom@vnode:element(TKK)
) -> {cache(TKK), events(TKK)}.
add_child(Cache, Events, Parent, Index, Child) ->
    Children = [Child | []],
    add_children(Cache, Events, Parent, Index, Children).

-file("src/lustre/vdom/cache.gleam", 86).
?DOC(false).
-spec from_node(lustre@vdom@vnode:element(THW)) -> cache(THW).
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
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TLZ))),
    lustre@vdom@path:path(),
    list(lustre@vdom@vattr:attribute(TLZ))
) -> lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TLZ))).
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
    lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(TMK))),
    lustre@internals@mutable_map:mutable_map(binary(), child(TMK)),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(TMK)), lustre@vdom@vnode:element(TMK)),
    lustre@vdom@path:path(),
    integer(),
    list(lustre@vdom@vnode:element(TMK))
) -> events(TMK).
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
    cache(TLU),
    events(TLU),
    lustre@vdom@path:path(),
    integer(),
    lustre@vdom@vnode:element(TLU)
) -> events(TLU).
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
    cache(TMW),
    events(TMW),
    lustre@vdom@path:path(),
    integer(),
    lustre@vdom@vnode:element(TMW),
    lustre@vdom@vnode:element(TMW)
) -> {cache(TMW), events(TMW)}.
replace_child(Cache, Events, Parent, Child_index, Prev, Next) ->
    Events@1 = remove_child(Cache, Events, Parent, Child_index, Prev),
    add_child(Cache, Events@1, Parent, Child_index, Next).

-file("src/lustre/vdom/cache.gleam", 492).
?DOC(false).
-spec dispatch(cache(TNK), decoded_event(TNK)) -> {cache(TNK),
    {ok, lustre@vdom@vattr:handler(TNK)} | {error, nil}}.
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
-spec handle(cache(TNO), binary(), binary(), gleam@dynamic:dynamic_()) -> {cache(TNO),
    {ok, lustre@vdom@vattr:handler(TNO)} | {error, nil}}.
handle(Cache, Path, Name, Event) ->
    _pipe = decode(Cache, Path, Name, Event),
    dispatch(Cache, _pipe).
