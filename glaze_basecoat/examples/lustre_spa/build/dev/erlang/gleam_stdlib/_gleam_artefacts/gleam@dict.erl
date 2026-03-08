-module(gleam@dict).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/gleam/dict.gleam").
-export([size/1, is_empty/1, has_key/2, new/0, get/2, insert/3, from_list/1, map_values/2, take/2, delete/2, drop/2, upsert/3, fold/3, to_list/1, keys/1, values/1, filter/2, each/2, combine/3, merge/2, group/2]).
-export_type([dict/2, transient_dict/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-type dict(KO, KP) :: any() | {gleam_phantom, KO, KP}.

-type transient_dict(KQ, KR) :: any() | {gleam_phantom, KQ, KR}.

-file("src/gleam/dict.gleam", 53).
?DOC(
    " Determines the number of key-value pairs in the dict.\n"
    " This function runs in constant time and does not need to iterate the dict.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert new() |> size == 0\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert new() |> insert(\"key\", \"value\") |> size == 1\n"
    " ```\n"
).
-spec size(dict(any(), any())) -> integer().
size(Dict) ->
    maps:size(Dict).

-file("src/gleam/dict.gleam", 67).
?DOC(
    " Determines whether or not the dict is empty.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert new() |> is_empty\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !{ new() |> insert(\"b\", 1) |> is_empty }\n"
    " ```\n"
).
-spec is_empty(dict(any(), any())) -> boolean().
is_empty(Dict) ->
    maps:size(Dict) =:= 0.

-file("src/gleam/dict.gleam", 135).
?DOC(
    " Determines whether or not a value is present in the dict for a given key.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert new() |> insert(\"a\", 0) |> has_key(\"a\")\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert !{ new() |> insert(\"a\", 0) |> has_key(\"b\") }\n"
    " ```\n"
).
-spec has_key(dict(MD, any()), MD) -> boolean().
has_key(Dict, Key) ->
    maps:is_key(Key, Dict).

-file("src/gleam/dict.gleam", 146).
?DOC(" Creates a fresh dict that contains no values.\n").
-spec new() -> dict(any(), any()).
new() ->
    maps:new().

-file("src/gleam/dict.gleam", 165).
?DOC(
    " Fetches a value from a dict for a given key.\n"
    "\n"
    " The dict may not have a value for the key, so the value is wrapped in a\n"
    " `Result`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert new() |> insert(\"a\", 0) |> get(\"a\") == Ok(0)\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert new() |> insert(\"a\", 0) |> get(\"b\") == Error(Nil)\n"
    " ```\n"
).
-spec get(dict(MP, MQ), MP) -> {ok, MQ} | {error, nil}.
get(From, Get) ->
    gleam_stdlib:map_get(From, Get).

-file("src/gleam/dict.gleam", 183).
?DOC(
    " Inserts a value into the dict with the given key.\n"
    "\n"
    " If the dict already has a value for the given key then the value is\n"
    " replaced with the new value.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert new() |> insert(\"a\", 0) == from_list([#(\"a\", 0)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert new() |> insert(\"a\", 0) |> insert(\"a\", 5) == from_list([#(\"a\", 5)])\n"
    " ```\n"
).
-spec insert(dict(MV, MW), MV, MW) -> dict(MV, MW).
insert(Dict, Key, Value) ->
    maps:put(Key, Value, Dict).

-file("src/gleam/dict.gleam", 111).
-spec from_list_loop(transient_dict(LW, LX), list({LW, LX})) -> dict(LW, LX).
from_list_loop(Transient, List) ->
    case List of
        [] ->
            gleam_stdlib:identity(Transient);

        [{Key, Value} | Rest] ->
            from_list_loop(maps:put(Key, Value, Transient), Rest)
    end.

-file("src/gleam/dict.gleam", 107).
?DOC(
    " Converts a list of 2-element tuples `#(key, value)` to a dict.\n"
    "\n"
    " If two tuples have the same key the last one in the list will be the one\n"
    " that is present in the dict.\n"
).
-spec from_list(list({LR, LS})) -> dict(LR, LS).
from_list(List) ->
    maps:from_list(List).

-file("src/gleam/dict.gleam", 210).
?DOC(
    " Updates all values in a given dict by calling a given function on each key\n"
    " and value.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(3, 3), #(2, 4)])\n"
    "   |> map_values(fn(key, value) { key * value })\n"
    "   == from_list([#(3, 9), #(2, 8)])\n"
    " ```\n"
).
-spec map_values(dict(NN, NO), fun((NN, NO) -> NR)) -> dict(NN, NR).
map_values(Dict, Fun) ->
    maps:map(Fun, Dict).

-file("src/gleam/dict.gleam", 313).
-spec do_take_loop(dict(PL, PM), list(PL), transient_dict(PL, PM)) -> dict(PL, PM).
do_take_loop(Dict, Desired_keys, Acc) ->
    case Desired_keys of
        [] ->
            gleam_stdlib:identity(Acc);

        [Key | Rest] ->
            case gleam_stdlib:map_get(Dict, Key) of
                {ok, Value} ->
                    do_take_loop(Dict, Rest, maps:put(Key, Value, Acc));

                {error, _} ->
                    do_take_loop(Dict, Rest, Acc)
            end
    end.

-file("src/gleam/dict.gleam", 304).
?DOC(
    " Creates a new dict from a given dict, only including any entries for which the\n"
    " keys are in a given list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    "   |> take([\"b\"])\n"
    "   == from_list([#(\"b\", 1)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    "   |> take([\"a\", \"b\", \"c\"])\n"
    "   == from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    " ```\n"
).
-spec take(dict(OX, OY), list(OX)) -> dict(OX, OY).
take(Dict, Desired_keys) ->
    maps:with(Desired_keys, Dict).

-file("src/gleam/dict.gleam", 361).
?DOC(
    " Creates a new dict from a given dict with all the same entries except for the\n"
    " one with a given key, if it exists.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> delete(\"a\")\n"
    "   == from_list([#(\"b\", 1)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> delete(\"c\")\n"
    "   == from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    " ```\n"
).
-spec delete(dict(QC, QD), QC) -> dict(QC, QD).
delete(Dict, Key) ->
    _pipe = gleam_stdlib:identity(Dict),
    _pipe@1 = maps:remove(Key, _pipe),
    gleam_stdlib:identity(_pipe@1).

-file("src/gleam/dict.gleam", 398).
-spec drop_loop(transient_dict(RC, RD), list(RC)) -> dict(RC, RD).
drop_loop(Transient, Disallowed_keys) ->
    case Disallowed_keys of
        [] ->
            gleam_stdlib:identity(Transient);

        [Key | Rest] ->
            drop_loop(maps:remove(Key, Transient), Rest)
    end.

-file("src/gleam/dict.gleam", 389).
?DOC(
    " Creates a new dict from a given dict with all the same entries except any with\n"
    " keys found in a given list.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> drop([\"a\"])\n"
    "   == from_list([#(\"b\", 1)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> drop([\"c\"])\n"
    "   == from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> drop([\"a\", \"b\", \"c\"])\n"
    "   == from_list([])\n"
    " ```\n"
).
-spec drop(dict(QO, QP), list(QO)) -> dict(QO, QP).
drop(Dict, Disallowed_keys) ->
    maps:without(Disallowed_keys, Dict).

-file("src/gleam/dict.gleam", 431).
?DOC(
    " Creates a new dict with one entry inserted or updated using a given function.\n"
    "\n"
    " If there was not an entry in the dict for the given key then the function\n"
    " gets `None` as its argument, otherwise it gets `Some(value)`.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let dict = from_list([#(\"a\", 0)])\n"
    " let increment = fn(x) {\n"
    "   case x {\n"
    "     Some(i) -> i + 1\n"
    "     None -> 0\n"
    "   }\n"
    " }\n"
    "\n"
    " assert upsert(dict, \"a\", increment) == from_list([#(\"a\", 1)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert upsert(dict, \"b\", increment) == from_list([#(\"a\", 0), #(\"b\", 0)])\n"
    " ```\n"
).
-spec upsert(dict(RJ, RK), RJ, fun((gleam@option:option(RK)) -> RK)) -> dict(RJ, RK).
upsert(Dict, Key, Fun) ->
    case gleam_stdlib:map_get(Dict, Key) of
        {ok, Value} ->
            insert(Dict, Key, Fun({some, Value}));

        {error, _} ->
            insert(Dict, Key, Fun(none))
    end.

-file("src/gleam/dict.gleam", 469).
?DOC(
    " Combines all entries into a single value by calling a given function on each\n"
    " one.\n"
    "\n"
    " Dicts are not ordered so the values are not returned in any specific order. Do\n"
    " not write code that relies on the order entries are used by this function\n"
    " as it may change in later versions of Gleam or Erlang.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let dict = from_list([#(\"a\", 1), #(\"b\", 3), #(\"c\", 9)])\n"
    " assert fold(dict, 0, fn(accumulator, key, value) { accumulator + value })\n"
    "   == 13\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " import gleam/string\n"
    "\n"
    " let dict = from_list([#(\"a\", 1), #(\"b\", 3), #(\"c\", 9)])\n"
    " assert\n"
    "   fold(dict, \"\", fn(accumulator, key, value) {\n"
    "     string.append(accumulator, key)\n"
    "   })\n"
    "   == \"abc\"\n"
    " ```\n"
).
-spec fold(dict(RQ, RR), RU, fun((RU, RQ, RR) -> RU)) -> RU.
fold(Dict, Initial, Fun) ->
    Fun@1 = fun(Key, Value, Acc) -> Fun(Acc, Key, Value) end,
    maps:fold(Fun@1, Initial, Dict).

-file("src/gleam/dict.gleam", 97).
?DOC(
    " Converts the dict to a list of 2-element tuples `#(key, value)`, one for\n"
    " each key-value pair in the dict.\n"
    "\n"
    " The tuples in the list have no specific order.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " Calling `to_list` on an empty `dict` returns an empty list.\n"
    "\n"
    " ```gleam\n"
    " assert new() |> to_list == []\n"
    " ```\n"
    "\n"
    " The ordering of elements in the resulting list is an implementation detail\n"
    " that should not be relied upon.\n"
    "\n"
    " ```gleam\n"
    " assert new()\n"
    "   |> insert(\"b\", 1)\n"
    "   |> insert(\"a\", 0)\n"
    "   |> insert(\"c\", 2)\n"
    "   |> to_list\n"
    "   == [#(\"a\", 0), #(\"b\", 1), #(\"c\", 2)]\n"
    " ```\n"
).
-spec to_list(dict(LM, LN)) -> list({LM, LN}).
to_list(Dict) ->
    maps:to_list(Dict).

-file("src/gleam/dict.gleam", 230).
?DOC(
    " Gets a list of all keys in a given dict.\n"
    "\n"
    " Dicts are not ordered so the keys are not returned in any specific order. Do\n"
    " not write code that relies on the order keys are returned by this function\n"
    " as it may change in later versions of Gleam or Erlang.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> keys == [\"a\", \"b\"]\n"
    " ```\n"
).
-spec keys(dict(OB, any())) -> list(OB).
keys(Dict) ->
    maps:keys(Dict).

-file("src/gleam/dict.gleam", 247).
?DOC(
    " Gets a list of all values in a given dict.\n"
    "\n"
    " Dicts are not ordered so the values are not returned in any specific order. Do\n"
    " not write code that relies on the order values are returned by this function\n"
    " as it may change in later versions of Gleam or Erlang.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)]) |> values == [0, 1]\n"
    " ```\n"
).
-spec values(dict(any(), OH)) -> list(OH).
values(Dict) ->
    maps:values(Dict).

-file("src/gleam/dict.gleam", 268).
?DOC(
    " Creates a new dict from a given dict, minus any entries that a given function\n"
    " returns `False` for.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    "   |> filter(fn(key, value) { value != 0 })\n"
    "   == from_list([#(\"b\", 1)])\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " assert from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    "   |> filter(fn(key, value) { True })\n"
    "   == from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    " ```\n"
).
-spec filter(dict(OL, OM), fun((OL, OM) -> boolean())) -> dict(OL, OM).
filter(Dict, Predicate) ->
    maps:filter(Predicate, Dict).

-file("src/gleam/dict.gleam", 504).
?DOC(
    " Calls a function for each key and value in a dict, discarding the return\n"
    " value.\n"
    "\n"
    " Useful for producing a side effect for every item of a dict.\n"
    "\n"
    " ```gleam\n"
    " import gleam/io\n"
    "\n"
    " let dict = from_list([#(\"a\", \"apple\"), #(\"b\", \"banana\"), #(\"c\", \"cherry\")])\n"
    "\n"
    " assert\n"
    "   each(dict, fn(k, v) {\n"
    "     io.println(k <> \" => \" <> v)\n"
    "   })\n"
    "   == Nil\n"
    " // a => apple\n"
    " // b => banana\n"
    " // c => cherry\n"
    " ```\n"
    "\n"
    " The order of elements in the iteration is an implementation detail that\n"
    " should not be relied upon.\n"
).
-spec each(dict(SA, SB), fun((SA, SB) -> any())) -> nil.
each(Dict, Fun) ->
    fold(
        Dict,
        nil,
        fun(Nil, K, V) ->
            Fun(K, V),
            Nil
        end
    ).

-file("src/gleam/dict.gleam", 525).
?DOC(
    " Creates a new dict from a pair of given dicts by combining their entries.\n"
    "\n"
    " If there are entries with the same keys in both dicts the given function is\n"
    " used to determine the new value to use in the resulting dict.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let a = from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    " let b = from_list([#(\"a\", 2), #(\"c\", 3)])\n"
    " assert combine(a, b, fn(one, other) { one + other })\n"
    "   == from_list([#(\"a\", 2), #(\"b\", 1), #(\"c\", 3)])\n"
    " ```\n"
).
-spec combine(dict(SF, SG), dict(SF, SG), fun((SG, SG) -> SG)) -> dict(SF, SG).
combine(Dict, Other, Fun) ->
    maps:merge_with(fun(_, L, R) -> Fun(L, R) end, Dict, Other).

-file("src/gleam/dict.gleam", 342).
?DOC(
    " Creates a new dict from a pair of given dicts by combining their entries.\n"
    "\n"
    " If there are entries with the same keys in both dicts the entry from the\n"
    " second dict takes precedence.\n"
    "\n"
    " ## Examples\n"
    "\n"
    " ```gleam\n"
    " let a = from_list([#(\"a\", 0), #(\"b\", 1)])\n"
    " let b = from_list([#(\"b\", 2), #(\"c\", 3)])\n"
    " assert merge(a, b) == from_list([#(\"a\", 0), #(\"b\", 2), #(\"c\", 3)])\n"
    " ```\n"
).
-spec merge(dict(PU, PV), dict(PU, PV)) -> dict(PU, PV).
merge(Dict, New_entries) ->
    maps:merge(Dict, New_entries).

-file("src/gleam/dict.gleam", 566).
-spec group_loop(transient_dict(TH, list(TI)), fun((TI) -> TH), list(TI)) -> dict(TH, list(TI)).
group_loop(Transient, To_key, List) ->
    case List of
        [] ->
            gleam_stdlib:identity(Transient);

        [Value | Rest] ->
            Key = To_key(Value),
            Update = fun(Existing) -> [Value | Existing] end,
            _pipe = Transient,
            _pipe@1 = maps:update_with(Key, Update, [Value], _pipe),
            group_loop(_pipe@1, To_key, Rest)
    end.

-file("src/gleam/dict.gleam", 562).
?DOC(false).
-spec group(fun((TB) -> TC), list(TB)) -> dict(TC, list(TB)).
group(Key, List) ->
    group_loop(gleam_stdlib:identity(maps:new()), Key, List).
