-module(gleam@yielder).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/gleam/yielder.gleam").
-export([unfold/2, repeatedly/1, repeat/1, from_list/1, transform/3, fold/3, run/1, to_list/1, step/1, take/2, drop/2, map/2, map2/3, append/2, flatten/1, concat/1, flat_map/2, filter/2, filter_map/2, cycle/1, find/2, find_map/2, index/1, iterate/2, take_while/2, drop_while/2, scan/3, zip/2, chunk/2, sized_chunk/2, intersperse/2, any/2, all/2, group/2, reduce/2, last/1, empty/0, once/1, range/2, single/1, interleave/2, fold_until/3, try_fold/3, first/1, at/2, length/1, each/2, yield/2, prepend/2]).
-export_type([action/1, yielder/1, step/2, chunk/2, sized_chunk/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-type action(WHK) :: stop | {continue, WHK, fun(() -> action(WHK))}.

-opaque yielder(WHL) :: {yielder, fun(() -> action(WHL))}.

-type step(WHM, WHN) :: {next, WHM, WHN} | done.

-type chunk(WHO, WHP) :: {another_by,
        list(WHO),
        WHP,
        WHO,
        fun(() -> action(WHO))} |
    {last_by, list(WHO)}.

-type sized_chunk(WHQ) :: {another, list(WHQ), fun(() -> action(WHQ))} |
    {last, list(WHQ)} |
    no_more.

-file("src/gleam/yielder.gleam", 37).
-spec stop() -> action(any()).
stop() ->
    stop.

-file("src/gleam/yielder.gleam", 72).
-spec unfold_loop(WHY, fun((WHY) -> step(WHZ, WHY))) -> fun(() -> action(WHZ)).
unfold_loop(Initial, F) ->
    fun() -> case F(Initial) of
            {next, X, Acc} ->
                {continue, X, unfold_loop(Acc, F)};

            done ->
                stop
        end end.

-file("src/gleam/yielder.gleam", 62).
?DOC(
    " Creates an yielder from a given function and accumulator.\n"
    "\n"
    " The function is called on the accumulator and returns either `Done`,\n"
    " indicating the yielder has no more elements, or `Next` which contains a\n"
    " new element and accumulator. The element is yielded by the yielder and the\n"
    " new accumulator is used with the function to compute the next element in\n"
    " the sequence.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " unfold(from: 5, with: fn(n) {\n"
    "  case n {\n"
    "    0 -> Done\n"
    "    n -> Next(element: n, accumulator: n - 1)\n"
    "  }\n"
    " })\n"
    " |> to_list\n"
    " // -> [5, 4, 3, 2, 1]\n"
    " ```\n"
).
-spec unfold(WHT, fun((WHT) -> step(WHU, WHT))) -> yielder(WHU).
unfold(Initial, F) ->
    _pipe = Initial,
    _pipe@1 = unfold_loop(_pipe, F),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 94).
?DOC(
    " Creates an yielder that yields values created by calling a given function\n"
    " repeatedly.\n"
    "\n"
    " ```gleam\n"
    " repeatedly(fn() { 7 })\n"
    " |> take(3)\n"
    " |> to_list\n"
    " // -> [7, 7, 7]\n"
    " ```\n"
).
-spec repeatedly(fun(() -> WID)) -> yielder(WID).
repeatedly(F) ->
    unfold(nil, fun(_) -> {next, F(), nil} end).

-file("src/gleam/yielder.gleam", 109).
?DOC(
    " Creates an yielder that returns the same value infinitely.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " repeat(10)\n"
    " |> take(4)\n"
    " |> to_list\n"
    " // -> [10, 10, 10, 10]\n"
    " ```\n"
).
-spec repeat(WIF) -> yielder(WIF).
repeat(X) ->
    repeatedly(fun() -> X end).

-file("src/gleam/yielder.gleam", 123).
?DOC(
    " Creates an yielder that yields each element from the given list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4])\n"
    " |> to_list\n"
    " // -> [1, 2, 3, 4]\n"
    " ```\n"
).
-spec from_list(list(WIH)) -> yielder(WIH).
from_list(List) ->
    Yield = fun(Acc) -> case Acc of
            [] ->
                done;

            [Head | Tail] ->
                {next, Head, Tail}
        end end,
    unfold(List, Yield).

-file("src/gleam/yielder.gleam", 134).
-spec transform_loop(
    fun(() -> action(WIK)),
    WIM,
    fun((WIM, WIK) -> step(WIN, WIM))
) -> fun(() -> action(WIN)).
transform_loop(Continuation, State, F) ->
    fun() -> case Continuation() of
            stop ->
                stop;

            {continue, El, Next} ->
                case F(State, El) of
                    done ->
                        stop;

                    {next, Yield, Next_state} ->
                        {continue, Yield, transform_loop(Next, Next_state, F)}
                end
        end end.

-file("src/gleam/yielder.gleam", 169).
?DOC(
    " Creates an yielder from an existing yielder\n"
    " and a stateful function that may short-circuit.\n"
    "\n"
    " `f` takes arguments `acc` for current state and `el` for current element from underlying yielder,\n"
    " and returns either `Next` with yielded element and new state value, or `Done` to halt the yielder.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " Approximate implementation of `index` in terms of `transform`:\n"
    "\n"
    " ```gleam\n"
    " from_list([\"a\", \"b\", \"c\"])\n"
    " |> transform(0, fn(i, el) { Next(#(i, el), i + 1) })\n"
    " |> to_list\n"
    " // -> [#(0, \"a\"), #(1, \"b\"), #(2, \"c\")]\n"
    " ```\n"
).
-spec transform(yielder(WIR), WIT, fun((WIT, WIR) -> step(WIU, WIT))) -> yielder(WIU).
transform(Yielder, Initial, F) ->
    _pipe = transform_loop(erlang:element(2, Yielder), Initial, F),
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 204).
-spec fold_loop(fun(() -> action(WJB)), fun((WJD, WJB) -> WJD), WJD) -> WJD.
fold_loop(Continuation, F, Accumulator) ->
    case Continuation() of
        {continue, Elem, Next} ->
            fold_loop(Next, F, F(Accumulator, Elem));

        stop ->
            Accumulator
    end.

-file("src/gleam/yielder.gleam", 195).
?DOC(
    " Reduces an yielder of elements into a single value by calling a given\n"
    " function on each element in turn.\n"
    "\n"
    " If called on an yielder of infinite length then this function will never\n"
    " return.\n"
    "\n"
    " If you do not care about the end value and only wish to evaluate the\n"
    " yielder for side effects consider using the `run` function instead.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4])\n"
    " |> fold(from: 0, with: fn(acc, element) { element + acc })\n"
    " // -> 10\n"
    " ```\n"
).
-spec fold(yielder(WIY), WJA, fun((WJA, WIY) -> WJA)) -> WJA.
fold(Yielder, Initial, F) ->
    _pipe = erlang:element(2, Yielder),
    fold_loop(_pipe, F, Initial).

-file("src/gleam/yielder.gleam", 220).
?DOC(
    " Evaluates all elements emitted by the given yielder. This function is useful for when\n"
    " you wish to trigger any side effects that would occur when evaluating\n"
    " the yielder.\n"
).
-spec run(yielder(any())) -> nil.
run(Yielder) ->
    fold(Yielder, nil, fun(_, _) -> nil end).

-file("src/gleam/yielder.gleam", 238).
?DOC(
    " Evaluates an yielder and returns all the elements as a list.\n"
    "\n"
    " If called on an yielder of infinite length then this function will never\n"
    " return.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3])\n"
    " |> map(fn(x) { x * 2 })\n"
    " |> to_list\n"
    " // -> [2, 4, 6]\n"
    " ```\n"
).
-spec to_list(yielder(WJG)) -> list(WJG).
to_list(Yielder) ->
    _pipe = Yielder,
    _pipe@1 = fold(_pipe, [], fun(Acc, E) -> [E | Acc] end),
    lists:reverse(_pipe@1).

-file("src/gleam/yielder.gleam", 266).
?DOC(
    " Eagerly accesses the first value of an yielder, returning a `Next`\n"
    " that contains the first value and the rest of the yielder.\n"
    "\n"
    " If called on an empty yielder, `Done` is returned.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let assert Next(first, rest) = from_list([1, 2, 3, 4]) |> step\n"
    "\n"
    " first\n"
    " // -> 1\n"
    "\n"
    " rest |> to_list\n"
    " // -> [2, 3, 4]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " empty() |> step\n"
    " // -> Done\n"
    " ```\n"
).
-spec step(yielder(WJJ)) -> step(WJJ, yielder(WJJ)).
step(Yielder) ->
    case (erlang:element(2, Yielder))() of
        stop ->
            done;

        {continue, E, A} ->
            {next, E, {yielder, A}}
    end.

-file("src/gleam/yielder.gleam", 299).
-spec take_loop(fun(() -> action(WJR)), integer()) -> fun(() -> action(WJR)).
take_loop(Continuation, Desired) ->
    fun() -> case Desired > 0 of
            false ->
                stop;

            true ->
                case Continuation() of
                    stop ->
                        stop;

                    {continue, E, Next} ->
                        {continue, E, take_loop(Next, Desired - 1)}
                end
        end end.

-file("src/gleam/yielder.gleam", 293).
?DOC(
    " Creates an yielder that only yields the first `desired` elements.\n"
    "\n"
    " If the yielder does not have enough elements all of them are yielded.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5])\n"
    " |> take(up_to: 3)\n"
    " |> to_list\n"
    " // -> [1, 2, 3]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2])\n"
    " |> take(up_to: 3)\n"
    " |> to_list\n"
    " // -> [1, 2]\n"
    " ```\n"
).
-spec take(yielder(WJO), integer()) -> yielder(WJO).
take(Yielder, Desired) ->
    _pipe = erlang:element(2, Yielder),
    _pipe@1 = take_loop(_pipe, Desired),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 342).
-spec drop_loop(fun(() -> action(WJX)), integer()) -> action(WJX).
drop_loop(Continuation, Desired) ->
    case Continuation() of
        stop ->
            stop;

        {continue, E, Next} ->
            case Desired > 0 of
                true ->
                    drop_loop(Next, Desired - 1);

                false ->
                    {continue, E, Next}
            end
    end.

-file("src/gleam/yielder.gleam", 337).
?DOC(
    " Evaluates and discards the first N elements in an yielder, returning a new\n"
    " yielder.\n"
    "\n"
    " If the yielder does not have enough elements an empty yielder is\n"
    " returned.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5])\n"
    " |> drop(up_to: 3)\n"
    " |> to_list\n"
    " // -> [4, 5]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2])\n"
    " |> drop(up_to: 3)\n"
    " |> to_list\n"
    " // -> []\n"
    " ```\n"
).
-spec drop(yielder(WJU), integer()) -> yielder(WJU).
drop(Yielder, Desired) ->
    _pipe = fun() -> drop_loop(erlang:element(2, Yielder), Desired) end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 376).
-spec map_loop(fun(() -> action(WKE)), fun((WKE) -> WKG)) -> fun(() -> action(WKG)).
map_loop(Continuation, F) ->
    fun() -> case Continuation() of
            stop ->
                stop;

            {continue, E, Continuation@1} ->
                {continue, F(E), map_loop(Continuation@1, F)}
        end end.

-file("src/gleam/yielder.gleam", 370).
?DOC(
    " Creates an yielder from an existing yielder and a transformation function.\n"
    "\n"
    " Each element in the new yielder will be the result of calling the given\n"
    " function on the elements in the given yielder.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3])\n"
    " |> map(fn(x) { x * 2 })\n"
    " |> to_list\n"
    " // -> [2, 4, 6]\n"
    " ```\n"
).
-spec map(yielder(WKA), fun((WKA) -> WKC)) -> yielder(WKC).
map(Yielder, F) ->
    _pipe = erlang:element(2, Yielder),
    _pipe@1 = map_loop(_pipe, F),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 417).
-spec map2_loop(
    fun(() -> action(WKO)),
    fun(() -> action(WKQ)),
    fun((WKO, WKQ) -> WKS)
) -> fun(() -> action(WKS)).
map2_loop(Continuation1, Continuation2, Fun) ->
    fun() -> case Continuation1() of
            stop ->
                stop;

            {continue, A, Next_a} ->
                case Continuation2() of
                    stop ->
                        stop;

                    {continue, B, Next_b} ->
                        {continue, Fun(A, B), map2_loop(Next_a, Next_b, Fun)}
                end
        end end.

-file("src/gleam/yielder.gleam", 408).
?DOC(
    " Combines two yielders into a single one using the given function.\n"
    "\n"
    " If an yielder is longer than the other the extra elements are dropped.\n"
    "\n"
    " This function does not evaluate the elements of the two yielders, the\n"
    " computation is performed when the resulting yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let first = from_list([1, 2, 3])\n"
    " let second = from_list([4, 5, 6])\n"
    " map2(first, second, fn(x, y) { x + y }) |> to_list\n"
    " // -> [5, 7, 9]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " let first = from_list([1, 2])\n"
    " let second = from_list([\"a\", \"b\", \"c\"])\n"
    " map2(first, second, fn(i, x) { #(i, x) }) |> to_list\n"
    " // -> [#(1, \"a\"), #(2, \"b\")]\n"
    " ```\n"
).
-spec map2(yielder(WKI), yielder(WKK), fun((WKI, WKK) -> WKM)) -> yielder(WKM).
map2(Yielder1, Yielder2, Fun) ->
    _pipe = map2_loop(
        erlang:element(2, Yielder1),
        erlang:element(2, Yielder2),
        Fun
    ),
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 454).
-spec append_loop(fun(() -> action(WKY)), fun(() -> action(WKY))) -> action(WKY).
append_loop(First, Second) ->
    case First() of
        {continue, E, First@1} ->
            {continue, E, fun() -> append_loop(First@1, Second) end};

        stop ->
            Second()
    end.

-file("src/gleam/yielder.gleam", 449).
?DOC(
    " Appends two yielders, producing a new yielder.\n"
    "\n"
    " This function does not evaluate the elements of the yielders, the\n"
    " computation is performed when the resulting yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2])\n"
    " |> append(from_list([3, 4]))\n"
    " |> to_list\n"
    " // -> [1, 2, 3, 4]\n"
    " ```\n"
).
-spec append(yielder(WKU), yielder(WKU)) -> yielder(WKU).
append(First, Second) ->
    _pipe = fun() ->
        append_loop(erlang:element(2, First), erlang:element(2, Second))
    end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 481).
-spec flatten_loop(fun(() -> action(yielder(WLG)))) -> action(WLG).
flatten_loop(Flattened) ->
    case Flattened() of
        stop ->
            stop;

        {continue, It, Next_yielder} ->
            append_loop(
                erlang:element(2, It),
                fun() -> flatten_loop(Next_yielder) end
            )
    end.

-file("src/gleam/yielder.gleam", 476).
?DOC(
    " Flattens an yielder of yielders, creating a new yielder.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([[1, 2], [3, 4]])\n"
    " |> map(from_list)\n"
    " |> flatten\n"
    " |> to_list\n"
    " // -> [1, 2, 3, 4]\n"
    " ```\n"
).
-spec flatten(yielder(yielder(WLC))) -> yielder(WLC).
flatten(Yielder) ->
    _pipe = fun() -> flatten_loop(erlang:element(2, Yielder)) end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 504).
?DOC(
    " Joins a list of yielders into a single yielder.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " [[1, 2], [3, 4]]\n"
    " |> map(from_list)\n"
    " |> concat\n"
    " |> to_list\n"
    " // -> [1, 2, 3, 4]\n"
    " ```\n"
).
-spec concat(list(yielder(WLK))) -> yielder(WLK).
concat(Yielders) ->
    flatten(from_list(Yielders)).

-file("src/gleam/yielder.gleam", 526).
?DOC(
    " Creates an yielder from an existing yielder and a transformation function.\n"
    "\n"
    " Each element in the new yielder will be the result of calling the given\n"
    " function on the elements in the given yielder and then flattening the\n"
    " results.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2])\n"
    " |> flat_map(fn(x) { from_list([x, x + 1]) })\n"
    " |> to_list\n"
    " // -> [1, 2, 2, 3]\n"
    " ```\n"
).
-spec flat_map(yielder(WLO), fun((WLO) -> yielder(WLQ))) -> yielder(WLQ).
flat_map(Yielder, F) ->
    _pipe = Yielder,
    _pipe@1 = map(_pipe, F),
    flatten(_pipe@1).

-file("src/gleam/yielder.gleam", 562).
-spec filter_loop(fun(() -> action(WLW)), fun((WLW) -> boolean())) -> action(WLW).
filter_loop(Continuation, Predicate) ->
    case Continuation() of
        stop ->
            stop;

        {continue, E, Yielder} ->
            case Predicate(E) of
                true ->
                    {continue, E, fun() -> filter_loop(Yielder, Predicate) end};

                false ->
                    filter_loop(Yielder, Predicate)
            end
    end.

-file("src/gleam/yielder.gleam", 554).
?DOC(
    " Creates an yielder from an existing yielder and a predicate function.\n"
    "\n"
    " The new yielder will contain elements from the first yielder for which\n"
    " the given function returns `True`.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " import gleam/int\n"
    "\n"
    " from_list([1, 2, 3, 4])\n"
    " |> filter(int.is_even)\n"
    " |> to_list\n"
    " // -> [2, 4]\n"
    " ```\n"
).
-spec filter(yielder(WLT), fun((WLT) -> boolean())) -> yielder(WLT).
filter(Yielder, Predicate) ->
    _pipe = fun() -> filter_loop(erlang:element(2, Yielder), Predicate) end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 606).
-spec filter_map_loop(
    fun(() -> action(WMG)),
    fun((WMG) -> {ok, WMI} | {error, any()})
) -> action(WMI).
filter_map_loop(Continuation, F) ->
    case Continuation() of
        stop ->
            stop;

        {continue, E, Next} ->
            case F(E) of
                {ok, E@1} ->
                    {continue, E@1, fun() -> filter_map_loop(Next, F) end};

                {error, _} ->
                    filter_map_loop(Next, F)
            end
    end.

-file("src/gleam/yielder.gleam", 598).
?DOC(
    " Creates an yielder from an existing yielder and a transforming predicate function.\n"
    "\n"
    " The new yielder will contain elements from the first yielder for which\n"
    " the given function returns `Ok`, transformed to the value inside the `Ok`.\n"
    "\n"
    " This function does not evaluate the elements of the yielder, the\n"
    " computation is performed when the yielder is later run.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " import gleam/string\n"
    " import gleam/int\n"
    "\n"
    " \"a1b2c3d4e5f\"\n"
    " |> string.to_graphemes\n"
    " |> from_list\n"
    " |> filter_map(int.parse)\n"
    " |> to_list\n"
    " // -> [1, 2, 3, 4, 5]\n"
    " ```\n"
).
-spec filter_map(yielder(WLZ), fun((WLZ) -> {ok, WMB} | {error, any()})) -> yielder(WMB).
filter_map(Yielder, F) ->
    _pipe = fun() -> filter_map_loop(erlang:element(2, Yielder), F) end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 632).
?DOC(
    " Creates an yielder that repeats a given yielder infinitely.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2])\n"
    " |> cycle\n"
    " |> take(6)\n"
    " |> to_list\n"
    " // -> [1, 2, 1, 2, 1, 2]\n"
    " ```\n"
).
-spec cycle(yielder(WMN)) -> yielder(WMN).
cycle(Yielder) ->
    _pipe = repeat(Yielder),
    flatten(_pipe).

-file("src/gleam/yielder.gleam", 709).
-spec find_loop(fun(() -> action(WMV)), fun((WMV) -> boolean())) -> {ok, WMV} |
    {error, nil}.
find_loop(Continuation, F) ->
    case Continuation() of
        stop ->
            {error, nil};

        {continue, E, Next} ->
            case F(E) of
                true ->
                    {ok, E};

                false ->
                    find_loop(Next, F)
            end
    end.

-file("src/gleam/yielder.gleam", 701).
?DOC(
    " Finds the first element in a given yielder for which the given function returns\n"
    " `True`.\n"
    "\n"
    " Returns `Error(Nil)` if the function does not return `True` for any of the\n"
    " elements.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " find(from_list([1, 2, 3]), fn(x) { x > 2 })\n"
    " // -> Ok(3)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " find(from_list([1, 2, 3]), fn(x) { x > 4 })\n"
    " // -> Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " find(empty(), fn(_) { True })\n"
    " // -> Error(Nil)\n"
    " ```\n"
).
-spec find(yielder(WMR), fun((WMR) -> boolean())) -> {ok, WMR} | {error, nil}.
find(Haystack, Is_desired) ->
    _pipe = erlang:element(2, Haystack),
    find_loop(_pipe, Is_desired).

-file("src/gleam/yielder.gleam", 754).
-spec find_map_loop(
    fun(() -> action(WNH)),
    fun((WNH) -> {ok, WNJ} | {error, any()})
) -> {ok, WNJ} | {error, nil}.
find_map_loop(Continuation, F) ->
    case Continuation() of
        stop ->
            {error, nil};

        {continue, E, Next} ->
            case F(E) of
                {ok, E@1} ->
                    {ok, E@1};

                {error, _} ->
                    find_map_loop(Next, F)
            end
    end.

-file("src/gleam/yielder.gleam", 746).
?DOC(
    " Finds the first element in a given yielder\n"
    " for which the given function returns `Ok(new_value)`,\n"
    " then returns the wrapped `new_value`.\n"
    "\n"
    " Returns `Error(Nil)` if no such element is found.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " find_map(from_list([\"a\", \"1\", \"2\"]), int.parse)\n"
    " // -> Ok(1)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " find_map(from_list([\"a\", \"b\", \"c\"]), int.parse)\n"
    " // -> Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " find_map(from_list([]), int.parse)\n"
    " // -> Error(Nil)\n"
    " ```\n"
).
-spec find_map(yielder(WMZ), fun((WMZ) -> {ok, WNB} | {error, any()})) -> {ok,
        WNB} |
    {error, nil}.
find_map(Haystack, Is_desired) ->
    _pipe = erlang:element(2, Haystack),
    find_map_loop(_pipe, Is_desired).

-file("src/gleam/yielder.gleam", 783).
-spec index_loop(fun(() -> action(WNS)), integer()) -> fun(() -> action({WNS,
    integer()})).
index_loop(Continuation, Next) ->
    fun() -> case Continuation() of
            stop ->
                stop;

            {continue, E, Continuation@1} ->
                {continue, {E, Next}, index_loop(Continuation@1, Next + 1)}
        end end.

-file("src/gleam/yielder.gleam", 777).
?DOC(
    " Wraps values yielded from an yielder with indices, starting from 0.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([\"a\", \"b\", \"c\"]) |> index |> to_list\n"
    " // -> [#(\"a\", 0), #(\"b\", 1), #(\"c\", 2)]\n"
    " ```\n"
).
-spec index(yielder(WNP)) -> yielder({WNP, integer()}).
index(Yielder) ->
    _pipe = erlang:element(2, Yielder),
    _pipe@1 = index_loop(_pipe, 0),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 805).
?DOC(
    " Creates an yielder that infinitely applies a function to a value.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " iterate(1, fn(n) { n * 3 }) |> take(5) |> to_list\n"
    " // -> [1, 3, 9, 27, 81]\n"
    " ```\n"
).
-spec iterate(WNV, fun((WNV) -> WNV)) -> yielder(WNV).
iterate(Initial, F) ->
    unfold(Initial, fun(Element) -> {next, Element, F(Element)} end).

-file("src/gleam/yielder.gleam", 832).
-spec take_while_loop(fun(() -> action(WOA)), fun((WOA) -> boolean())) -> fun(() -> action(WOA)).
take_while_loop(Continuation, Predicate) ->
    fun() -> case Continuation() of
            stop ->
                stop;

            {continue, E, Next} ->
                case Predicate(E) of
                    false ->
                        stop;

                    true ->
                        {continue, E, take_while_loop(Next, Predicate)}
                end
        end end.

-file("src/gleam/yielder.gleam", 823).
?DOC(
    " Creates an yielder that yields elements while the predicate returns `True`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 2, 4])\n"
    " |> take_while(satisfying: fn(x) { x < 3 })\n"
    " |> to_list\n"
    " // -> [1, 2]\n"
    " ```\n"
).
-spec take_while(yielder(WNX), fun((WNX) -> boolean())) -> yielder(WNX).
take_while(Yielder, Predicate) ->
    _pipe = erlang:element(2, Yielder),
    _pipe@1 = take_while_loop(_pipe, Predicate),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 868).
-spec drop_while_loop(fun(() -> action(WOG)), fun((WOG) -> boolean())) -> action(WOG).
drop_while_loop(Continuation, Predicate) ->
    case Continuation() of
        stop ->
            stop;

        {continue, E, Next} ->
            case Predicate(E) of
                false ->
                    {continue, E, Next};

                true ->
                    drop_while_loop(Next, Predicate)
            end
    end.

-file("src/gleam/yielder.gleam", 860).
?DOC(
    " Creates an yielder that drops elements while the predicate returns `True`,\n"
    " and then yields the remaining elements.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 2, 5])\n"
    " |> drop_while(satisfying: fn(x) { x < 4 })\n"
    " |> to_list\n"
    " // -> [4, 2, 5]\n"
    " ```\n"
).
-spec drop_while(yielder(WOD), fun((WOD) -> boolean())) -> yielder(WOD).
drop_while(Yielder, Predicate) ->
    _pipe = fun() -> drop_while_loop(erlang:element(2, Yielder), Predicate) end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 906).
-spec scan_loop(fun(() -> action(WON)), fun((WOP, WON) -> WOP), WOP) -> fun(() -> action(WOP)).
scan_loop(Continuation, F, Accumulator) ->
    fun() -> case Continuation() of
            stop ->
                stop;

            {continue, El, Next} ->
                Accumulated = F(Accumulator, El),
                {continue, Accumulated, scan_loop(Next, F, Accumulated)}
        end end.

-file("src/gleam/yielder.gleam", 896).
?DOC(
    " Creates an yielder from an existing yielder and a stateful function.\n"
    "\n"
    " Specifically, this behaves like `fold`, but yields intermediate results.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " // Generate a sequence of partial sums\n"
    " from_list([1, 2, 3, 4, 5])\n"
    " |> scan(from: 0, with: fn(acc, el) { acc + el })\n"
    " |> to_list\n"
    " // -> [1, 3, 6, 10, 15]\n"
    " ```\n"
).
-spec scan(yielder(WOJ), WOL, fun((WOL, WOJ) -> WOL)) -> yielder(WOL).
scan(Yielder, Initial, F) ->
    _pipe = erlang:element(2, Yielder),
    _pipe@1 = scan_loop(_pipe, F, Initial),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 939).
-spec zip_loop(fun(() -> action(WOW)), fun(() -> action(WOY))) -> fun(() -> action({WOW,
    WOY})).
zip_loop(Left, Right) ->
    fun() -> case Left() of
            stop ->
                stop;

            {continue, El_left, Next_left} ->
                case Right() of
                    stop ->
                        stop;

                    {continue, El_right, Next_right} ->
                        {continue,
                            {El_left, El_right},
                            zip_loop(Next_left, Next_right)}
                end
        end end.

-file("src/gleam/yielder.gleam", 934).
?DOC(
    " Zips two yielders together, emitting values from both\n"
    " until the shorter one runs out.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([\"a\", \"b\", \"c\"])\n"
    " |> zip(range(20, 30))\n"
    " |> to_list\n"
    " // -> [#(\"a\", 20), #(\"b\", 21), #(\"c\", 22)]\n"
    " ```\n"
).
-spec zip(yielder(WOR), yielder(WOT)) -> yielder({WOR, WOT}).
zip(Left, Right) ->
    _pipe = zip_loop(erlang:element(2, Left), erlang:element(2, Right)),
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 1000).
-spec next_chunk(fun(() -> action(WPL)), fun((WPL) -> WPN), WPN, list(WPL)) -> chunk(WPL, WPN).
next_chunk(Continuation, F, Previous_key, Current_chunk) ->
    case Continuation() of
        stop ->
            {last_by, lists:reverse(Current_chunk)};

        {continue, E, Next} ->
            Key = F(E),
            case Key =:= Previous_key of
                true ->
                    next_chunk(Next, F, Key, [E | Current_chunk]);

                false ->
                    {another_by, lists:reverse(Current_chunk), Key, E, Next}
            end
    end.

-file("src/gleam/yielder.gleam", 987).
-spec chunk_loop(fun(() -> action(WPG)), fun((WPG) -> WPI), WPI, WPG) -> action(list(WPG)).
chunk_loop(Continuation, F, Previous_key, Previous_element) ->
    case next_chunk(Continuation, F, Previous_key, [Previous_element]) of
        {last_by, Chunk} ->
            {continue, Chunk, fun stop/0};

        {another_by, Chunk@1, Key, El, Next} ->
            {continue, Chunk@1, fun() -> chunk_loop(Next, F, Key, El) end}
    end.

-file("src/gleam/yielder.gleam", 974).
?DOC(
    " Creates an yielder that emits chunks of elements\n"
    " for which `f` returns the same value.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 2, 3, 4, 4, 6, 7, 7])\n"
    " |> chunk(by: fn(n) { n % 2 })\n"
    " |> to_list\n"
    " // -> [[1], [2, 2], [3], [4, 4, 6], [7, 7]]\n"
    " ```\n"
).
-spec chunk(yielder(WPB), fun((WPB) -> any())) -> yielder(list(WPB)).
chunk(Yielder, F) ->
    _pipe = fun() -> case (erlang:element(2, Yielder))() of
            stop ->
                stop;

            {continue, E, Next} ->
                chunk_loop(Next, F, F(E), E)
        end end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 1071).
-spec next_sized_chunk(fun(() -> action(WPZ)), integer(), list(WPZ)) -> sized_chunk(WPZ).
next_sized_chunk(Continuation, Left, Current_chunk) ->
    case Continuation() of
        stop ->
            case Current_chunk of
                [] ->
                    no_more;

                Remaining ->
                    {last, lists:reverse(Remaining)}
            end;

        {continue, E, Next} ->
            Chunk = [E | Current_chunk],
            case Left > 1 of
                false ->
                    {another, lists:reverse(Chunk), Next};

                true ->
                    next_sized_chunk(Next, Left - 1, Chunk)
            end
    end.

-file("src/gleam/yielder.gleam", 1050).
-spec sized_chunk_loop(fun(() -> action(WPV)), integer()) -> fun(() -> action(list(WPV))).
sized_chunk_loop(Continuation, Count) ->
    fun() -> case next_sized_chunk(Continuation, Count, []) of
            no_more ->
                stop;

            {last, Chunk} ->
                {continue, Chunk, fun stop/0};

            {another, Chunk@1, Next_element} ->
                {continue, Chunk@1, sized_chunk_loop(Next_element, Count)}
        end end.

-file("src/gleam/yielder.gleam", 1041).
?DOC(
    " Creates an yielder that emits chunks of given size.\n"
    "\n"
    " If the last chunk does not have `count` elements, it is yielded\n"
    " as a partial chunk, with less than `count` elements.\n"
    "\n"
    " For any `count` less than 1 this function behaves as if it was set to 1.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5, 6])\n"
    " |> sized_chunk(into: 2)\n"
    " |> to_list\n"
    " // -> [[1, 2], [3, 4], [5, 6]]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5, 6, 7, 8])\n"
    " |> sized_chunk(into: 3)\n"
    " |> to_list\n"
    " // -> [[1, 2, 3], [4, 5, 6], [7, 8]]\n"
    " ```\n"
).
-spec sized_chunk(yielder(WPR), integer()) -> yielder(list(WPR)).
sized_chunk(Yielder, Count) ->
    _pipe = erlang:element(2, Yielder),
    _pipe@1 = sized_chunk_loop(_pipe, Count),
    {yielder, _pipe@1}.

-file("src/gleam/yielder.gleam", 1131).
-spec intersperse_loop(fun(() -> action(WQG)), WQG) -> action(WQG).
intersperse_loop(Continuation, Separator) ->
    case Continuation() of
        stop ->
            stop;

        {continue, E, Next} ->
            Next_interspersed = fun() -> intersperse_loop(Next, Separator) end,
            {continue, Separator, fun() -> {continue, E, Next_interspersed} end}
    end.

-file("src/gleam/yielder.gleam", 1118).
?DOC(
    " Creates an yielder that yields the given `elem` element\n"
    " between elements emitted by the underlying yielder.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty()\n"
    " |> intersperse(with: 0)\n"
    " |> to_list\n"
    " // -> []\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1])\n"
    " |> intersperse(with: 0)\n"
    " |> to_list\n"
    " // -> [1]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5])\n"
    " |> intersperse(with: 0)\n"
    " |> to_list\n"
    " // -> [1, 0, 2, 0, 3, 0, 4, 0, 5]\n"
    " ```\n"
).
-spec intersperse(yielder(WQD), WQD) -> yielder(WQD).
intersperse(Yielder, Elem) ->
    _pipe = fun() -> case (erlang:element(2, Yielder))() of
            stop ->
                stop;

            {continue, E, Next} ->
                {continue, E, fun() -> intersperse_loop(Next, Elem) end}
        end end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 1179).
-spec any_loop(fun(() -> action(WQL)), fun((WQL) -> boolean())) -> boolean().
any_loop(Continuation, Predicate) ->
    case Continuation() of
        stop ->
            false;

        {continue, E, Next} ->
            case Predicate(E) of
                true ->
                    true;

                false ->
                    any_loop(Next, Predicate)
            end
    end.

-file("src/gleam/yielder.gleam", 1171).
?DOC(
    " Returns `True` if any element emitted by the yielder satisfies the given predicate,\n"
    " `False` otherwise.\n"
    "\n"
    " This function short-circuits once it finds a satisfying element.\n"
    "\n"
    " An empty yielder results in `False`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty()\n"
    " |> any(fn(n) { n % 2 == 0 })\n"
    " // -> False\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 5, 7, 9])\n"
    " |> any(fn(n) { n % 2 == 0 })\n"
    " // -> True\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 3, 5, 7, 9])\n"
    " |> any(fn(n) { n % 2 == 0 })\n"
    " // -> False\n"
    " ```\n"
).
-spec any(yielder(WQJ), fun((WQJ) -> boolean())) -> boolean().
any(Yielder, Predicate) ->
    _pipe = erlang:element(2, Yielder),
    any_loop(_pipe, Predicate).

-file("src/gleam/yielder.gleam", 1228).
-spec all_loop(fun(() -> action(WQP)), fun((WQP) -> boolean())) -> boolean().
all_loop(Continuation, Predicate) ->
    case Continuation() of
        stop ->
            true;

        {continue, E, Next} ->
            case Predicate(E) of
                true ->
                    all_loop(Next, Predicate);

                false ->
                    false
            end
    end.

-file("src/gleam/yielder.gleam", 1220).
?DOC(
    " Returns `True` if all elements emitted by the yielder satisfy the given predicate,\n"
    " `False` otherwise.\n"
    "\n"
    " This function short-circuits once it finds a non-satisfying element.\n"
    "\n"
    " An empty yielder results in `True`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty()\n"
    " |> all(fn(n) { n % 2 == 0 })\n"
    " // -> True\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([2, 4, 6, 8])\n"
    " |> all(fn(n) { n % 2 == 0 })\n"
    " // -> True\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([2, 4, 5, 8])\n"
    " |> all(fn(n) { n % 2 == 0 })\n"
    " // -> False\n"
    " ```\n"
).
-spec all(yielder(WQN), fun((WQN) -> boolean())) -> boolean().
all(Yielder, Predicate) ->
    _pipe = erlang:element(2, Yielder),
    all_loop(_pipe, Predicate).

-file("src/gleam/yielder.gleam", 1273).
-spec update_group_with(WRF) -> fun((gleam@option:option(list(WRF))) -> list(WRF)).
update_group_with(El) ->
    fun(Maybe_group) -> case Maybe_group of
            {some, Group} ->
                [El | Group];

            none ->
                [El]
        end end.

-file("src/gleam/yielder.gleam", 1264).
-spec group_updater(fun((WQX) -> WQY)) -> fun((gleam@dict:dict(WQY, list(WQX)), WQX) -> gleam@dict:dict(WQY, list(WQX))).
group_updater(F) ->
    fun(Groups, Elem) -> _pipe = Groups,
        gleam@dict:upsert(_pipe, F(Elem), update_group_with(Elem)) end.

-file("src/gleam/yielder.gleam", 1255).
?DOC(
    " Returns a `Dict(k, List(element))` of elements from the given yielder\n"
    " grouped with the given key function.\n"
    "\n"
    " The order within each group is preserved from the yielder.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5, 6])\n"
    " |> group(by: fn(n) { n % 3 })\n"
    " // -> dict.from_list([#(0, [3, 6]), #(1, [1, 4]), #(2, [2, 5])])\n"
    " ```\n"
).
-spec group(yielder(WQR), fun((WQR) -> WQT)) -> gleam@dict:dict(WQT, list(WQR)).
group(Yielder, Key) ->
    _pipe = Yielder,
    _pipe@1 = fold(_pipe, maps:new(), group_updater(Key)),
    gleam@dict:map_values(_pipe@1, fun(_, Group) -> lists:reverse(Group) end).

-file("src/gleam/yielder.gleam", 1303).
?DOC(
    " This function acts similar to fold, but does not take an initial state.\n"
    " Instead, it starts from the first yielded element\n"
    " and combines it with each subsequent element in turn using the given function.\n"
    " The function is called as `f(accumulator, current_element)`.\n"
    "\n"
    " Returns `Ok` to indicate a successful run, and `Error` if called on an empty yielder.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([])\n"
    " |> reduce(fn(acc, x) { acc + x })\n"
    " // -> Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4, 5])\n"
    " |> reduce(fn(acc, x) { acc + x })\n"
    " // -> Ok(15)\n"
    " ```\n"
).
-spec reduce(yielder(WRJ), fun((WRJ, WRJ) -> WRJ)) -> {ok, WRJ} | {error, nil}.
reduce(Yielder, F) ->
    case (erlang:element(2, Yielder))() of
        stop ->
            {error, nil};

        {continue, E, Next} ->
            _pipe = fold_loop(Next, F, E),
            {ok, _pipe}
    end.

-file("src/gleam/yielder.gleam", 1330).
?DOC(
    " Returns the last element in the given yielder.\n"
    "\n"
    " Returns `Error(Nil)` if the yielder is empty.\n"
    "\n"
    " This function runs in linear time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty() |> last\n"
    " // -> Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " range(1, 10) |> last\n"
    " // -> Ok(10)\n"
    " ```\n"
).
-spec last(yielder(WRN)) -> {ok, WRN} | {error, nil}.
last(Yielder) ->
    _pipe = Yielder,
    reduce(_pipe, fun(_, Elem) -> Elem end).

-file("src/gleam/yielder.gleam", 1344).
?DOC(
    " Creates an yielder that yields no elements.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty() |> to_list\n"
    " // -> []\n"
    " ```\n"
).
-spec empty() -> yielder(any()).
empty() ->
    {yielder, fun stop/0}.

-file("src/gleam/yielder.gleam", 1357).
?DOC(
    " Creates an yielder that yields exactly one element provided by calling the given function.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " once(fn() { 1 }) |> to_list\n"
    " // -> [1]\n"
    " ```\n"
).
-spec once(fun(() -> WRT)) -> yielder(WRT).
once(F) ->
    _pipe = fun() -> {continue, F(), fun stop/0} end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 657).
?DOC(
    " Creates an yielder of ints, starting at a given start int and stepping by\n"
    " one to a given end int.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " range(from: 1, to: 5) |> to_list\n"
    " // -> [1, 2, 3, 4, 5]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " range(from: 1, to: -2) |> to_list\n"
    " // -> [1, 0, -1, -2]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " range(from: 0, to: 0) |> to_list\n"
    " // -> [0]\n"
    " ```\n"
).
-spec range(integer(), integer()) -> yielder(integer()).
range(Start, Stop) ->
    case gleam@int:compare(Start, Stop) of
        eq ->
            once(fun() -> Start end);

        gt ->
            unfold(Start, fun(Current) -> case Current < Stop of
                        false ->
                            {next, Current, Current - 1};

                        true ->
                            done
                    end end);

        lt ->
            unfold(Start, fun(Current@1) -> case Current@1 > Stop of
                        false ->
                            {next, Current@1, Current@1 + 1};

                        true ->
                            done
                    end end)
    end.

-file("src/gleam/yielder.gleam", 1371).
?DOC(
    " Creates an yielder that yields the given element exactly once.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " single(1) |> to_list\n"
    " // -> [1]\n"
    " ```\n"
).
-spec single(WRV) -> yielder(WRV).
single(Elem) ->
    once(fun() -> Elem end).

-file("src/gleam/yielder.gleam", 1402).
-spec interleave_loop(fun(() -> action(WSB)), fun(() -> action(WSB))) -> action(WSB).
interleave_loop(Current, Next) ->
    case Current() of
        stop ->
            Next();

        {continue, E, Next_other} ->
            {continue, E, fun() -> interleave_loop(Next, Next_other) end}
    end.

-file("src/gleam/yielder.gleam", 1394).
?DOC(
    " Creates an yielder that alternates between the two given yielders\n"
    " until both have run out.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4])\n"
    " |> interleave(from_list([11, 12, 13, 14]))\n"
    " |> to_list\n"
    " // -> [1, 11, 2, 12, 3, 13, 4, 14]\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4])\n"
    " |> interleave(from_list([100]))\n"
    " |> to_list\n"
    " // -> [1, 100, 2, 3, 4]\n"
    " ```\n"
).
-spec interleave(yielder(WRX), yielder(WRX)) -> yielder(WRX).
interleave(Left, Right) ->
    _pipe = fun() ->
        interleave_loop(erlang:element(2, Left), erlang:element(2, Right))
    end,
    {yielder, _pipe}.

-file("src/gleam/yielder.gleam", 1446).
-spec fold_until_loop(
    fun(() -> action(WSJ)),
    fun((WSL, WSJ) -> gleam@list:continue_or_stop(WSL)),
    WSL
) -> WSL.
fold_until_loop(Continuation, F, Accumulator) ->
    case Continuation() of
        stop ->
            Accumulator;

        {continue, Elem, Next} ->
            case F(Accumulator, Elem) of
                {continue, Accumulator@1} ->
                    fold_until_loop(Next, F, Accumulator@1);

                {stop, Accumulator@2} ->
                    Accumulator@2
            end
    end.

-file("src/gleam/yielder.gleam", 1437).
?DOC(
    " Like `fold`, `fold_until` reduces an yielder of elements into a single value by calling a given\n"
    " function on each element in turn, but uses `list.ContinueOrStop` to determine\n"
    " whether or not to keep iterating.\n"
    "\n"
    " If called on an yielder of infinite length then this function will only ever\n"
    " return if the function returns `list.Stop`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " import gleam/list\n"
    "\n"
    " let f = fn(acc, e) {\n"
    "   case e {\n"
    "     _ if e < 4 -> list.Continue(e + acc)\n"
    "     _ -> list.Stop(acc)\n"
    "   }\n"
    " }\n"
    "\n"
    " from_list([1, 2, 3, 4])\n"
    " |> fold_until(from: 0, with: f)\n"
    " // -> 6\n"
    " ```\n"
).
-spec fold_until(
    yielder(WSF),
    WSH,
    fun((WSH, WSF) -> gleam@list:continue_or_stop(WSH))
) -> WSH.
fold_until(Yielder, Initial, F) ->
    _pipe = erlang:element(2, Yielder),
    fold_until_loop(_pipe, F, Initial).

-file("src/gleam/yielder.gleam", 1489).
-spec try_fold_loop(
    fun(() -> action(WSV)),
    fun((WSX, WSV) -> {ok, WSX} | {error, WSY}),
    WSX
) -> {ok, WSX} | {error, WSY}.
try_fold_loop(Continuation, F, Accumulator) ->
    case Continuation() of
        stop ->
            {ok, Accumulator};

        {continue, Elem, Next} ->
            case F(Accumulator, Elem) of
                {ok, Result} ->
                    try_fold_loop(Next, F, Result);

                {error, _} = Error ->
                    Error
            end
    end.

-file("src/gleam/yielder.gleam", 1480).
?DOC(
    " A variant of fold that might fail.\n"
    "\n"
    " The folding function should return `Result(accumulator, error)`.\n"
    " If the returned value is `Ok(accumulator)` try_fold will try the next value in the yielder.\n"
    " If the returned value is `Error(error)` try_fold will stop and return that error.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4])\n"
    " |> try_fold(0, fn(acc, i) {\n"
    "   case i < 3 {\n"
    "     True -> Ok(acc + i)\n"
    "     False -> Error(Nil)\n"
    "   }\n"
    " })\n"
    " // -> Error(Nil)\n"
    " ```\n"
).
-spec try_fold(yielder(WSN), WSP, fun((WSP, WSN) -> {ok, WSP} | {error, WSQ})) -> {ok,
        WSP} |
    {error, WSQ}.
try_fold(Yielder, Initial, F) ->
    _pipe = erlang:element(2, Yielder),
    try_fold_loop(_pipe, F, Initial).

-file("src/gleam/yielder.gleam", 1519).
?DOC(
    " Returns the first element yielded by the given yielder, if it exists,\n"
    " or `Error(Nil)` otherwise.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3]) |> first\n"
    " // -> Ok(1)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " empty() |> first\n"
    " // -> Error(Nil)\n"
    " ```\n"
).
-spec first(yielder(WTD)) -> {ok, WTD} | {error, nil}.
first(Yielder) ->
    case (erlang:element(2, Yielder))() of
        stop ->
            {error, nil};

        {continue, E, _} ->
            {ok, E}
    end.

-file("src/gleam/yielder.gleam", 1549).
?DOC(
    " Returns nth element yielded by the given yielder, where `0` means the first element.\n"
    "\n"
    " If there are not enough elements in the yielder, `Error(Nil)` is returned.\n"
    "\n"
    " For any `index` less than `0` this function behaves as if it was set to `0`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4]) |> at(2)\n"
    " // -> Ok(3)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4]) |> at(4)\n"
    " // -> Error(Nil)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " empty() |> at(0)\n"
    " // -> Error(Nil)\n"
    " ```\n"
).
-spec at(yielder(WTH), integer()) -> {ok, WTH} | {error, nil}.
at(Yielder, Index) ->
    _pipe = Yielder,
    _pipe@1 = drop(_pipe, Index),
    first(_pipe@1).

-file("src/gleam/yielder.gleam", 1577).
-spec length_loop(fun(() -> action(any())), integer()) -> integer().
length_loop(Continuation, Length) ->
    case Continuation() of
        stop ->
            Length;

        {continue, _, Next} ->
            length_loop(Next, Length + 1)
    end.

-file("src/gleam/yielder.gleam", 1572).
?DOC(
    " Counts the number of elements in the given yielder.\n"
    "\n"
    " This function has to traverse the entire yielder to count its elements,\n"
    " so it runs in linear time.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty() |> length\n"
    " // -> 0\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([1, 2, 3, 4]) |> length\n"
    " // -> 4\n"
    " ```\n"
).
-spec length(yielder(any())) -> integer().
length(Yielder) ->
    _pipe = erlang:element(2, Yielder),
    length_loop(_pipe, 0).

-file("src/gleam/yielder.gleam", 1601).
?DOC(
    " Traverse an yielder, calling a function on each element.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " empty() |> each(io.println)\n"
    " // -> Nil\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " from_list([\"Tom\", \"Malory\", \"Louis\"]) |> each(io.println)\n"
    " // -> Nil\n"
    " // Tom\n"
    " // Malory\n"
    " // Louis\n"
    " ```\n"
).
-spec each(yielder(WTP), fun((WTP) -> any())) -> nil.
each(Yielder, F) ->
    _pipe = Yielder,
    _pipe@1 = map(_pipe, F),
    run(_pipe@1).

-file("src/gleam/yielder.gleam", 1629).
?DOC(
    " Add a new element to the start of an yielder.\n"
    "\n"
    " This function is for use with `use` expressions, to replicate the behaviour\n"
    " of the `yield` keyword found in other languages.\n"
    "\n"
    " If you only need to prepend an element and don't require the `use` syntax,\n"
    " use `prepend`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let yielder = {\n"
    "   use <- yield(1)\n"
    "   use <- yield(2)\n"
    "   use <- yield(3)\n"
    "   empty()\n"
    " }\n"
    "\n"
    " yielder |> to_list\n"
    " // -> [1, 2, 3]\n"
    " ```\n"
).
-spec yield(WTS, fun(() -> yielder(WTS))) -> yielder(WTS).
yield(Element, Next) ->
    {yielder,
        fun() ->
            {continue, Element, fun() -> (erlang:element(2, Next()))() end}
        end}.

-file("src/gleam/yielder.gleam", 1644).
?DOC(
    " Add a new element to the start of an yielder.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let yielder = from_list([1, 2, 3]) |> prepend(0)\n"
    "\n"
    " yielder.to_list\n"
    " // -> [0, 1, 2, 3]\n"
    " ```\n"
).
-spec prepend(yielder(WTV), WTV) -> yielder(WTV).
prepend(Yielder, Element) ->
    yield(Element, fun() -> Yielder end).
