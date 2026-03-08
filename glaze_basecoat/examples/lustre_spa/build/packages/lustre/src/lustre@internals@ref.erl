-module(lustre@internals@ref).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/internals/ref.gleam").
-export([from/1, equal/2, equal_lists/2]).
-export_type([ref/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type ref() :: any().

-file("src/lustre/internals/ref.gleam", 7).
?DOC(false).
-spec from(any()) -> ref().
from(Value) ->
    gleam@function:identity(Value).

-file("src/lustre/internals/ref.gleam", 11).
?DOC(false).
-spec equal(ref(), ref()) -> boolean().
equal(A, B) ->
    A =:= B.

-file("src/lustre/internals/ref.gleam", 16).
?DOC(false).
-spec equal_lists(list(ref()), list(ref())) -> boolean().
equal_lists(Xs, Ys) ->
    case {Xs, Ys} of
        {[], []} ->
            true;

        {[], _} ->
            false;

        {_, []} ->
            false;

        {[X | Xs@1], [Y | Ys@1]} ->
            case equal(X, Y) of
                true ->
                    equal_lists(Xs@1, Ys@1);

                false ->
                    false
            end
    end.
