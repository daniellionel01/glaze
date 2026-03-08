-module(lustre@internals@mutable_map).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/internals/mutable_map.gleam").
-export([new/0, unsafe_get/2, get_or_compute/3, has_key/2, insert/3, delete/2, size/1, is_empty/1]).
-export_type([mutable_map/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type mutable_map(QYZ, QZA) :: any() | {gleam_phantom, QYZ, QZA}.

-file("src/lustre/internals/mutable_map.gleam", 21).
?DOC(false).
-spec new() -> mutable_map(any(), any()).
new() ->
    maps:new().

-file("src/lustre/internals/mutable_map.gleam", 26).
?DOC(false).
-spec unsafe_get(mutable_map(QZF, QZG), QZF) -> QZG.
unsafe_get(Map, Key) ->
    maps:get(Key, Map).

-file("src/lustre/internals/mutable_map.gleam", 34).
?DOC(false).
-spec get_or_compute(mutable_map(QZN, QZO), QZN, fun(() -> QZO)) -> QZO.
get_or_compute(Map, Key, Compute) ->
    case gleam@dict:get(Map, Key) of
        {ok, Value} ->
            Value;

        _ ->
            Compute()
    end.

-file("src/lustre/internals/mutable_map.gleam", 51).
?DOC(false).
-spec has_key(mutable_map(QZX, any()), QZX) -> boolean().
has_key(Map, Key) ->
    maps:is_key(Key, Map).

-file("src/lustre/internals/mutable_map.gleam", 61).
?DOC(false).
-spec insert(mutable_map(RAF, RAG), RAF, RAG) -> mutable_map(RAF, RAG).
insert(Map, Key, Value) ->
    maps:put(Key, Value, Map).

-file("src/lustre/internals/mutable_map.gleam", 79).
?DOC(false).
-spec delete(mutable_map(RAR, RAS), RAR) -> mutable_map(RAR, RAS).
delete(Map, Key) ->
    maps:remove(Key, Map).

-file("src/lustre/internals/mutable_map.gleam", 90).
?DOC(false).
-spec size(mutable_map(any(), any())) -> integer().
size(Map) ->
    maps:size(Map).

-file("src/lustre/internals/mutable_map.gleam", 94).
?DOC(false).
-spec is_empty(mutable_map(any(), any())) -> boolean().
is_empty(Map) ->
    maps:size(Map) =:= 0.
