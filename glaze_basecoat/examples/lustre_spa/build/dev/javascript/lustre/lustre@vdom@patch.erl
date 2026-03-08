-module(lustre@vdom@patch).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/vdom/patch.gleam").
-export([new/4, is_empty/1, add_child/2, to_json/2, replace_text/1, replace_inner_html/1, update/2, move/2, remove/1, replace/2, insert/2]).
-export_type([patch/1, change/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type patch(SWM) :: {patch,
        integer(),
        integer(),
        list(change(SWM)),
        list(patch(SWM))}.

-type change(SWN) :: {replace_text, integer(), binary()} |
    {replace_inner_html, integer(), binary()} |
    {update,
        integer(),
        list(lustre@vdom@vattr:attribute(SWN)),
        list(lustre@vdom@vattr:attribute(SWN))} |
    {move, integer(), binary(), integer()} |
    {replace, integer(), integer(), lustre@vdom@vnode:element(SWN)} |
    {remove, integer(), integer()} |
    {insert, integer(), list(lustre@vdom@vnode:element(SWN)), integer()}.

-file("src/lustre/vdom/patch.gleam", 66).
?DOC(false).
-spec new(integer(), integer(), list(change(SWO)), list(patch(SWO))) -> patch(SWO).
new(Index, Removed, Changes, Children) ->
    {patch, Index, Removed, Changes, Children}.

-file("src/lustre/vdom/patch.gleam", 125).
?DOC(false).
-spec is_empty(patch(any())) -> boolean().
is_empty(Patch) ->
    case Patch of
        {patch, _, 0, [], []} ->
            true;

        _ ->
            false
    end.

-file("src/lustre/vdom/patch.gleam", 134).
?DOC(false).
-spec add_child(patch(SXR), patch(SXR)) -> patch(SXR).
add_child(Parent, Child) ->
    case is_empty(Child) of
        true ->
            Parent;

        false ->
            {patch,
                erlang:element(2, Parent),
                erlang:element(3, Parent),
                erlang:element(4, Parent),
                [Child | erlang:element(5, Parent)]}
    end.

-file("src/lustre/vdom/patch.gleam", 170).
?DOC(false).
-spec replace_text_to_json(integer(), binary()) -> gleam@json:json().
replace_text_to_json(Kind, Content) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"content"/utf8>>,
        Content
    ),
    lustre@internals@json_object_builder:build(_pipe@1).

-file("src/lustre/vdom/patch.gleam", 176).
?DOC(false).
-spec replace_inner_html_to_json(integer(), binary()) -> gleam@json:json().
replace_inner_html_to_json(Kind, Inner_html) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"inner_html"/utf8>>,
        Inner_html
    ),
    lustre@internals@json_object_builder:build(_pipe@1).

-file("src/lustre/vdom/patch.gleam", 182).
?DOC(false).
-spec update_to_json(
    integer(),
    list(lustre@vdom@vattr:attribute(any())),
    list(lustre@vdom@vattr:attribute(any()))
) -> gleam@json:json().
update_to_json(Kind, Added, Removed) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:list(
        _pipe,
        <<"added"/utf8>>,
        Added,
        fun lustre@vdom@vattr:to_json/1
    ),
    _pipe@2 = lustre@internals@json_object_builder:list(
        _pipe@1,
        <<"removed"/utf8>>,
        Removed,
        fun lustre@vdom@vattr:to_json/1
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/patch.gleam", 189).
?DOC(false).
-spec move_to_json(integer(), binary(), integer()) -> gleam@json:json().
move_to_json(Kind, Key, Before) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:string(
        _pipe,
        <<"key"/utf8>>,
        Key
    ),
    _pipe@2 = lustre@internals@json_object_builder:int(
        _pipe@1,
        <<"before"/utf8>>,
        Before
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/patch.gleam", 196).
?DOC(false).
-spec remove_to_json(integer(), integer()) -> gleam@json:json().
remove_to_json(Kind, Index) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:int(
        _pipe,
        <<"index"/utf8>>,
        Index
    ),
    lustre@internals@json_object_builder:build(_pipe@1).

-file("src/lustre/vdom/patch.gleam", 202).
?DOC(false).
-spec replace_to_json(
    integer(),
    integer(),
    lustre@vdom@vnode:element(TAI),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(TAI)), lustre@vdom@vnode:element(TAI))
) -> gleam@json:json().
replace_to_json(Kind, Index, With, Memos) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:int(
        _pipe,
        <<"index"/utf8>>,
        Index
    ),
    _pipe@2 = lustre@internals@json_object_builder:json(
        _pipe@1,
        <<"with"/utf8>>,
        lustre@vdom@vnode:to_json(With, Memos)
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/patch.gleam", 209).
?DOC(false).
-spec insert_to_json(
    integer(),
    list(lustre@vdom@vnode:element(TAM)),
    integer(),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(TAM)), lustre@vdom@vnode:element(TAM))
) -> gleam@json:json().
insert_to_json(Kind, Children, Before, Memos) ->
    _pipe = lustre@internals@json_object_builder:tagged(Kind),
    _pipe@1 = lustre@internals@json_object_builder:int(
        _pipe,
        <<"before"/utf8>>,
        Before
    ),
    _pipe@2 = lustre@internals@json_object_builder:list(
        _pipe@1,
        <<"children"/utf8>>,
        Children,
        fun(_capture) -> lustre@vdom@vnode:to_json(_capture, Memos) end
    ),
    lustre@internals@json_object_builder:build(_pipe@2).

-file("src/lustre/vdom/patch.gleam", 156).
?DOC(false).
-spec change_to_json(
    change(SXY),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(SXY)), lustre@vdom@vnode:element(SXY))
) -> gleam@json:json().
change_to_json(Change, Memos) ->
    case Change of
        {replace_text, Kind, Content} ->
            replace_text_to_json(Kind, Content);

        {replace_inner_html, Kind@1, Inner_html} ->
            replace_inner_html_to_json(Kind@1, Inner_html);

        {update, Kind@2, Added, Removed} ->
            update_to_json(Kind@2, Added, Removed);

        {move, Kind@3, Key, Before} ->
            move_to_json(Kind@3, Key, Before);

        {remove, Kind@4, Index} ->
            remove_to_json(Kind@4, Index);

        {replace, Kind@5, Index@1, With} ->
            replace_to_json(Kind@5, Index@1, With, Memos);

        {insert, Kind@6, Children, Before@1} ->
            insert_to_json(Kind@6, Children, Before@1, Memos)
    end.

-file("src/lustre/vdom/patch.gleam", 143).
?DOC(false).
-spec to_json(
    patch(SXV),
    lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(SXV)), lustre@vdom@vnode:element(SXV))
) -> gleam@json:json().
to_json(Patch, Memos) ->
    _pipe = lustre@internals@json_object_builder:new(),
    _pipe@1 = lustre@internals@json_object_builder:int(
        _pipe,
        <<"index"/utf8>>,
        erlang:element(2, Patch)
    ),
    _pipe@2 = lustre@internals@json_object_builder:int(
        _pipe@1,
        <<"removed"/utf8>>,
        erlang:element(3, Patch)
    ),
    _pipe@3 = lustre@internals@json_object_builder:list(
        _pipe@2,
        <<"changes"/utf8>>,
        erlang:element(4, Patch),
        fun(Change) -> change_to_json(Change, Memos) end
    ),
    _pipe@4 = lustre@internals@json_object_builder:list(
        _pipe@3,
        <<"children"/utf8>>,
        erlang:element(5, Patch),
        fun(Child) -> to_json(Child, Memos) end
    ),
    lustre@internals@json_object_builder:build(_pipe@4).

-file("src/lustre/vdom/patch.gleam", 77).
?DOC(false).
-spec replace_text(binary()) -> change(any()).
replace_text(Content) ->
    {replace_text, 0, Content}.

-file("src/lustre/vdom/patch.gleam", 83).
?DOC(false).
-spec replace_inner_html(binary()) -> change(any()).
replace_inner_html(Inner_html) ->
    {replace_inner_html, 1, Inner_html}.

-file("src/lustre/vdom/patch.gleam", 89).
?DOC(false).
-spec update(
    list(lustre@vdom@vattr:attribute(SWY)),
    list(lustre@vdom@vattr:attribute(SWY))
) -> change(SWY).
update(Added, Removed) ->
    {update, 2, Added, Removed}.

-file("src/lustre/vdom/patch.gleam", 98).
?DOC(false).
-spec move(binary(), integer()) -> change(any()).
move(Key, Before) ->
    {move, 3, Key, Before}.

-file("src/lustre/vdom/patch.gleam", 104).
?DOC(false).
-spec remove(integer()) -> change(any()).
remove(Index) ->
    {remove, 4, Index}.

-file("src/lustre/vdom/patch.gleam", 110).
?DOC(false).
-spec replace(integer(), lustre@vdom@vnode:element(SXI)) -> change(SXI).
replace(Index, With) ->
    {replace, 5, Index, With}.

-file("src/lustre/vdom/patch.gleam", 116).
?DOC(false).
-spec insert(list(lustre@vdom@vnode:element(SXL)), integer()) -> change(SXL).
insert(Children, Before) ->
    {insert, 6, Children, Before}.
