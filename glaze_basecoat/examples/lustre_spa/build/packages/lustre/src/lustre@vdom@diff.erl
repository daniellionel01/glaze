-module(lustre@vdom@diff).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/vdom/diff.gleam").
-export([diff/3]).
-export_type([diff/1, partial_diff/1, attribute_change/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type diff(TYH) :: {diff,
        lustre@vdom@patch:patch(TYH),
        lustre@vdom@cache:cache(TYH)}.

-type partial_diff(TYI) :: {partial_diff,
        lustre@vdom@patch:patch(TYI),
        lustre@vdom@cache:cache(TYI),
        lustre@vdom@cache:events(TYI)}.

-type attribute_change(TYJ) :: {attribute_change,
        list(lustre@vdom@vattr:attribute(TYJ)),
        list(lustre@vdom@vattr:attribute(TYJ)),
        lustre@vdom@cache:events(TYJ)}.

-file("src/lustre/vdom/diff.gleam", 662).
?DOC(false).
-spec is_controlled(
    lustre@vdom@cache:cache(any()),
    binary(),
    binary(),
    lustre@vdom@path:path()
) -> boolean().
is_controlled(Cache, Namespace, Tag, Path) ->
    case Tag of
        <<"input"/utf8>> when Namespace =:= <<""/utf8>> ->
            lustre@vdom@cache:has_dispatched_events(Cache, Path);

        <<"select"/utf8>> when Namespace =:= <<""/utf8>> ->
            lustre@vdom@cache:has_dispatched_events(Cache, Path);

        <<"textarea"/utf8>> when Namespace =:= <<""/utf8>> ->
            lustre@vdom@cache:has_dispatched_events(Cache, Path);

        _ ->
            false
    end.

-file("src/lustre/vdom/diff.gleam", 871).
?DOC(false).
-spec property_value_equal(gleam@json:json(), gleam@json:json()) -> boolean().
property_value_equal(A, B) ->
    A =:= B.

-file("src/lustre/vdom/diff.gleam", 678).
?DOC(false).
-spec diff_attributes(
    boolean(),
    lustre@vdom@path:path(),
    lustre@vdom@cache:events(TZM),
    list(lustre@vdom@vattr:attribute(TZM)),
    list(lustre@vdom@vattr:attribute(TZM)),
    list(lustre@vdom@vattr:attribute(TZM)),
    list(lustre@vdom@vattr:attribute(TZM))
) -> attribute_change(TZM).
diff_attributes(Controlled, Path, Events, Old, New, Added, Removed) ->
    case {Old, New} of
        {[], []} ->
            {attribute_change, Added, Removed, Events};

        {[{event, _, Name, _, _, _, _, _, _} = Prev | Old@1], []} ->
            Events@1 = lustre@vdom@cache:remove_event(Events, Path, Name),
            Removed@1 = [Prev | Removed],
            diff_attributes(
                Controlled,
                Path,
                Events@1,
                Old@1,
                New,
                Added,
                Removed@1
            );

        {[Prev@1 | Old@2], []} ->
            Removed@2 = [Prev@1 | Removed],
            diff_attributes(
                Controlled,
                Path,
                Events,
                Old@2,
                New,
                Added,
                Removed@2
            );

        {[], [{event, _, Name@1, Handler, _, _, _, _, _} = Next | New@1]} ->
            Events@2 = lustre@vdom@cache:add_event(
                Events,
                Path,
                Name@1,
                Handler
            ),
            Added@1 = [Next | Added],
            diff_attributes(
                Controlled,
                Path,
                Events@2,
                Old,
                New@1,
                Added@1,
                Removed
            );

        {[], [Next@1 | New@2]} ->
            Added@2 = [Next@1 | Added],
            diff_attributes(
                Controlled,
                Path,
                Events,
                Old,
                New@2,
                Added@2,
                Removed
            );

        {[Prev@2 | Remaining_old], [Next@2 | Remaining_new]} ->
            case {Prev@2, lustre@vdom@vattr:compare(Prev@2, Next@2), Next@2} of
                {{attribute, _, _, _}, eq, {attribute, _, _, _}} ->
                    Has_changes = case erlang:element(3, Next@2) of
                        <<"value"/utf8>> ->
                            Controlled orelse (erlang:element(4, Prev@2) /= erlang:element(
                                4,
                                Next@2
                            ));

                        <<"checked"/utf8>> ->
                            Controlled orelse (erlang:element(4, Prev@2) /= erlang:element(
                                4,
                                Next@2
                            ));

                        <<"selected"/utf8>> ->
                            Controlled orelse (erlang:element(4, Prev@2) /= erlang:element(
                                4,
                                Next@2
                            ));

                        _ ->
                            erlang:element(4, Prev@2) /= erlang:element(
                                4,
                                Next@2
                            )
                    end,
                    Added@3 = case Has_changes of
                        true ->
                            [Next@2 | Added];

                        false ->
                            Added
                    end,
                    diff_attributes(
                        Controlled,
                        Path,
                        Events,
                        Remaining_old,
                        Remaining_new,
                        Added@3,
                        Removed
                    );

                {{property, _, _, _}, eq, {property, _, _, _}} ->
                    Has_changes@1 = case erlang:element(3, Next@2) of
                        <<"scrollLeft"/utf8>> ->
                            true;

                        <<"scrollRight"/utf8>> ->
                            true;

                        <<"value"/utf8>> ->
                            Controlled orelse not property_value_equal(
                                erlang:element(4, Prev@2),
                                erlang:element(4, Next@2)
                            );

                        <<"checked"/utf8>> ->
                            Controlled orelse not property_value_equal(
                                erlang:element(4, Prev@2),
                                erlang:element(4, Next@2)
                            );

                        <<"selected"/utf8>> ->
                            Controlled orelse not property_value_equal(
                                erlang:element(4, Prev@2),
                                erlang:element(4, Next@2)
                            );

                        _ ->
                            not property_value_equal(
                                erlang:element(4, Prev@2),
                                erlang:element(4, Next@2)
                            )
                    end,
                    Added@4 = case Has_changes@1 of
                        true ->
                            [Next@2 | Added];

                        false ->
                            Added
                    end,
                    diff_attributes(
                        Controlled,
                        Path,
                        Events,
                        Remaining_old,
                        Remaining_new,
                        Added@4,
                        Removed
                    );

                {{event, _, _, _, _, _, _, _, _},
                    eq,
                    {event, _, Name@2, Handler@1, _, _, _, _, _}} ->
                    Has_changes@2 = (((erlang:element(
                        2,
                        erlang:element(6, Prev@2)
                    )
                    /= erlang:element(2, erlang:element(6, Next@2)))
                    orelse (erlang:element(2, erlang:element(7, Prev@2)) /= erlang:element(
                        2,
                        erlang:element(7, Next@2)
                    )))
                    orelse (erlang:element(8, Prev@2) /= erlang:element(
                        8,
                        Next@2
                    )))
                    orelse (erlang:element(9, Prev@2) /= erlang:element(
                        9,
                        Next@2
                    )),
                    Added@5 = case Has_changes@2 of
                        true ->
                            [Next@2 | Added];

                        false ->
                            Added
                    end,
                    diff_attributes(
                        Controlled,
                        Path,
                        lustre@vdom@cache:add_event(
                            Events,
                            Path,
                            Name@2,
                            Handler@1
                        ),
                        Remaining_old,
                        Remaining_new,
                        Added@5,
                        Removed
                    );

                {{event, _, Name@3, _, _, _, _, _, _}, eq, _} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        lustre@vdom@cache:remove_event(Events, Path, Name@3),
                        Remaining_old,
                        Remaining_new,
                        [Next@2 | Added],
                        [Prev@2 | Removed]
                    );

                {_, eq, {event, _, Name@4, Handler@2, _, _, _, _, _}} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        lustre@vdom@cache:add_event(
                            Events,
                            Path,
                            Name@4,
                            Handler@2
                        ),
                        Remaining_old,
                        Remaining_new,
                        [Next@2 | Added],
                        [Prev@2 | Removed]
                    );

                {_, eq, _} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        Events,
                        Remaining_old,
                        Remaining_new,
                        [Next@2 | Added],
                        [Prev@2 | Removed]
                    );

                {_, gt, {event, _, Name@5, Handler@3, _, _, _, _, _}} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        lustre@vdom@cache:add_event(
                            Events,
                            Path,
                            Name@5,
                            Handler@3
                        ),
                        Old,
                        Remaining_new,
                        [Next@2 | Added],
                        Removed
                    );

                {_, gt, _} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        Events,
                        Old,
                        Remaining_new,
                        [Next@2 | Added],
                        Removed
                    );

                {{event, _, Name@6, _, _, _, _, _, _}, lt, _} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        lustre@vdom@cache:remove_event(Events, Path, Name@6),
                        Remaining_old,
                        New,
                        Added,
                        [Prev@2 | Removed]
                    );

                {_, lt, _} ->
                    diff_attributes(
                        Controlled,
                        Path,
                        Events,
                        Remaining_old,
                        New,
                        Added,
                        [Prev@2 | Removed]
                    )
            end
    end.

-file("src/lustre/vdom/diff.gleam", 61).
?DOC(false).
-spec do_diff(
    list(lustre@vdom@vnode:element(TYP)),
    lustre@internals@mutable_map:mutable_map(binary(), lustre@vdom@vnode:element(TYP)),
    list(lustre@vdom@vnode:element(TYP)),
    lustre@internals@mutable_map:mutable_map(binary(), lustre@vdom@vnode:element(TYP)),
    lustre@internals@mutable_map:mutable_map(binary(), nil),
    integer(),
    integer(),
    integer(),
    integer(),
    list(lustre@vdom@patch:change(TYP)),
    list(lustre@vdom@patch:patch(TYP)),
    lustre@vdom@path:path(),
    lustre@vdom@cache:cache(TYP),
    lustre@vdom@cache:events(TYP)
) -> partial_diff(TYP).
do_diff(
    Old,
    Old_keyed,
    New,
    New_keyed,
    Moved,
    Moved_offset,
    Removed,
    Node_index,
    Patch_index,
    Changes,
    Children,
    Path,
    Cache,
    Events
) ->
    case {Old, New} of
        {[], []} ->
            Patch = {patch, Patch_index, Removed, Changes, Children},
            {partial_diff, Patch, Cache, Events};

        {[Prev | Old@1], []} ->
            Removed@1 = case (erlang:element(3, Prev) =:= <<""/utf8>>) orelse not lustre@internals@mutable_map:has_key(
                Moved,
                erlang:element(3, Prev)
            ) of
                true ->
                    Removed + 1;

                false ->
                    Removed
            end,
            Events@1 = lustre@vdom@cache:remove_child(
                Cache,
                Events,
                Path,
                Node_index,
                Prev
            ),
            do_diff(
                Old@1,
                Old_keyed,
                New,
                New_keyed,
                Moved,
                Moved_offset,
                Removed@1,
                Node_index,
                Patch_index,
                Changes,
                Children,
                Path,
                Cache,
                Events@1
            );

        {[], [_ | _]} ->
            {Cache@1, Events@2} = lustre@vdom@cache:add_children(
                Cache,
                Events,
                Path,
                Node_index,
                New
            ),
            Insert = lustre@vdom@patch:insert(New, Node_index - Moved_offset),
            Changes@1 = [Insert | Changes],
            Patch@1 = {patch, Patch_index, Removed, Changes@1, Children},
            {partial_diff, Patch@1, Cache@1, Events@2};

        {[Prev@1 | Old_remaining], [Next | New_remaining]} when erlang:element(
            3,
            Prev@1
        ) =/= erlang:element(3, Next) ->
            Next_did_exist = lustre@internals@mutable_map:has_key(
                Old_keyed,
                erlang:element(3, Next)
            ),
            Prev_does_exist = lustre@internals@mutable_map:has_key(
                New_keyed,
                erlang:element(3, Prev@1)
            ),
            case {Prev_does_exist, Next_did_exist} of
                {true, true} ->
                    case lustre@internals@mutable_map:has_key(
                        Moved,
                        erlang:element(3, Prev@1)
                    ) of
                        true ->
                            do_diff(
                                Old_remaining,
                                Old_keyed,
                                New,
                                New_keyed,
                                Moved,
                                Moved_offset - 1,
                                Removed,
                                Node_index,
                                Patch_index,
                                Changes,
                                Children,
                                Path,
                                Cache,
                                Events
                            );

                        false ->
                            Match = lustre@internals@mutable_map:unsafe_get(
                                Old_keyed,
                                erlang:element(3, Next)
                            ),
                            Before = Node_index - Moved_offset,
                            Changes@2 = [lustre@vdom@patch:move(
                                    erlang:element(3, Next),
                                    Before
                                ) |
                                Changes],
                            Moved@1 = lustre@internals@mutable_map:insert(
                                Moved,
                                erlang:element(3, Next),
                                nil
                            ),
                            do_diff(
                                [Match | Old],
                                Old_keyed,
                                New,
                                New_keyed,
                                Moved@1,
                                Moved_offset + 1,
                                Removed,
                                Node_index,
                                Patch_index,
                                Changes@2,
                                Children,
                                Path,
                                Cache,
                                Events
                            )
                    end;

                {false, true} ->
                    Index = Node_index - Moved_offset,
                    Changes@3 = [lustre@vdom@patch:remove(Index) | Changes],
                    Events@3 = lustre@vdom@cache:remove_child(
                        Cache,
                        Events,
                        Path,
                        Node_index,
                        Prev@1
                    ),
                    do_diff(
                        Old_remaining,
                        Old_keyed,
                        New,
                        New_keyed,
                        Moved,
                        Moved_offset - 1,
                        Removed,
                        Node_index,
                        Patch_index,
                        Changes@3,
                        Children,
                        Path,
                        Cache,
                        Events@3
                    );

                {true, false} ->
                    Before@1 = Node_index - Moved_offset,
                    {Cache@2, Events@4} = lustre@vdom@cache:add_child(
                        Cache,
                        Events,
                        Path,
                        Node_index,
                        Next
                    ),
                    Insert@1 = lustre@vdom@patch:insert([Next], Before@1),
                    Changes@4 = [Insert@1 | Changes],
                    do_diff(
                        Old,
                        Old_keyed,
                        New_remaining,
                        New_keyed,
                        Moved,
                        Moved_offset + 1,
                        Removed,
                        Node_index + 1,
                        Patch_index,
                        Changes@4,
                        Children,
                        Path,
                        Cache@2,
                        Events@4
                    );

                {false, false} ->
                    Change = lustre@vdom@patch:replace(
                        Node_index - Moved_offset,
                        Next
                    ),
                    {Cache@3, Events@5} = lustre@vdom@cache:replace_child(
                        Cache,
                        Events,
                        Path,
                        Node_index,
                        Prev@1,
                        Next
                    ),
                    do_diff(
                        Old_remaining,
                        Old_keyed,
                        New_remaining,
                        New_keyed,
                        Moved,
                        Moved_offset,
                        Removed,
                        Node_index + 1,
                        Patch_index,
                        [Change | Changes],
                        Children,
                        Path,
                        Cache@3,
                        Events@5
                    )
            end;

        {[{fragment, _, _, _, _} = Prev@2 | Old@2],
            [{fragment, _, _, _, _} = Next@1 | New@1]} ->
            {partial_diff, Patch@2, Cache@4, Events@6} = do_diff(
                erlang:element(4, Prev@2),
                erlang:element(5, Prev@2),
                erlang:element(4, Next@1),
                erlang:element(5, Next@1),
                maps:new(),
                0,
                0,
                0,
                Node_index,
                [],
                [],
                lustre@vdom@path:add(
                    Path,
                    Node_index,
                    erlang:element(3, Next@1)
                ),
                Cache,
                Events
            ),
            Children@1 = case Patch@2 of
                {patch, _, 0, [], []} ->
                    Children;

                _ ->
                    [Patch@2 | Children]
            end,
            do_diff(
                Old@2,
                Old_keyed,
                New@1,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                Changes,
                Children@1,
                Path,
                Cache@4,
                Events@6
            );

        {[{element, _, _, _, _, _, _, _, _, _} = Prev@3 | Old@3],
            [{element, _, _, _, _, _, _, _, _, _} = Next@2 | New@2]} when (erlang:element(
            4,
            Prev@3
        ) =:= erlang:element(4, Next@2)) andalso (erlang:element(5, Prev@3) =:= erlang:element(
            5,
            Next@2
        )) ->
            Child_path = lustre@vdom@path:add(
                Path,
                Node_index,
                erlang:element(3, Next@2)
            ),
            Controlled = is_controlled(
                Cache,
                erlang:element(4, Next@2),
                erlang:element(5, Next@2),
                Child_path
            ),
            {attribute_change, Added_attrs, Removed_attrs, Events@7} = diff_attributes(
                Controlled,
                Child_path,
                Events,
                erlang:element(6, Prev@3),
                erlang:element(6, Next@2),
                [],
                []
            ),
            Initial_child_changes = case {Added_attrs, Removed_attrs} of
                {[], []} ->
                    [];

                {_, _} ->
                    [lustre@vdom@patch:update(Added_attrs, Removed_attrs)]
            end,
            {partial_diff, Patch@3, Cache@5, Events@8} = do_diff(
                erlang:element(7, Prev@3),
                erlang:element(8, Prev@3),
                erlang:element(7, Next@2),
                erlang:element(8, Next@2),
                maps:new(),
                0,
                0,
                0,
                Node_index,
                Initial_child_changes,
                [],
                Child_path,
                Cache,
                Events@7
            ),
            Children@2 = case Patch@3 of
                {patch, _, 0, [], []} ->
                    Children;

                _ ->
                    [Patch@3 | Children]
            end,
            do_diff(
                Old@3,
                Old_keyed,
                New@2,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                Changes,
                Children@2,
                Path,
                Cache@5,
                Events@8
            );

        {[{text, _, _, _} = Prev@4 | Old@4], [{text, _, _, _} = Next@3 | New@3]} when erlang:element(
            4,
            Prev@4
        ) =:= erlang:element(4, Next@3) ->
            do_diff(
                Old@4,
                Old_keyed,
                New@3,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                Changes,
                Children,
                Path,
                Cache,
                Events
            );

        {[{text, _, _, _} | Old@5], [{text, _, _, _} = Next@4 | New@4]} ->
            Child = lustre@vdom@patch:new(
                Node_index,
                0,
                [lustre@vdom@patch:replace_text(erlang:element(4, Next@4))],
                []
            ),
            do_diff(
                Old@5,
                Old_keyed,
                New@4,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                Changes,
                [Child | Children],
                Path,
                Cache,
                Events
            );

        {[{unsafe_inner_html, _, _, _, _, _, _} = Prev@5 | Old@6],
            [{unsafe_inner_html, _, _, _, _, _, _} = Next@5 | New@5]} ->
            Child_path@1 = lustre@vdom@path:add(
                Path,
                Node_index,
                erlang:element(3, Next@5)
            ),
            {attribute_change, Added_attrs@1, Removed_attrs@1, Events@9} = diff_attributes(
                false,
                Child_path@1,
                Events,
                erlang:element(6, Prev@5),
                erlang:element(6, Next@5),
                [],
                []
            ),
            Child_changes = case {Added_attrs@1, Removed_attrs@1} of
                {[], []} ->
                    [];

                {_, _} ->
                    [lustre@vdom@patch:update(Added_attrs@1, Removed_attrs@1)]
            end,
            Child_changes@1 = case erlang:element(7, Prev@5) =:= erlang:element(
                7,
                Next@5
            ) of
                true ->
                    Child_changes;

                false ->
                    [lustre@vdom@patch:replace_inner_html(
                            erlang:element(7, Next@5)
                        ) |
                        Child_changes]
            end,
            Children@3 = case Child_changes@1 of
                [] ->
                    Children;

                _ ->
                    [lustre@vdom@patch:new(Node_index, 0, Child_changes@1, []) |
                        Children]
            end,
            do_diff(
                Old@6,
                Old_keyed,
                New@5,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                Changes,
                Children@3,
                Path,
                Cache,
                Events@9
            );

        {[{map, _, _, _, _} = Prev@6 | Old@7],
            [{map, _, _, _, _} = Next@6 | New@6]} ->
            Child_path@2 = lustre@vdom@path:add(
                Path,
                Node_index,
                erlang:element(3, Next@6)
            ),
            Child_key = lustre@vdom@path:child(Child_path@2),
            {partial_diff, Patch@4, Cache@6, Child_events} = do_diff(
                [erlang:element(5, Prev@6) | []],
                maps:new(),
                [erlang:element(5, Next@6) | []],
                maps:new(),
                maps:new(),
                0,
                0,
                0,
                Node_index,
                [],
                [],
                lustre@vdom@path:subtree(Child_path@2),
                Cache,
                lustre@vdom@cache:get_subtree(
                    Events,
                    Child_key,
                    erlang:element(4, Prev@6)
                )
            ),
            Events@10 = lustre@vdom@cache:update_subtree(
                Events,
                Child_key,
                erlang:element(4, Next@6),
                Child_events
            ),
            Children@4 = case Patch@4 of
                {patch, _, 0, [], []} ->
                    Children;

                _ ->
                    [Patch@4 | Children]
            end,
            do_diff(
                Old@7,
                Old_keyed,
                New@6,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                Changes,
                Children@4,
                Path,
                Cache@6,
                Events@10
            );

        {[{memo, _, _, _, _} = Prev@7 | Old@8],
            [{memo, _, _, _, _} = Next@7 | New@7]} ->
            case lustre@internals@ref:equal_lists(
                erlang:element(4, Prev@7),
                erlang:element(4, Next@7)
            ) of
                true ->
                    Cache@7 = lustre@vdom@cache:keep_memo(
                        Cache,
                        erlang:element(5, Prev@7),
                        erlang:element(5, Next@7)
                    ),
                    do_diff(
                        Old@8,
                        Old_keyed,
                        New@7,
                        New_keyed,
                        Moved,
                        Moved_offset,
                        Removed,
                        Node_index + 1,
                        Patch_index,
                        Changes,
                        Children,
                        Path,
                        Cache@7,
                        Events
                    );

                false ->
                    Prev_node = lustre@vdom@cache:get_old_memo(
                        Cache,
                        erlang:element(5, Prev@7),
                        erlang:element(5, Prev@7)
                    ),
                    Next_node = (erlang:element(5, Next@7))(),
                    Cache@8 = lustre@vdom@cache:add_memo(
                        Cache,
                        erlang:element(5, Next@7),
                        Next_node
                    ),
                    do_diff(
                        [Prev_node | Old@8],
                        Old_keyed,
                        [Next_node | New@7],
                        New_keyed,
                        Moved,
                        Moved_offset,
                        Removed,
                        Node_index,
                        Patch_index,
                        Changes,
                        Children,
                        Path,
                        Cache@8,
                        Events
                    )
            end;

        {[Prev@8 | Old_remaining@1], [Next@8 | New_remaining@1]} ->
            Change@1 = lustre@vdom@patch:replace(
                Node_index - Moved_offset,
                Next@8
            ),
            {Cache@9, Events@11} = lustre@vdom@cache:replace_child(
                Cache,
                Events,
                Path,
                Node_index,
                Prev@8,
                Next@8
            ),
            do_diff(
                Old_remaining@1,
                Old_keyed,
                New_remaining@1,
                New_keyed,
                Moved,
                Moved_offset,
                Removed,
                Node_index + 1,
                Patch_index,
                [Change@1 | Changes],
                Children,
                Path,
                Cache@9,
                Events@11
            )
    end.

-file("src/lustre/vdom/diff.gleam", 30).
?DOC(false).
-spec diff(
    lustre@vdom@cache:cache(TYK),
    lustre@vdom@vnode:element(TYK),
    lustre@vdom@vnode:element(TYK)
) -> diff(TYK).
diff(Cache, Old, New) ->
    Cache@1 = lustre@vdom@cache:tick(Cache),
    {partial_diff, Patch, Cache@2, Events} = do_diff(
        [Old | []],
        maps:new(),
        [New | []],
        maps:new(),
        maps:new(),
        0,
        0,
        0,
        0,
        [],
        [],
        root,
        Cache@1,
        lustre@vdom@cache:events(Cache@1)
    ),
    {diff, Patch, lustre@vdom@cache:update_events(Cache@2, Events)}.
