-module(gleam@list).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/gleam/list.gleam").
-export([length/1, count/2, reverse/1, is_empty/1, contains/2, first/1, rest/1, group/2, filter/2, filter_map/2, map/2, map2/3, map_fold/3, index_map/2, try_map/2, drop/2, take/2, new/0, wrap/1, append/2, prepend/2, flatten/1, flat_map/2, fold/3, fold_right/3, index_fold/3, try_fold/3, fold_until/3, find/2, find_map/2, all/2, any/2, zip/2, strict_zip/2, unzip/1, intersperse/2, unique/1, sort/2, range/2, repeat/2, split/2, split_while/2, key_find/2, key_filter/2, key_pop/2, key_set/3, each/2, try_each/2, partition/2, window/2, window_by_2/1, drop_while/2, take_while/2, chunk/2, sized_chunk/2, reduce/2, scan/3, last/1, combinations/2, combination_pairs/1, transpose/1, interleave/1, shuffle/1, max/2, sample/2, permutations/1]).
-export_type([continue_or_stop/1, sorting/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Lists are an ordered sequence of elements and are one of the most common\n"
    " data types in Gleam.\n"
    "\n"
    " New elements can be added and removed from the front of a list in\n"
    " constant time, while adding and removing from the end requires traversing\n"
    " and copying the whole list, so keep this in mind when designing your\n"
    " programs.\n"
    "\n"
    " There is a dedicated syntax for prefixing to a list:\n"
    "\n"
    " ```gleam\n"
    " let new_list = [1, 2, ..existing_list]\n"
    " ```\n"
    "\n"
    " And a matching syntax for getting the first elements of a list:\n"
    "\n"
    " ```gleam\n"
    " case list {\n"
    "   [first_element, ..rest] -> first_element\n"
    "   _ -> \"this pattern matches when the list is empty\"\n"
    " }\n"
    " ```\n"
    "\n"
).

-type continue_or_stop(ABH) :: {continue, ABH} | {stop, ABH}.

-type sorting() :: ascending | descending.

-file("src/gleam/list.gleam", 57).
-spec length_loop(list(any()), integer()) -> integer().
length_loop(List, Count) ->
    case List of
        [_ | List@1] ->
            length_loop(List@1, Count + 1);

        [] ->
            Count
    end.

-file("src/gleam/list.gleam", 53).
?DOC(
    " Counts the number of elements in a given list.\n"
    "\n"
    " This function has to traverse the list to determine the number of elements,\n"
    " so it runs in linear time.\n"
    "\n"
    " This function is natively implemented by the virtual machine and is highly\n"
    " optimised.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert length([]) == 0\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert length([1]) == 1\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert length([1, 2]) == 2\n"
    " ```\n"
).
-spec length(list(any())) -> integer().
length(List) ->
    erlang:length(List).

-file("src/gleam/list.gleam", 87).
-spec count_loop(list(ABO), fun((ABO) -> boolean()), integer()) -> integer().
count_loop(List, Predicate, Acc) ->
    case List of
        [] ->
            Acc;

        [First | Rest] ->
            case Predicate(First) of
                true ->
                    count_loop(Rest, Predicate, Acc + 1);

                false ->
                    count_loop(Rest, Predicate, Acc)
            end
    end.

-file("src/gleam/list.gleam", 83).
?DOC(
    " Counts the number of elements in a given list satisfying a given predicate.\n"
    "\n"
    " This function has to traverse the list to determine the number of elements,\n"
    " so it runs in linear time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert count([], fn(a) { a > 0 }) == 0\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert count([1], fn(a) { a > 0 }) == 1\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert count([1, 2, 3], int.is_odd) == 2\n"
    " ```\n"
).
-spec count(list(ABM), fun((ABM) -> boolean())) -> integer().
count(List, Predicate) ->
    count_loop(List, Predicate, 0).

-file("src/gleam/list.gleam", 122).
?DOC(
    " Creates a new list from a given list containing the same elements but in the\n"
    " opposite order.\n"
    "\n"
    " This function has to traverse the list to create the new reversed list, so\n"
    " it runs in linear time.\n"
    "\n"
    " This function is natively implemented by the virtual machine and is highly\n"
    " optimised.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert reverse([]) == []\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert reverse([1]) == [1]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert reverse([1, 2]) == [2, 1]\n"
    " ```\n"
).
-spec reverse(list(ABQ)) -> list(ABQ).
reverse(List) ->
    lists:reverse(List).

-file("src/gleam/list.gleam", 156).
?DOC(
    " Determines whether or not the list is empty.\n"
    "\n"
    " This function runs in constant time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert is_empty([])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !is_empty([1])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !is_empty([1, 1])\n"
    " ```\n"
).
-spec is_empty(list(any())) -> boolean().
is_empty(List) ->
    List =:= [].

-file("src/gleam/list.gleam", 187).
?DOC(
    " Determines whether or not a given element exists within a given list.\n"
    "\n"
    " This function traverses the list to find the element, so it runs in linear\n"
    " time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert !contains([], any: 0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert [0] |> contains(any: 0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !contains([1], any: 0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !contains([1, 1], any: 0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert [1, 0] |> contains(any: 0)\n"
    " ```\n"
).
-spec contains(list(ABZ), ABZ) -> boolean().
contains(List, Elem) ->
    case List of
        [] ->
            false;

        [First | _] when First =:= Elem ->
            true;

        [_ | Rest] ->
            contains(Rest, Elem)
    end.

-file("src/gleam/list.gleam", 211).
?DOC(
    " Gets the first element from the start of the list, if there is one.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert first([]) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert first([0]) == Ok(0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert first([1, 2]) == Ok(1)\n"
    " ```\n"
).
-spec first(list(ACB)) -> {ok, ACB} | {error, nil}.
first(List) ->
    case List of
        [] ->
            {error, nil};

        [First | _] ->
            {ok, First}
    end.

-file("src/gleam/list.gleam", 237).
?DOC(
    " Returns the list minus the first element. If the list is empty, `Error(Nil)` is\n"
    " returned.\n"
    "\n"
    " This function runs in constant time and does not make a copy of the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert rest([]) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert rest([0]) == Ok([])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert rest([1, 2]) == Ok([2])\n"
    " ```\n"
).
-spec rest(list(ACF)) -> {ok, list(ACF)} | {error, nil}.
rest(List) ->
    case List of
        [] ->
            {error, nil};

        [_ | Rest] ->
            {ok, Rest}
    end.

-file("src/gleam/list.gleam", 276).
?DOC(
    " Groups the elements from the given list by the given key function.\n"
    "\n"
    " Does not preserve the initial value order.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " import gleam/dict\n"
    "\n"
    " assert\n"
    "   [Ok(3), Error(\"Wrong\"), Ok(200), Ok(73)]\n"
    "   |> group(by: fn(i) {\n"
    "     case i {\n"
    "       Ok(_) -> \"Successful\"\n"
    "       Error(_) -> \"Failed\"\n"
    "     }\n"
    "   })\n"
    "   |> dict.to_list\n"
    "   == [\n"
    "     #(\"Failed\", [Error(\"Wrong\")]),\n"
    "     #(\"Successful\", [Ok(73), Ok(200), Ok(3)])\n"
    "   ]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " import gleam/dict\n"
    "\n"
    " assert group([1,2,3,4,5], by: fn(i) { i - i / 3 * 3 })\n"
    "   |> dict.to_list\n"
    "   == [#(0, [3]), #(1, [4, 1]), #(2, [5, 2])]\n"
    " ```\n"
).
-spec group(list(ACK), fun((ACK) -> ACM)) -> gleam@dict:dict(ACM, list(ACK)).
group(List, Key) ->
    gleam@dict:group(Key, List).

-file("src/gleam/list.gleam", 297).
-spec filter_loop(list(ACT), fun((ACT) -> boolean()), list(ACT)) -> list(ACT).
filter_loop(List, Fun, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            New_acc = case Fun(First) of
                true ->
                    [First | Acc];

                false ->
                    Acc
            end,
            filter_loop(Rest, Fun, New_acc)
    end.

-file("src/gleam/list.gleam", 293).
?DOC(
    " Returns a new list containing only the elements from the first list for\n"
    " which the given functions returns `True`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert filter([2, 4, 6, 1], fn(x) { x > 2 }) == [4, 6]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert filter([2, 4, 6, 1], fn(x) { x > 6 }) == []\n"
    " ```\n"
).
-spec filter(list(ACQ), fun((ACQ) -> boolean())) -> list(ACQ).
filter(List, Predicate) ->
    filter_loop(List, Predicate, []).

-file("src/gleam/list.gleam", 327).
-spec filter_map_loop(
    list(ADE),
    fun((ADE) -> {ok, ADG} | {error, any()}),
    list(ADG)
) -> list(ADG).
filter_map_loop(List, Fun, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            New_acc = case Fun(First) of
                {ok, First@1} ->
                    [First@1 | Acc];

                {error, _} ->
                    Acc
            end,
            filter_map_loop(Rest, Fun, New_acc)
    end.

-file("src/gleam/list.gleam", 323).
?DOC(
    " Returns a new list containing only the elements from the first list for\n"
    " which the given functions returns `Ok(_)`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert filter_map([2, 4, 6, 1], Error) == []\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert filter_map([2, 4, 6, 1], fn(x) { Ok(x + 1) }) == [3, 5, 7, 2]\n"
    " ```\n"
).
-spec filter_map(list(ACX), fun((ACX) -> {ok, ACZ} | {error, any()})) -> list(ACZ).
filter_map(List, Fun) ->
    filter_map_loop(List, Fun, []).

-file("src/gleam/list.gleam", 356).
-spec map_loop(list(ADQ), fun((ADQ) -> ADS), list(ADS)) -> list(ADS).
map_loop(List, Fun, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            map_loop(Rest, Fun, [Fun(First) | Acc])
    end.

-file("src/gleam/list.gleam", 352).
?DOC(
    " Returns a new list containing the results of applying the supplied function to each element.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert map([2, 4, 6], fn(x) { x * 2 }) == [4, 8, 12]\n"
    " ```\n"
).
-spec map(list(ADM), fun((ADM) -> ADO)) -> list(ADO).
map(List, Fun) ->
    map_loop(List, Fun, []).

-file("src/gleam/list.gleam", 382).
-spec map2_loop(list(AEB), list(AED), fun((AEB, AED) -> AEF), list(AEF)) -> list(AEF).
map2_loop(List1, List2, Fun, Acc) ->
    case {List1, List2} of
        {[], _} ->
            lists:reverse(Acc);

        {_, []} ->
            lists:reverse(Acc);

        {[A | As_], [B | Bs]} ->
            map2_loop(As_, Bs, Fun, [Fun(A, B) | Acc])
    end.

-file("src/gleam/list.gleam", 378).
?DOC(
    " Combines two lists into a single list using the given function.\n"
    "\n"
    " If a list is longer than the other, the extra elements are dropped.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert map2([1, 2, 3], [4, 5, 6], fn(x, y) { x + y }) == [5, 7, 9]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert map2([1, 2], [\"a\", \"b\", \"c\"], fn(i, x) { #(i, x) })\n"
    "   == [#(1, \"a\"), #(2, \"b\")]\n"
    " ```\n"
).
-spec map2(list(ADV), list(ADX), fun((ADV, ADX) -> ADZ)) -> list(ADZ).
map2(List1, List2, Fun) ->
    map2_loop(List1, List2, Fun, []).

-file("src/gleam/list.gleam", 416).
-spec map_fold_loop(list(AEN), fun((AEP, AEN) -> {AEP, AEQ}), AEP, list(AEQ)) -> {AEP,
    list(AEQ)}.
map_fold_loop(List, Fun, Acc, List_acc) ->
    case List of
        [] ->
            {Acc, lists:reverse(List_acc)};

        [First | Rest] ->
            {Acc@1, First@1} = Fun(Acc, First),
            map_fold_loop(Rest, Fun, Acc@1, [First@1 | List_acc])
    end.

-file("src/gleam/list.gleam", 408).
?DOC(
    " Similar to `map` but also lets you pass around an accumulated value.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert\n"
    "   map_fold(\n"
    "     over: [1, 2, 3],\n"
    "     from: 100,\n"
    "     with: fn(memo, i) { #(memo + i, i * 2) }\n"
    "   )\n"
    "   == #(106, [2, 4, 6])\n"
    " ```\n"
).
-spec map_fold(list(AEI), AEK, fun((AEK, AEI) -> {AEK, AEL})) -> {AEK,
    list(AEL)}.
map_fold(List, Initial, Fun) ->
    map_fold_loop(List, Fun, Initial, []).

-file("src/gleam/list.gleam", 447).
-spec index_map_loop(
    list(AEX),
    fun((AEX, integer()) -> AEZ),
    integer(),
    list(AEZ)
) -> list(AEZ).
index_map_loop(List, Fun, Index, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            Acc@1 = [Fun(First, Index) | Acc],
            index_map_loop(Rest, Fun, Index + 1, Acc@1)
    end.

-file("src/gleam/list.gleam", 443).
?DOC(
    " Similar to `map`, but the supplied function will also be passed the index\n"
    " of the element being mapped as an additional argument.\n"
    "\n"
    " The index starts at 0, so the first element is 0, the second is 1, and so\n"
    " on.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert index_map([\"a\", \"b\"], fn(x, i) { #(i, x) }) == [#(0, \"a\"), #(1, \"b\")]\n"
    " ```\n"
).
-spec index_map(list(AET), fun((AET, integer()) -> AEV)) -> list(AEV).
index_map(List, Fun) ->
    index_map_loop(List, Fun, 0, []).

-file("src/gleam/list.gleam", 497).
-spec try_map_loop(list(AFL), fun((AFL) -> {ok, AFN} | {error, AFO}), list(AFN)) -> {ok,
        list(AFN)} |
    {error, AFO}.
try_map_loop(List, Fun, Acc) ->
    case List of
        [] ->
            {ok, lists:reverse(Acc)};

        [First | Rest] ->
            case Fun(First) of
                {ok, First@1} ->
                    try_map_loop(Rest, Fun, [First@1 | Acc]);

                {error, Error} ->
                    {error, Error}
            end
    end.

-file("src/gleam/list.gleam", 490).
?DOC(
    " Takes a function that returns a `Result` and applies it to each element in a\n"
    " given list in turn.\n"
    "\n"
    " If the function returns `Ok(new_value)` for all elements in the list then a\n"
    " list of the new values is returned.\n"
    "\n"
    " If the function returns `Error(reason)` for any of the elements then it is\n"
    " returned immediately. None of the elements in the list are processed after\n"
    " one returns an `Error`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert try_map([1, 2, 3], fn(x) { Ok(x + 2) }) == Ok([3, 4, 5])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert try_map([1, 2, 3], fn(_) { Error(0) }) == Error(0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert try_map([[1], [2, 3]], first) == Ok([1, 2])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert try_map([[1], [], [2]], first) == Error(Nil)\n"
    " ```\n"
).
-spec try_map(list(AFC), fun((AFC) -> {ok, AFE} | {error, AFF})) -> {ok,
        list(AFE)} |
    {error, AFF}.
try_map(List, Fun) ->
    try_map_loop(List, Fun, []).

-file("src/gleam/list.gleam", 530).
?DOC(
    " Returns a list that is the given list with up to the given number of\n"
    " elements removed from the front of the list.\n"
    "\n"
    " If the list has less than the number of elements an empty list is\n"
    " returned.\n"
    "\n"
    " This function runs in linear time but does not copy the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert drop([1, 2, 3, 4], 2) == [3, 4]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert drop([1, 2, 3, 4], 9) == []\n"
    " ```\n"
).
-spec drop(list(AFV), integer()) -> list(AFV).
drop(List, N) ->
    case N =< 0 of
        true ->
            List;

        false ->
            case List of
                [] ->
                    [];

                [_ | Rest] ->
                    drop(Rest, N - 1)
            end
    end.

-file("src/gleam/list.gleam", 563).
-spec take_loop(list(AGB), integer(), list(AGB)) -> list(AGB).
take_loop(List, N, Acc) ->
    case N =< 0 of
        true ->
            lists:reverse(Acc);

        false ->
            case List of
                [] ->
                    lists:reverse(Acc);

                [First | Rest] ->
                    take_loop(Rest, N - 1, [First | Acc])
            end
    end.

-file("src/gleam/list.gleam", 559).
?DOC(
    " Returns a list containing the first given number of elements from the given\n"
    " list.\n"
    "\n"
    " If the list has less than the number of elements then the full list is\n"
    " returned.\n"
    "\n"
    " This function runs in linear time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert take([1, 2, 3, 4], 2) == [1, 2]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert take([1, 2, 3, 4], 9) == [1, 2, 3, 4]\n"
    " ```\n"
).
-spec take(list(AFY), integer()) -> list(AFY).
take(List, N) ->
    take_loop(List, N, []).

-file("src/gleam/list.gleam", 582).
?DOC(
    " Returns a new empty list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert new() == []\n"
    " ```\n"
).
-spec new() -> list(any()).
new() ->
    [].

-file("src/gleam/list.gleam", 603).
?DOC(
    " Returns the given item wrapped in a list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert wrap(1) == [1]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert wrap([\"a\", \"b\", \"c\"]) == [[\"a\", \"b\", \"c\"]]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert wrap([[]]) == [[[]]]\n"
    " ```\n"
).
-spec wrap(AGH) -> list(AGH).
wrap(Item) ->
    [Item].

-file("src/gleam/list.gleam", 623).
-spec append_loop(list(AGN), list(AGN)) -> list(AGN).
append_loop(First, Second) ->
    case First of
        [] ->
            Second;

        [First@1 | Rest] ->
            append_loop(Rest, [First@1 | Second])
    end.

-file("src/gleam/list.gleam", 619).
?DOC(
    " Joins one list onto the end of another.\n"
    "\n"
    " This function runs in linear time, and it traverses and copies the first\n"
    " list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert append([1, 2], [3]) == [1, 2, 3]\n"
    " ```\n"
).
-spec append(list(AGJ), list(AGJ)) -> list(AGJ).
append(First, Second) ->
    lists:append(First, Second).

-file("src/gleam/list.gleam", 643).
?DOC(
    " Prefixes an item to a list. This can also be done using the dedicated\n"
    " syntax instead.\n"
    "\n"
    " ```gleam\n"
    " let existing_list = [2, 3, 4]\n"
    " assert [1, ..existing_list] == [1, 2, 3, 4]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " let existing_list = [2, 3, 4]\n"
    " assert prepend(to: existing_list, this: 1) == [1, 2, 3, 4]\n"
    " ```\n"
).
-spec prepend(list(AGR), AGR) -> list(AGR).
prepend(List, Item) ->
    [Item | List].

-file("src/gleam/list.gleam", 663).
-spec flatten_loop(list(list(AGY)), list(AGY)) -> list(AGY).
flatten_loop(Lists, Acc) ->
    case Lists of
        [] ->
            lists:reverse(Acc);

        [List | Further_lists] ->
            flatten_loop(Further_lists, lists:reverse(List, Acc))
    end.

-file("src/gleam/list.gleam", 659).
?DOC(
    " Joins a list of lists into a single list.\n"
    "\n"
    " This function traverses all elements twice on the JavaScript target.\n"
    " This function traverses all elements once on the Erlang target.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert flatten([[1], [2, 3], []]) == [1, 2, 3]\n"
    " ```\n"
).
-spec flatten(list(list(AGU))) -> list(AGU).
flatten(Lists) ->
    lists:append(Lists).

-file("src/gleam/list.gleam", 679).
?DOC(
    " Maps the list with the given function into a list of lists, and then flattens it.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert flat_map([2, 4, 6], fn(x) { [x, x + 1] }) == [2, 3, 4, 5, 6, 7]\n"
    " ```\n"
).
-spec flat_map(list(AHD), fun((AHD) -> list(AHF))) -> list(AHF).
flat_map(List, Fun) ->
    lists:append(map(List, Fun)).

-file("src/gleam/list.gleam", 691).
?DOC(
    " Reduces a list of elements into a single value by calling a given function\n"
    " on each element, going from left to right.\n"
    "\n"
    " `fold([1, 2, 3], 0, add)` is the equivalent of\n"
    " `add(add(add(0, 1), 2), 3)`.\n"
    "\n"
    " This function runs in linear time.\n"
).
-spec fold(list(AHI), AHK, fun((AHK, AHI) -> AHK)) -> AHK.
fold(List, Initial, Fun) ->
    case List of
        [] ->
            Initial;

        [First | Rest] ->
            fold(Rest, Fun(Initial, First), Fun)
    end.

-file("src/gleam/list.gleam", 713).
?DOC(
    " Reduces a list of elements into a single value by calling a given function\n"
    " on each element, going from right to left.\n"
    "\n"
    " `fold_right([1, 2, 3], 0, add)` is the equivalent of\n"
    " `add(add(add(0, 3), 2), 1)`.\n"
    "\n"
    " This function runs in linear time.\n"
    "\n"
    " Unlike `fold` this function is not tail recursive. Where possible use\n"
    " `fold` instead as it will use less memory.\n"
).
-spec fold_right(list(AHL), AHN, fun((AHN, AHL) -> AHN)) -> AHN.
fold_right(List, Initial, Fun) ->
    case List of
        [] ->
            Initial;

        [First | Rest] ->
            Fun(fold_right(Rest, Initial, Fun), First)
    end.

-file("src/gleam/list.gleam", 750).
-spec index_fold_loop(
    list(AHR),
    AHT,
    fun((AHT, AHR, integer()) -> AHT),
    integer()
) -> AHT.
index_fold_loop(Over, Acc, With, Index) ->
    case Over of
        [] ->
            Acc;

        [First | Rest] ->
            index_fold_loop(Rest, With(Acc, First, Index), With, Index + 1)
    end.

-file("src/gleam/list.gleam", 742).
?DOC(
    " Like `fold` but the folding function also receives the index of the current element.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [\"a\", \"b\", \"c\"]\n"
    "   |> index_fold(\"\", fn(acc, item, index) {\n"
    "     acc <> int.to_string(index) <> \":\" <> item <> \" \"\n"
    "   })\n"
    "   == \"0:a 1:b 2:c\"\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert [10, 20, 30]\n"
    "   |> index_fold(0, fn(acc, item, index) { acc + item * index })\n"
    "   == 80\n"
    " ```\n"
).
-spec index_fold(list(AHO), AHQ, fun((AHQ, AHO, integer()) -> AHQ)) -> AHQ.
index_fold(List, Initial, Fun) ->
    index_fold_loop(List, Initial, Fun, 0).

-file("src/gleam/list.gleam", 782).
?DOC(
    " A variant of fold that might fail.\n"
    "\n"
    " The folding function should return `Result(accumulator, error)`.\n"
    " If the returned value is `Ok(accumulator)` try_fold will try the next value in the list.\n"
    " If the returned value is `Error(error)` try_fold will stop and return that error.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 3, 4]\n"
    "   |> try_fold(0, fn(acc, i) {\n"
    "     case i < 3 {\n"
    "       True -> Ok(acc + i)\n"
    "       False -> Error(Nil)\n"
    "     }\n"
    "   })\n"
    "   == Error(Nil)\n"
    " ```\n"
).
-spec try_fold(list(AHU), AHW, fun((AHW, AHU) -> {ok, AHW} | {error, AHX})) -> {ok,
        AHW} |
    {error, AHX}.
try_fold(List, Initial, Fun) ->
    case List of
        [] ->
            {ok, Initial};

        [First | Rest] ->
            case Fun(Initial, First) of
                {ok, Result} ->
                    try_fold(Rest, Result, Fun);

                {error, _} = Error ->
                    Error
            end
    end.

-file("src/gleam/list.gleam", 821).
?DOC(
    " A variant of fold that allows to stop folding earlier.\n"
    "\n"
    " The folding function should return `ContinueOrStop(accumulator)`.\n"
    " If the returned value is `Continue(accumulator)` fold_until will try the next value in the list.\n"
    " If the returned value is `Stop(accumulator)` fold_until will stop and return that accumulator.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 3, 4]\n"
    "   |> fold_until(0, fn(acc, i) {\n"
    "     case i < 3 {\n"
    "       True -> Continue(acc + i)\n"
    "       False -> Stop(acc)\n"
    "     }\n"
    "   })\n"
    "   == 3\n"
    " ```\n"
).
-spec fold_until(list(AIC), AIE, fun((AIE, AIC) -> continue_or_stop(AIE))) -> AIE.
fold_until(List, Initial, Fun) ->
    case List of
        [] ->
            Initial;

        [First | Rest] ->
            case Fun(Initial, First) of
                {continue, Next_accumulator} ->
                    fold_until(Rest, Next_accumulator, Fun);

                {stop, B} ->
                    B
            end
    end.

-file("src/gleam/list.gleam", 855).
?DOC(
    " Finds the first element in a given list for which the given function returns\n"
    " `True`.\n"
    "\n"
    " Returns `Error(Nil)` if no such element is found.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert find([1, 2, 3], fn(x) { x > 2 }) == Ok(3)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert find([1, 2, 3], fn(x) { x > 4 }) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert find([], fn(_) { True }) == Error(Nil)\n"
    " ```\n"
).
-spec find(list(AIG), fun((AIG) -> boolean())) -> {ok, AIG} | {error, nil}.
find(List, Is_desired) ->
    case List of
        [] ->
            {error, nil};

        [First | Rest] ->
            case Is_desired(First) of
                true ->
                    {ok, First};

                false ->
                    find(Rest, Is_desired)
            end
    end.

-file("src/gleam/list.gleam", 888).
?DOC(
    " Finds the first element in a given list for which the given function returns\n"
    " `Ok(new_value)`, then returns the wrapped `new_value`.\n"
    "\n"
    " Returns `Error(Nil)` if no such element is found.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert find_map([[], [2], [3]], first) == Ok(2)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert find_map([[], []], first) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert find_map([], first) == Error(Nil)\n"
    " ```\n"
).
-spec find_map(list(AIK), fun((AIK) -> {ok, AIM} | {error, any()})) -> {ok, AIM} |
    {error, nil}.
find_map(List, Fun) ->
    case List of
        [] ->
            {error, nil};

        [First | Rest] ->
            case Fun(First) of
                {ok, First@1} ->
                    {ok, First@1};

                {error, _} ->
                    find_map(Rest, Fun)
            end
    end.

-file("src/gleam/list.gleam", 920).
?DOC(
    " Returns `True` if the given function returns `True` for all the elements in\n"
    " the given list. If the function returns `False` for any of the elements it\n"
    " immediately returns `False` without checking the rest of the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert all([], fn(x) { x > 3 })\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert all([4, 5], fn(x) { x > 3 })\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !all([4, 3], fn(x) { x > 3 })\n"
    " ```\n"
).
-spec all(list(AIS), fun((AIS) -> boolean())) -> boolean().
all(List, Predicate) ->
    case List of
        [] ->
            true;

        [First | Rest] ->
            case Predicate(First) of
                true ->
                    all(Rest, Predicate);

                false ->
                    false
            end
    end.

-file("src/gleam/list.gleam", 953).
?DOC(
    " Returns `True` if the given function returns `True` for any the elements in\n"
    " the given list. If the function returns `True` for any of the elements it\n"
    " immediately returns `True` without checking the rest of the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert !any([], fn(x) { x > 3 })\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert any([4, 5], fn(x) { x > 3 })\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert any([4, 3], fn(x) { x > 4 })\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert any([3, 4], fn(x) { x > 3 })\n"
    " ```\n"
).
-spec any(list(AIU), fun((AIU) -> boolean())) -> boolean().
any(List, Predicate) ->
    case List of
        [] ->
            false;

        [First | Rest] ->
            case Predicate(First) of
                true ->
                    true;

                false ->
                    any(Rest, Predicate)
            end
    end.

-file("src/gleam/list.gleam", 991).
-spec zip_loop(list(AJB), list(AJD), list({AJB, AJD})) -> list({AJB, AJD}).
zip_loop(One, Other, Acc) ->
    case {One, Other} of
        {[First_one | Rest_one], [First_other | Rest_other]} ->
            zip_loop(Rest_one, Rest_other, [{First_one, First_other} | Acc]);

        {_, _} ->
            lists:reverse(Acc)
    end.

-file("src/gleam/list.gleam", 987).
?DOC(
    " Takes two lists and returns a single list of 2-element tuples.\n"
    "\n"
    " If one of the lists is longer than the other, the remaining elements from\n"
    " the longer list are not used.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert zip([], []) == []\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert zip([1, 2], [3]) == [#(1, 3)]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert zip([1], [3, 4]) == [#(1, 3)]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert zip([1, 2], [3, 4]) == [#(1, 3), #(2, 4)]\n"
    " ```\n"
).
-spec zip(list(AIW), list(AIY)) -> list({AIW, AIY}).
zip(List, Other) ->
    zip_loop(List, Other, []).

-file("src/gleam/list.gleam", 1028).
-spec strict_zip_loop(list(AJO), list(AJQ), list({AJO, AJQ})) -> {ok,
        list({AJO, AJQ})} |
    {error, nil}.
strict_zip_loop(One, Other, Acc) ->
    case {One, Other} of
        {[], []} ->
            {ok, lists:reverse(Acc)};

        {[], _} ->
            {error, nil};

        {_, []} ->
            {error, nil};

        {[First_one | Rest_one], [First_other | Rest_other]} ->
            strict_zip_loop(
                Rest_one,
                Rest_other,
                [{First_one, First_other} | Acc]
            )
    end.

-file("src/gleam/list.gleam", 1021).
?DOC(
    " Takes two lists and returns a single list of 2-element tuples.\n"
    "\n"
    " If one of the lists is longer than the other, an `Error` is returned.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert strict_zip([], []) == Ok([])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert strict_zip([1, 2], [3]) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert strict_zip([1], [3, 4]) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert strict_zip([1, 2], [3, 4]) == Ok([#(1, 3), #(2, 4)])\n"
    " ```\n"
).
-spec strict_zip(list(AJH), list(AJJ)) -> {ok, list({AJH, AJJ})} | {error, nil}.
strict_zip(List, Other) ->
    strict_zip_loop(List, Other, []).

-file("src/gleam/list.gleam", 1057).
-spec unzip_loop(list({AKB, AKC}), list(AKB), list(AKC)) -> {list(AKB),
    list(AKC)}.
unzip_loop(Input, One, Other) ->
    case Input of
        [] ->
            {lists:reverse(One), lists:reverse(Other)};

        [{First_one, First_other} | Rest] ->
            unzip_loop(Rest, [First_one | One], [First_other | Other])
    end.

-file("src/gleam/list.gleam", 1053).
?DOC(
    " Takes a single list of 2-element tuples and returns two lists.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert unzip([#(1, 2), #(3, 4)]) == #([1, 3], [2, 4])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert unzip([]) == #([], [])\n"
    " ```\n"
).
-spec unzip(list({AJW, AJX})) -> {list(AJW), list(AJX)}.
unzip(Input) ->
    unzip_loop(Input, [], []).

-file("src/gleam/list.gleam", 1090).
-spec intersperse_loop(list(AKL), AKL, list(AKL)) -> list(AKL).
intersperse_loop(List, Separator, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            intersperse_loop(Rest, Separator, [First, Separator | Acc])
    end.

-file("src/gleam/list.gleam", 1083).
?DOC(
    " Inserts a given value between each existing element in a given list.\n"
    "\n"
    " This function runs in linear time and copies the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert intersperse([1, 1, 1], 2) == [1, 2, 1, 2, 1]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert intersperse([], 2) == []\n"
    " ```\n"
).
-spec intersperse(list(AKI), AKI) -> list(AKI).
intersperse(List, Elem) ->
    case List of
        [] ->
            List;

        [_] ->
            List;

        [First | Rest] ->
            intersperse_loop(Rest, Elem, [First])
    end.

-file("src/gleam/list.gleam", 1112).
-spec unique_loop(list(AKS), gleam@dict:dict(AKS, nil), list(AKS)) -> list(AKS).
unique_loop(List, Seen, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            case gleam@dict:has_key(Seen, First) of
                true ->
                    unique_loop(Rest, Seen, Acc);

                false ->
                    unique_loop(
                        Rest,
                        gleam@dict:insert(Seen, First, nil),
                        [First | Acc]
                    )
            end
    end.

-file("src/gleam/list.gleam", 1108).
?DOC(
    " Removes any duplicate elements from a given list.\n"
    "\n"
    " This function returns in loglinear time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert unique([1, 1, 1, 4, 7, 3, 3, 4]) == [1, 4, 7, 3]\n"
    " ```\n"
).
-spec unique(list(AKP)) -> list(AKP).
unique(List) ->
    unique_loop(List, maps:new(), []).

-file("src/gleam/list.gleam", 1197).
?DOC(
    " Given a list it returns slices of it that are locally sorted in ascending\n"
    " order.\n"
    "\n"
    " Imagine you have this list:\n"
    "\n"
    " ```\n"
    "   [1, 2, 3, 2, 1, 0]\n"
    "    ^^^^^^^  ^^^^^^^ This is a slice in descending order\n"
    "    |\n"
    "    | This is a slice that is sorted in ascending order\n"
    " ```\n"
    "\n"
    " So the produced result will contain these two slices, each one sorted in\n"
    " ascending order: `[[1, 2, 3], [0, 1, 2]]`.\n"
    "\n"
    " - `growing` is an accumulator with the current slice being grown\n"
    " - `direction` is the growing direction of the slice being grown, it could\n"
    "   either be ascending or strictly descending\n"
    " - `prev` is the previous element that needs to be added to the growing slice\n"
    "   it is carried around to check whether we have to keep growing the current\n"
    "   slice or not\n"
    " - `acc` is the accumulator containing the slices sorted in ascending order\n"
).
-spec sequences(
    list(ALB),
    fun((ALB, ALB) -> gleam@order:order()),
    list(ALB),
    sorting(),
    ALB,
    list(list(ALB))
) -> list(list(ALB)).
sequences(List, Compare, Growing, Direction, Prev, Acc) ->
    Growing@1 = [Prev | Growing],
    case List of
        [] ->
            case Direction of
                ascending ->
                    [lists:reverse(Growing@1) | Acc];

                descending ->
                    [Growing@1 | Acc]
            end;

        [New | Rest] ->
            case {Compare(Prev, New), Direction} of
                {gt, descending} ->
                    sequences(Rest, Compare, Growing@1, Direction, New, Acc);

                {lt, ascending} ->
                    sequences(Rest, Compare, Growing@1, Direction, New, Acc);

                {eq, ascending} ->
                    sequences(Rest, Compare, Growing@1, Direction, New, Acc);

                {gt, ascending} ->
                    Acc@1 = case Direction of
                        ascending ->
                            [lists:reverse(Growing@1) | Acc];

                        descending ->
                            [Growing@1 | Acc]
                    end,
                    case Rest of
                        [] ->
                            [[New] | Acc@1];

                        [Next | Rest@1] ->
                            Direction@1 = case Compare(New, Next) of
                                lt ->
                                    ascending;

                                eq ->
                                    ascending;

                                gt ->
                                    descending
                            end,
                            sequences(
                                Rest@1,
                                Compare,
                                [New],
                                Direction@1,
                                Next,
                                Acc@1
                            )
                    end;

                {lt, descending} ->
                    Acc@1 = case Direction of
                        ascending ->
                            [lists:reverse(Growing@1) | Acc];

                        descending ->
                            [Growing@1 | Acc]
                    end,
                    case Rest of
                        [] ->
                            [[New] | Acc@1];

                        [Next | Rest@1] ->
                            Direction@1 = case Compare(New, Next) of
                                lt ->
                                    ascending;

                                eq ->
                                    ascending;

                                gt ->
                                    descending
                            end,
                            sequences(
                                Rest@1,
                                Compare,
                                [New],
                                Direction@1,
                                Next,
                                Acc@1
                            )
                    end;

                {eq, descending} ->
                    Acc@1 = case Direction of
                        ascending ->
                            [lists:reverse(Growing@1) | Acc];

                        descending ->
                            [Growing@1 | Acc]
                    end,
                    case Rest of
                        [] ->
                            [[New] | Acc@1];

                        [Next | Rest@1] ->
                            Direction@1 = case Compare(New, Next) of
                                lt ->
                                    ascending;

                                eq ->
                                    ascending;

                                gt ->
                                    descending
                            end,
                            sequences(
                                Rest@1,
                                Compare,
                                [New],
                                Direction@1,
                                Next,
                                Acc@1
                            )
                    end
            end
    end.

-file("src/gleam/list.gleam", 1345).
?DOC(
    " Merges two lists sorted in ascending order into a single list sorted in\n"
    " descending order according to the given comparator function.\n"
    "\n"
    " This reversing of the sort order is not avoidable if we want to implement\n"
    " merge as a tail recursive function. We could reverse the accumulator before\n"
    " returning it but that would end up being less efficient; so the merging\n"
    " algorithm has to play around this.\n"
).
-spec merge_ascendings(
    list(ALY),
    list(ALY),
    fun((ALY, ALY) -> gleam@order:order()),
    list(ALY)
) -> list(ALY).
merge_ascendings(List1, List2, Compare, Acc) ->
    case {List1, List2} of
        {[], List} ->
            lists:reverse(List, Acc);

        {List, []} ->
            lists:reverse(List, Acc);

        {[First1 | Rest1], [First2 | Rest2]} ->
            case Compare(First1, First2) of
                lt ->
                    merge_ascendings(Rest1, List2, Compare, [First1 | Acc]);

                gt ->
                    merge_ascendings(List1, Rest2, Compare, [First2 | Acc]);

                eq ->
                    merge_ascendings(List1, Rest2, Compare, [First2 | Acc])
            end
    end.

-file("src/gleam/list.gleam", 1298).
?DOC(
    " Given a list of ascending lists, it merges adjacent pairs into a single\n"
    " descending list, halving their number.\n"
    " It returns a list of the remaining descending lists.\n"
).
-spec merge_ascending_pairs(
    list(list(ALM)),
    fun((ALM, ALM) -> gleam@order:order()),
    list(list(ALM))
) -> list(list(ALM)).
merge_ascending_pairs(Sequences, Compare, Acc) ->
    case Sequences of
        [] ->
            lists:reverse(Acc);

        [Sequence] ->
            lists:reverse([lists:reverse(Sequence) | Acc]);

        [Ascending1, Ascending2 | Rest] ->
            Descending = merge_ascendings(Ascending1, Ascending2, Compare, []),
            merge_ascending_pairs(Rest, Compare, [Descending | Acc])
    end.

-file("src/gleam/list.gleam", 1372).
?DOC(
    " This is exactly the same as merge_ascendings but mirrored: it merges two\n"
    " lists sorted in descending order into a single list sorted in ascending\n"
    " order according to the given comparator function.\n"
    "\n"
    " This reversing of the sort order is not avoidable if we want to implement\n"
    " merge as a tail recursive function. We could reverse the accumulator before\n"
    " returning it but that would end up being less efficient; so the merging\n"
    " algorithm has to play around this.\n"
).
-spec merge_descendings(
    list(AMD),
    list(AMD),
    fun((AMD, AMD) -> gleam@order:order()),
    list(AMD)
) -> list(AMD).
merge_descendings(List1, List2, Compare, Acc) ->
    case {List1, List2} of
        {[], List} ->
            lists:reverse(List, Acc);

        {List, []} ->
            lists:reverse(List, Acc);

        {[First1 | Rest1], [First2 | Rest2]} ->
            case Compare(First1, First2) of
                lt ->
                    merge_descendings(List1, Rest2, Compare, [First2 | Acc]);

                gt ->
                    merge_descendings(Rest1, List2, Compare, [First1 | Acc]);

                eq ->
                    merge_descendings(Rest1, List2, Compare, [First1 | Acc])
            end
    end.

-file("src/gleam/list.gleam", 1320).
?DOC(" This is the same as merge_ascending_pairs but flipped for descending lists.\n").
-spec merge_descending_pairs(
    list(list(ALS)),
    fun((ALS, ALS) -> gleam@order:order()),
    list(list(ALS))
) -> list(list(ALS)).
merge_descending_pairs(Sequences, Compare, Acc) ->
    case Sequences of
        [] ->
            lists:reverse(Acc);

        [Sequence] ->
            lists:reverse([lists:reverse(Sequence) | Acc]);

        [Descending1, Descending2 | Rest] ->
            Ascending = merge_descendings(Descending1, Descending2, Compare, []),
            merge_descending_pairs(Rest, Compare, [Ascending | Acc])
    end.

-file("src/gleam/list.gleam", 1264).
?DOC(
    " Given some some sorted sequences (assumed to be sorted in `direction`) it\n"
    " merges them all together until we're left with just a list sorted in\n"
    " ascending order.\n"
).
-spec merge_all(
    list(list(ALI)),
    sorting(),
    fun((ALI, ALI) -> gleam@order:order())
) -> list(ALI).
merge_all(Sequences, Direction, Compare) ->
    case {Sequences, Direction} of
        {[], _} ->
            [];

        {[Sequence], ascending} ->
            Sequence;

        {[Sequence@1], descending} ->
            lists:reverse(Sequence@1);

        {_, ascending} ->
            Sequences@1 = merge_ascending_pairs(Sequences, Compare, []),
            merge_all(Sequences@1, descending, Compare);

        {_, descending} ->
            Sequences@2 = merge_descending_pairs(Sequences, Compare, []),
            merge_all(Sequences@2, ascending, Compare)
    end.

-file("src/gleam/list.gleam", 1135).
?DOC(
    " Sorts from smallest to largest based upon the ordering specified by a given\n"
    " function.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " import gleam/int\n"
    "\n"
    " assert sort([4, 3, 6, 5, 4, 1, 2], by: int.compare) == [1, 2, 3, 4, 4, 5, 6]\n"
    " ```\n"
).
-spec sort(list(AKY), fun((AKY, AKY) -> gleam@order:order())) -> list(AKY).
sort(List, Compare) ->
    case List of
        [] ->
            [];

        [X] ->
            [X];

        [X@1, Y | Rest] ->
            Direction = case Compare(X@1, Y) of
                lt ->
                    ascending;

                eq ->
                    ascending;

                gt ->
                    descending
            end,
            Sequences = sequences(Rest, Compare, [X@1], Direction, Y, []),
            merge_all(Sequences, ascending, Compare)
    end.

-file("src/gleam/list.gleam", 1394).
-spec range_loop(integer(), integer(), list(integer())) -> list(integer()).
range_loop(Start, Stop, Acc) ->
    case gleam@int:compare(Start, Stop) of
        eq ->
            [Stop | Acc];

        gt ->
            range_loop(Start, Stop + 1, [Stop | Acc]);

        lt ->
            range_loop(Start, Stop - 1, [Stop | Acc])
    end.

-file("src/gleam/list.gleam", 1390).
-spec range(integer(), integer()) -> list(integer()).
range(Start, Stop) ->
    range_loop(Start, Stop, []).

-file("src/gleam/list.gleam", 1418).
-spec repeat_loop(AMN, integer(), list(AMN)) -> list(AMN).
repeat_loop(Item, Times, Acc) ->
    case Times =< 0 of
        true ->
            Acc;

        false ->
            repeat_loop(Item, Times - 1, [Item | Acc])
    end.

-file("src/gleam/list.gleam", 1414).
?DOC(
    " Builds a list of a given value a given number of times.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert repeat(\"a\", times: 0) == []\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert repeat(\"a\", times: 5) == [\"a\", \"a\", \"a\", \"a\", \"a\"]\n"
    " ```\n"
).
-spec repeat(AML, integer()) -> list(AML).
repeat(A, Times) ->
    repeat_loop(A, Times, []).

-file("src/gleam/list.gleam", 1448).
-spec split_loop(list(AMU), integer(), list(AMU)) -> {list(AMU), list(AMU)}.
split_loop(List, N, Taken) ->
    case N =< 0 of
        true ->
            {lists:reverse(Taken), List};

        false ->
            case List of
                [] ->
                    {lists:reverse(Taken), []};

                [First | Rest] ->
                    split_loop(Rest, N - 1, [First | Taken])
            end
    end.

-file("src/gleam/list.gleam", 1444).
?DOC(
    " Splits a list in two before the given index.\n"
    "\n"
    " If the list is not long enough to have the given index the before list will\n"
    " be the input list, and the after list will be empty.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert split([6, 7, 8, 9], 0) == #([], [6, 7, 8, 9])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert split([6, 7, 8, 9], 2) == #([6, 7], [8, 9])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert split([6, 7, 8, 9], 4) == #([6, 7, 8, 9], [])\n"
    " ```\n"
).
-spec split(list(AMQ), integer()) -> {list(AMQ), list(AMQ)}.
split(List, Index) ->
    split_loop(List, Index, []).

-file("src/gleam/list.gleam", 1484).
-spec split_while_loop(list(AND), fun((AND) -> boolean()), list(AND)) -> {list(AND),
    list(AND)}.
split_while_loop(List, F, Acc) ->
    case List of
        [] ->
            {lists:reverse(Acc), []};

        [First | Rest] ->
            case F(First) of
                true ->
                    split_while_loop(Rest, F, [First | Acc]);

                false ->
                    {lists:reverse(Acc), List}
            end
    end.

-file("src/gleam/list.gleam", 1477).
?DOC(
    " Splits a list in two before the first element that a given function returns\n"
    " `False` for.\n"
    "\n"
    " If the function returns `True` for all elements the first list will be the\n"
    " input list, and the second list will be empty.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert split_while([1, 2, 3, 4, 5], fn(x) { x <= 3 })\n"
    "   == #([1, 2, 3], [4, 5])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert split_while([1, 2, 3, 4, 5], fn(x) { x <= 5 })\n"
    "   == #([1, 2, 3, 4, 5], [])\n"
    " ```\n"
).
-spec split_while(list(AMZ), fun((AMZ) -> boolean())) -> {list(AMZ), list(AMZ)}.
split_while(List, Predicate) ->
    split_while_loop(List, Predicate, []).

-file("src/gleam/list.gleam", 1521).
?DOC(
    " Given a list of 2-element tuples, finds the first tuple that has a given\n"
    " key as the first element and returns the second element.\n"
    "\n"
    " If no tuple is found with the given key then `Error(Nil)` is returned.\n"
    "\n"
    " This function may be useful for interacting with Erlang code where lists of\n"
    " tuples are common.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert key_find([#(\"a\", 0), #(\"b\", 1)], \"a\") == Ok(0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert key_find([#(\"a\", 0), #(\"b\", 1)], \"b\") == Ok(1)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert key_find([#(\"a\", 0), #(\"b\", 1)], \"c\") == Error(Nil)\n"
    " ```\n"
).
-spec key_find(list({ANI, ANJ}), ANI) -> {ok, ANJ} | {error, nil}.
key_find(Keyword_list, Desired_key) ->
    find_map(
        Keyword_list,
        fun(Keyword) ->
            {Key, Value} = Keyword,
            case Key =:= Desired_key of
                true ->
                    {ok, Value};

                false ->
                    {error, nil}
            end
        end
    ).

-file("src/gleam/list.gleam", 1550).
?DOC(
    " Given a list of 2-element tuples, finds all tuples that have a given\n"
    " key as the first element and returns the second element.\n"
    "\n"
    " This function may be useful for interacting with Erlang code where lists of\n"
    " tuples are common.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert key_filter([#(\"a\", 0), #(\"b\", 1), #(\"a\", 2)], \"a\") == [0, 2]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert key_filter([#(\"a\", 0), #(\"b\", 1)], \"c\") == []\n"
    " ```\n"
).
-spec key_filter(list({ANN, ANO}), ANN) -> list(ANO).
key_filter(Keyword_list, Desired_key) ->
    filter_map(
        Keyword_list,
        fun(Keyword) ->
            {Key, Value} = Keyword,
            case Key =:= Desired_key of
                true ->
                    {ok, Value};

                false ->
                    {error, nil}
            end
        end
    ).

-file("src/gleam/list.gleam", 1587).
-spec key_pop_loop(list({ANX, ANY}), ANX, list({ANX, ANY})) -> {ok,
        {ANY, list({ANX, ANY})}} |
    {error, nil}.
key_pop_loop(List, Key, Checked) ->
    case List of
        [] ->
            {error, nil};

        [{K, V} | Rest] when K =:= Key ->
            {ok, {V, lists:reverse(Checked, Rest)}};

        [First | Rest@1] ->
            key_pop_loop(Rest@1, Key, [First | Checked])
    end.

-file("src/gleam/list.gleam", 1583).
?DOC(
    " Given a list of 2-element tuples, finds the first tuple that has a given\n"
    " key as the first element. This function will return the second element\n"
    " of the found tuple and list with tuple removed.\n"
    "\n"
    " If no tuple is found with the given key then `Error(Nil)` is returned.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert key_pop([#(\"a\", 0), #(\"b\", 1)], \"a\") == Ok(#(0, [#(\"b\", 1)]))\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert key_pop([#(\"a\", 0), #(\"b\", 1)], \"b\") == Ok(#(1, [#(\"a\", 0)]))\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert key_pop([#(\"a\", 0), #(\"b\", 1)], \"c\") == Error(Nil)\n"
    " ```\n"
).
-spec key_pop(list({ANR, ANS}), ANR) -> {ok, {ANS, list({ANR, ANS})}} |
    {error, nil}.
key_pop(List, Key) ->
    key_pop_loop(List, Key, []).

-file("src/gleam/list.gleam", 1619).
-spec key_set_loop(list({AOI, AOJ}), AOI, AOJ, list({AOI, AOJ})) -> list({AOI,
    AOJ}).
key_set_loop(List, Key, Value, Inspected) ->
    case List of
        [{K, _} | Rest] when K =:= Key ->
            lists:reverse(Inspected, [{K, Value} | Rest]);

        [First | Rest@1] ->
            key_set_loop(Rest@1, Key, Value, [First | Inspected]);

        [] ->
            lists:reverse([{Key, Value} | Inspected])
    end.

-file("src/gleam/list.gleam", 1615).
?DOC(
    " Given a list of 2-element tuples, inserts a key and value into the list.\n"
    "\n"
    " If there was already a tuple with the key then it is replaced, otherwise it\n"
    " is added to the end of the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert key_set([#(5, 0), #(4, 1)], 4, 100) == [#(5, 0), #(4, 100)]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert key_set([#(5, 0), #(4, 1)], 1, 100) == [#(5, 0), #(4, 1), #(1, 100)]\n"
    " ```\n"
).
-spec key_set(list({AOE, AOF}), AOE, AOF) -> list({AOE, AOF}).
key_set(List, Key, Value) ->
    key_set_loop(List, Key, Value, []).

-file("src/gleam/list.gleam", 1646).
?DOC(
    " Calls a function for each element in a list, discarding the return value.\n"
    "\n"
    " Useful for calling a side effect for every item of a list.\n"
    "\n"
    " ```gleam\n"
    " import gleam/io\n"
    "\n"
    " assert each([\"1\", \"2\", \"3\"], io.println) == Nil\n"
    " // 1\n"
    " // 2\n"
    " // 3\n"
    " ```\n"
).
-spec each(list(AON), fun((AON) -> any())) -> nil.
each(List, F) ->
    case List of
        [] ->
            nil;

        [First | Rest] ->
            F(First),
            each(Rest, F)
    end.

-file("src/gleam/list.gleam", 1673).
?DOC(
    " Calls a `Result` returning function for each element in a list, discarding\n"
    " the return value. If the function returns `Error` then the iteration is\n"
    " stopped and the error is returned.\n"
    "\n"
    " Useful for calling a side effect for every item of a list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert\n"
    "   try_each(\n"
    "     over: [1, 2, 3],\n"
    "     with: function_that_might_fail,\n"
    "   )\n"
    "   == Ok(Nil)\n"
    " ```\n"
).
-spec try_each(list(AOQ), fun((AOQ) -> {ok, any()} | {error, AOT})) -> {ok, nil} |
    {error, AOT}.
try_each(List, Fun) ->
    case List of
        [] ->
            {ok, nil};

        [First | Rest] ->
            case Fun(First) of
                {ok, _} ->
                    try_each(Rest, Fun);

                {error, E} ->
                    {error, E}
            end
    end.

-file("src/gleam/list.gleam", 1705).
-spec partition_loop(list(BHT), fun((BHT) -> boolean()), list(BHT), list(BHT)) -> {list(BHT),
    list(BHT)}.
partition_loop(List, Categorise, Trues, Falses) ->
    case List of
        [] ->
            {lists:reverse(Trues), lists:reverse(Falses)};

        [First | Rest] ->
            case Categorise(First) of
                true ->
                    partition_loop(Rest, Categorise, [First | Trues], Falses);

                false ->
                    partition_loop(Rest, Categorise, Trues, [First | Falses])
            end
    end.

-file("src/gleam/list.gleam", 1698).
?DOC(
    " Partitions a list into a tuple/pair of lists\n"
    " by a given categorisation function.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " import gleam/int\n"
    "\n"
    " assert [1, 2, 3, 4, 5] |> partition(int.is_odd) == #([1, 3, 5], [2, 4])\n"
    " ```\n"
).
-spec partition(list(AOY), fun((AOY) -> boolean())) -> {list(AOY), list(AOY)}.
partition(List, Categorise) ->
    partition_loop(List, Categorise, [], []).

-file("src/gleam/list.gleam", 1782).
-spec window_loop(list(list(AQF)), list(AQF), integer()) -> list(list(AQF)).
window_loop(Acc, List, N) ->
    Window = take(List, N),
    case erlang:length(Window) =:= N of
        true ->
            window_loop([Window | Acc], drop(List, 1), N);

        false ->
            lists:reverse(Acc)
    end.

-file("src/gleam/list.gleam", 1775).
?DOC(
    " Returns a list of sliding windows.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert window([1,2,3,4,5], 3) == [[1, 2, 3], [2, 3, 4], [3, 4, 5]]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert window([1, 2], 4) == []\n"
    " ```\n"
).
-spec window(list(AQB), integer()) -> list(list(AQB)).
window(List, N) ->
    case N =< 0 of
        true ->
            [];

        false ->
            window_loop([], List, N)
    end.

-file("src/gleam/list.gleam", 1803).
?DOC(
    " Returns a list of tuples containing two contiguous elements.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert window_by_2([1,2,3,4]) == [#(1, 2), #(2, 3), #(3, 4)]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert window_by_2([1]) == []\n"
    " ```\n"
).
-spec window_by_2(list(AQL)) -> list({AQL, AQL}).
window_by_2(List) ->
    zip(List, drop(List, 1)).

-file("src/gleam/list.gleam", 1815).
?DOC(
    " Drops the first elements in a given list for which the predicate function returns `True`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert drop_while([1, 2, 3, 4], fn (x) { x < 3 }) == [3, 4]\n"
    " ```\n"
).
-spec drop_while(list(AQO), fun((AQO) -> boolean())) -> list(AQO).
drop_while(List, Predicate) ->
    case List of
        [] ->
            [];

        [First | Rest] ->
            case Predicate(First) of
                true ->
                    drop_while(Rest, Predicate);

                false ->
                    [First | Rest]
            end
    end.

-file("src/gleam/list.gleam", 1844).
-spec take_while_loop(list(AQU), fun((AQU) -> boolean()), list(AQU)) -> list(AQU).
take_while_loop(List, Predicate, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            case Predicate(First) of
                true ->
                    take_while_loop(Rest, Predicate, [First | Acc]);

                false ->
                    lists:reverse(Acc)
            end
    end.

-file("src/gleam/list.gleam", 1837).
?DOC(
    " Takes the first elements in a given list for which the predicate function returns `True`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert take_while([1, 2, 3, 2, 4], fn (x) { x < 3 }) == [1, 2]\n"
    " ```\n"
).
-spec take_while(list(AQR), fun((AQR) -> boolean())) -> list(AQR).
take_while(List, Predicate) ->
    take_while_loop(List, Predicate, []).

-file("src/gleam/list.gleam", 1876).
-spec chunk_loop(list(ARD), fun((ARD) -> ARF), ARF, list(ARD), list(list(ARD))) -> list(list(ARD)).
chunk_loop(List, F, Previous_key, Current_chunk, Acc) ->
    case List of
        [First | Rest] ->
            Key = F(First),
            case Key =:= Previous_key of
                true ->
                    chunk_loop(Rest, F, Key, [First | Current_chunk], Acc);

                false ->
                    New_acc = [lists:reverse(Current_chunk) | Acc],
                    chunk_loop(Rest, F, Key, [First], New_acc)
            end;

        [] ->
            lists:reverse([lists:reverse(Current_chunk) | Acc])
    end.

-file("src/gleam/list.gleam", 1869).
?DOC(
    " Returns a list of chunks in which\n"
    " the return value of calling `f` on each element is the same.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 2, 3, 4, 4, 6, 7, 7] |> chunk(by: fn(n) { n % 2 })\n"
    "   == [[1], [2, 2], [3], [4, 4, 6], [7, 7]]\n"
    " ```\n"
).
-spec chunk(list(AQY), fun((AQY) -> any())) -> list(list(AQY)).
chunk(List, F) ->
    case List of
        [] ->
            [];

        [First | Rest] ->
            chunk_loop(Rest, F, F(First), [First], [])
    end.

-file("src/gleam/list.gleam", 1921).
-spec sized_chunk_loop(
    list(ARP),
    integer(),
    integer(),
    list(ARP),
    list(list(ARP))
) -> list(list(ARP)).
sized_chunk_loop(List, Count, Left, Current_chunk, Acc) ->
    case List of
        [] ->
            case Current_chunk of
                [] ->
                    lists:reverse(Acc);

                Remaining ->
                    lists:reverse([lists:reverse(Remaining) | Acc])
            end;

        [First | Rest] ->
            Chunk = [First | Current_chunk],
            case Left > 1 of
                true ->
                    sized_chunk_loop(Rest, Count, Left - 1, Chunk, Acc);

                false ->
                    sized_chunk_loop(
                        Rest,
                        Count,
                        Count,
                        [],
                        [lists:reverse(Chunk) | Acc]
                    )
            end
    end.

-file("src/gleam/list.gleam", 1917).
?DOC(
    " Returns a list of chunks containing `count` elements each.\n"
    "\n"
    " If the last chunk does not have `count` elements, it is instead\n"
    " a partial chunk, with less than `count` elements.\n"
    "\n"
    " For any `count` less than 1 this function behaves as if it was set to 1.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 3, 4, 5, 6] |> sized_chunk(into: 2)\n"
    "   == [[1, 2], [3, 4], [5, 6]]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 3, 4, 5, 6, 7, 8] |> sized_chunk(into: 3)\n"
    "   == [[1, 2, 3], [4, 5, 6], [7, 8]]\n"
    " ```\n"
).
-spec sized_chunk(list(ARL), integer()) -> list(list(ARL)).
sized_chunk(List, Count) ->
    sized_chunk_loop(List, Count, Count, [], []).

-file("src/gleam/list.gleam", 1963).
?DOC(
    " This function acts similar to fold, but does not take an initial state.\n"
    " Instead, it starts from the first element in the list\n"
    " and combines it with each subsequent element in turn using the given\n"
    " function. The function is called as `fun(accumulator, current_element)`.\n"
    "\n"
    " Returns `Ok` to indicate a successful run, and `Error` if called on an\n"
    " empty list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [] |> reduce(fn(acc, x) { acc + x }) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 3, 4, 5] |> reduce(fn(acc, x) { acc + x }) == Ok(15)\n"
    " ```\n"
).
-spec reduce(list(ARW), fun((ARW, ARW) -> ARW)) -> {ok, ARW} | {error, nil}.
reduce(List, Fun) ->
    case List of
        [] ->
            {error, nil};

        [First | Rest] ->
            {ok, fold(Rest, First, Fun)}
    end.

-file("src/gleam/list.gleam", 1987).
-spec scan_loop(list(ASE), ASG, list(ASG), fun((ASG, ASE) -> ASG)) -> list(ASG).
scan_loop(List, Accumulator, Accumulated, Fun) ->
    case List of
        [] ->
            lists:reverse(Accumulated);

        [First | Rest] ->
            Next = Fun(Accumulator, First),
            scan_loop(Rest, Next, [Next | Accumulated], Fun)
    end.

-file("src/gleam/list.gleam", 1979).
?DOC(
    " Similar to `fold`, but yields the state of the accumulator at each stage.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert scan(over: [1, 2, 3], from: 100, with: fn(acc, i) { acc + i })\n"
    "   == [101, 103, 106]\n"
    " ```\n"
).
-spec scan(list(ASA), ASC, fun((ASC, ASA) -> ASC)) -> list(ASC).
scan(List, Initial, Fun) ->
    scan_loop(List, Initial, [], Fun).

-file("src/gleam/list.gleam", 2018).
?DOC(
    " Returns the last element in the given list.\n"
    "\n"
    " Returns `Error(Nil)` if the list is empty.\n"
    "\n"
    " This function runs in linear time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert last([]) == Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert last([1, 2, 3, 4, 5]) == Ok(5)\n"
    " ```\n"
).
-spec last(list(ASJ)) -> {ok, ASJ} | {error, nil}.
last(List) ->
    case List of
        [] ->
            {error, nil};

        [Last] ->
            {ok, Last};

        [_ | Rest] ->
            last(Rest)
    end.

-file("src/gleam/list.gleam", 2039).
?DOC(
    " Return unique combinations of elements in the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert combinations([1, 2, 3], 2) == [[1, 2], [1, 3], [2, 3]]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert combinations([1, 2, 3, 4], 3)\n"
    "   == [[1, 2, 3], [1, 2, 4], [1, 3, 4], [2, 3, 4]]\n"
    " ```\n"
).
-spec combinations(list(ASN), integer()) -> list(list(ASN)).
combinations(Items, N) ->
    case {N, Items} of
        {0, _} ->
            [[]];

        {_, []} ->
            [];

        {_, [First | Rest]} ->
            _pipe = Rest,
            _pipe@1 = combinations(_pipe, N - 1),
            _pipe@2 = map(
                _pipe@1,
                fun(Combination) -> [First | Combination] end
            ),
            _pipe@3 = lists:reverse(_pipe@2),
            fold(_pipe@3, combinations(Rest, N), fun(Acc, C) -> [C | Acc] end)
    end.

-file("src/gleam/list.gleam", 2064).
-spec combination_pairs_loop(list(ASU), list({ASU, ASU})) -> list({ASU, ASU}).
combination_pairs_loop(Items, Acc) ->
    case Items of
        [] ->
            lists:reverse(Acc);

        [First | Rest] ->
            First_combinations = map(Rest, fun(Other) -> {First, Other} end),
            Acc@1 = lists:reverse(First_combinations, Acc),
            combination_pairs_loop(Rest, Acc@1)
    end.

-file("src/gleam/list.gleam", 2060).
?DOC(
    " Return unique pair combinations of elements in the list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert combination_pairs([1, 2, 3]) == [#(1, 2), #(1, 3), #(2, 3)]\n"
    " ```\n"
).
-spec combination_pairs(list(ASR)) -> list({ASR, ASR}).
combination_pairs(Items) ->
    combination_pairs_loop(Items, []).

-file("src/gleam/list.gleam", 2120).
-spec take_firsts(list(list(ATO)), list(ATO), list(list(ATO))) -> {list(ATO),
    list(list(ATO))}.
take_firsts(Rows, Column, Remaining_rows) ->
    case Rows of
        [] ->
            {lists:reverse(Column), lists:reverse(Remaining_rows)};

        [[] | Rest] ->
            take_firsts(Rest, Column, Remaining_rows);

        [[First | Remaining_row] | Rest_rows] ->
            Remaining_rows@1 = [Remaining_row | Remaining_rows],
            take_firsts(Rest_rows, [First | Column], Remaining_rows@1)
    end.

-file("src/gleam/list.gleam", 2107).
-spec transpose_loop(list(list(ATH)), list(list(ATH))) -> list(list(ATH)).
transpose_loop(Rows, Columns) ->
    case Rows of
        [] ->
            lists:reverse(Columns);

        _ ->
            {Column, Rest} = take_firsts(Rows, [], []),
            case Column of
                [_ | _] ->
                    transpose_loop(Rest, [Column | Columns]);

                [] ->
                    transpose_loop(Rest, Columns)
            end
    end.

-file("src/gleam/list.gleam", 2103).
?DOC(
    " Transpose rows and columns of the list of lists.\n"
    "\n"
    " Notice: This function is not tail recursive,\n"
    " and thus may exceed stack size if called,\n"
    " with large lists (on the JavaScript target).\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert transpose([[1, 2, 3], [101, 102, 103]])\n"
    "   == [[1, 101], [2, 102], [3, 103]]\n"
    " ```\n"
).
-spec transpose(list(list(ATC))) -> list(list(ATC)).
transpose(List_of_lists) ->
    transpose_loop(List_of_lists, []).

-file("src/gleam/list.gleam", 2084).
?DOC(
    " Make a list alternating the elements from the given lists\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert interleave([[1, 2], [101, 102], [201, 202]])\n"
    "   == [1, 101, 201, 2, 102, 202]\n"
    " ```\n"
).
-spec interleave(list(list(ASY))) -> list(ASY).
interleave(List) ->
    _pipe = List,
    _pipe@1 = transpose(_pipe),
    lists:append(_pipe@1).

-file("src/gleam/list.gleam", 2153).
-spec shuffle_pair_unwrap_loop(list({float(), AUA}), list(AUA)) -> list(AUA).
shuffle_pair_unwrap_loop(List, Acc) ->
    case List of
        [] ->
            Acc;

        [Elem_pair | Enumerable] ->
            shuffle_pair_unwrap_loop(
                Enumerable,
                [erlang:element(2, Elem_pair) | Acc]
            )
    end.

-file("src/gleam/list.gleam", 2161).
-spec do_shuffle_by_pair_indexes(list({float(), AUE})) -> list({float(), AUE}).
do_shuffle_by_pair_indexes(List_of_pairs) ->
    sort(
        List_of_pairs,
        fun(A_pair, B_pair) ->
            gleam@float:compare(
                erlang:element(1, A_pair),
                erlang:element(1, B_pair)
            )
        end
    ).

-file("src/gleam/list.gleam", 2146).
?DOC(
    " Takes a list, randomly sorts all items and returns the shuffled list.\n"
    "\n"
    " This function uses `float.random` to decide the order of the elements.\n"
    "\n"
    " ## Example\n"
    "\n"
    " ```gleam\n"
    " [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] |> shuffle\n"
    " // -> [1, 6, 9, 10, 3, 8, 4, 2, 7, 5]\n"
    " ```\n"
).
-spec shuffle(list(ATX)) -> list(ATX).
shuffle(List) ->
    _pipe = List,
    _pipe@1 = fold(_pipe, [], fun(Acc, A) -> [{rand:uniform(), A} | Acc] end),
    _pipe@2 = do_shuffle_by_pair_indexes(_pipe@1),
    shuffle_pair_unwrap_loop(_pipe@2, []).

-file("src/gleam/list.gleam", 2191).
-spec max_loop(list(AUO), fun((AUO, AUO) -> gleam@order:order()), AUO) -> AUO.
max_loop(List, Compare, Max) ->
    case List of
        [] ->
            Max;

        [First | Rest] ->
            case Compare(First, Max) of
                gt ->
                    max_loop(Rest, Compare, First);

                lt ->
                    max_loop(Rest, Compare, Max);

                eq ->
                    max_loop(Rest, Compare, Max)
            end
    end.

-file("src/gleam/list.gleam", 2181).
?DOC(
    " Takes a list and a comparator, and returns the maximum element in the list\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert [1, 2, 3, 4, 5] |> list.max(int.compare) == Ok(5)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert [\"a\", \"c\", \"b\"] |> list.max(string.compare) == Ok(\"c\")\n"
    " ```\n"
).
-spec max(list(AUH), fun((AUH, AUH) -> gleam@order:order())) -> {ok, AUH} |
    {error, nil}.
max(List, Compare) ->
    case List of
        [] ->
            {error, nil};

        [First | Rest] ->
            {ok, max_loop(Rest, Compare, First)}
    end.

-file("src/gleam/list.gleam", 2272).
-spec build_reservoir_loop(
    list(AVD),
    integer(),
    gleam@dict:dict(integer(), AVD)
) -> {gleam@dict:dict(integer(), AVD), list(AVD)}.
build_reservoir_loop(List, Size, Reservoir) ->
    Reservoir_size = maps:size(Reservoir),
    case Reservoir_size >= Size of
        true ->
            {Reservoir, List};

        false ->
            case List of
                [] ->
                    {Reservoir, []};

                [First | Rest] ->
                    Reservoir@1 = gleam@dict:insert(
                        Reservoir,
                        Reservoir_size,
                        First
                    ),
                    build_reservoir_loop(Rest, Size, Reservoir@1)
            end
    end.

-file("src/gleam/list.gleam", 2268).
?DOC(
    " Builds the initial reservoir used by Algorithm L.\n"
    " This is a dictionary with keys ranging from `0` up to `n - 1` where each\n"
    " value is the corresponding element at that position in `list`.\n"
    "\n"
    " This also returns the remaining elements of `list` that didn't end up in\n"
    " the reservoir.\n"
).
-spec build_reservoir(list(AUY), integer()) -> {gleam@dict:dict(integer(), AUY),
    list(AUY)}.
build_reservoir(List, N) ->
    build_reservoir_loop(List, N, maps:new()).

-file("src/gleam/list.gleam", 2256).
-spec log_random() -> float().
log_random() ->
    Random@1 = case gleam@float:logarithm(
        rand:uniform() + 2.2250738585072014e-308
    ) of
        {ok, Random} -> Random;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"gleam/list"/utf8>>,
                        function => <<"log_random"/utf8>>,
                        line => 2257,
                        value => _assert_fail,
                        start => 55515,
                        'end' => 55586,
                        pattern_start => 55526,
                        pattern_end => 55536})
    end,
    Random@1.

-file("src/gleam/list.gleam", 2233).
-spec sample_loop(
    list(AUS),
    gleam@dict:dict(integer(), AUS),
    integer(),
    float()
) -> gleam@dict:dict(integer(), AUS).
sample_loop(List, Reservoir, N, W) ->
    Skip = begin
        Log@1 = case gleam@float:logarithm(1.0 - W) of
            {ok, Log} -> Log;
            _assert_fail ->
                erlang:error(#{gleam_error => let_assert,
                            message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                            file => <<?FILEPATH/utf8>>,
                            module => <<"gleam/list"/utf8>>,
                            function => <<"sample_loop"/utf8>>,
                            line => 2240,
                            value => _assert_fail,
                            start => 55076,
                            'end' => 55122,
                            pattern_start => 55087,
                            pattern_end => 55094})
        end,
        erlang:round(math:floor(case Log@1 of
                    +0.0 -> +0.0;
                    -0.0 -> -0.0;
                    Gleam@denominator -> log_random() / Gleam@denominator
                end))
    end,
    case drop(List, Skip) of
        [] ->
            Reservoir;

        [First | Rest] ->
            Reservoir@1 = gleam@dict:insert(
                Reservoir,
                gleam@int:random(N),
                First
            ),
            W@1 = W * math:exp(case erlang:float(N) of
                    +0.0 -> +0.0;
                    -0.0 -> -0.0;
                    Gleam@denominator@1 -> log_random() / Gleam@denominator@1
                end),
            sample_loop(Rest, Reservoir@1, N, W@1)
    end.

-file("src/gleam/list.gleam", 2215).
?DOC(
    " Returns a random sample of up to n elements from a list using reservoir\n"
    " sampling via [Algorithm L](https://en.wikipedia.org/wiki/Reservoir_sampling#Optimal:_Algorithm_L).\n"
    " Returns an empty list if the sample size is less than or equal to 0.\n"
    "\n"
    " Order is not random, only selection is.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " sample([1, 2, 3, 4, 5], 3)\n"
    " // -> [2, 4, 5]  // A random sample of 3 items\n"
    " ```\n"
).
-spec sample(list(AUP), integer()) -> list(AUP).
sample(List, N) ->
    {Reservoir, Rest} = build_reservoir(List, N),
    case gleam@dict:is_empty(Reservoir) of
        true ->
            [];

        false ->
            W = math:exp(case erlang:float(N) of
                    +0.0 -> +0.0;
                    -0.0 -> -0.0;
                    Gleam@denominator -> log_random() / Gleam@denominator
                end),
            maps:values(sample_loop(Rest, Reservoir, N, W))
    end.

-file("src/gleam/list.gleam", 1731).
-spec permutation_zip(list(APL), list(APL), list(list(APL))) -> list(list(APL)).
permutation_zip(List, Rest, Acc) ->
    case List of
        [] ->
            lists:reverse(Acc);

        [Head | Tail] ->
            permutation_prepend(
                Head,
                permutations(lists:reverse(Rest, Tail)),
                Tail,
                [Head | Rest],
                Acc
            )
    end.

-file("src/gleam/list.gleam", 1724).
?DOC(
    " Returns all the permutations of a list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert permutations([1, 2]) == [[1, 2], [2, 1]]\n"
    " ```\n"
).
-spec permutations(list(APH)) -> list(list(APH)).
permutations(List) ->
    case List of
        [] ->
            [[]];

        L ->
            permutation_zip(L, [], [])
    end.

-file("src/gleam/list.gleam", 1749).
-spec permutation_prepend(
    APS,
    list(list(APS)),
    list(APS),
    list(APS),
    list(list(APS))
) -> list(list(APS)).
permutation_prepend(El, Permutations, List_1, List_2, Acc) ->
    case Permutations of
        [] ->
            permutation_zip(List_1, List_2, Acc);

        [Head | Tail] ->
            permutation_prepend(El, Tail, List_1, List_2, [[El | Head] | Acc])
    end.
