-module(snag).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/snag.gleam").
-export([new/1, error/1, layer/2, context/2, map_error/2, replace_error/2, pretty_print/1, line_print/1]).
-export_type([snag/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-type snag() :: {snag, binary(), list(binary())}.

-file("src/snag.gleam", 39).
?DOC(
    " Create a new `Snag` with the given issue text.\n"
    "\n"
    " See also the `error` function for creating a `Snag` wrapped in a `Result`.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " new(\"Not enough credit\")\n"
    " |> line_print\n"
    " // -> \"error: Not enough credit\"\n"
    " ```\n"
).
-spec new(binary()) -> snag().
new(Issue) ->
    {snag, Issue, []}.

-file("src/snag.gleam", 51).
?DOC(
    " Create a new `Snag` wrapped in a `Result` with the given issue text.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " error(\"Not enough credit\")\n"
    " // -> Error(new(\"Not enough credit\"))\n"
    " ```\n"
).
-spec error(binary()) -> {ok, any()} | {error, snag()}.
error(Issue) ->
    {error, new(Issue)}.

-file("src/snag.gleam", 68).
?DOC(
    " Add additional contextual information to a `Snag`.\n"
    "\n"
    " See also the `context` function for adding contextual information to a `Snag`\n"
    " wrapped in a `Result`.\n"
    "\n"
    " # Example\n"
    "\n"
    " ```gleam\n"
    " new(\"Not enough credit\")\n"
    " |> layer(\"Unable to make purchase\")\n"
    " |> line_print\n"
    " // -> \"error: Unable to make purchase <- Not enough credit\"\n"
    " ```\n"
).
-spec layer(snag(), binary()) -> snag().
layer(Snag, Issue) ->
    {snag, Issue, [erlang:element(2, Snag) | erlang:element(3, Snag)]}.

-file("src/snag.gleam", 82).
?DOC(
    " Add additional contextual information to a `Snag` wrapped in a `Result`.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " error(\"Not enough credit\")\n"
    " |> context(\"Unable to make purchase\")\n"
    " |> result.map_error(line_print)\n"
    " // -> Error(\"error: Unable to make purchase <- Not enough credit\")\n"
    " ```\n"
).
-spec context({ok, FRG} | {error, snag()}, binary()) -> {ok, FRG} |
    {error, snag()}.
context(Result, Issue) ->
    case Result of
        {ok, _} ->
            Result;

        {error, Snag} ->
            {error, layer(Snag, Issue)}
    end.

-file("src/snag.gleam", 104).
?DOC(
    " Map the error type in a `Result` to a `Snag` with the given describing\n"
    " function.\n"
    "\n"
    " The describing function should produce a human friendly text\n"
    " reprensentation of the error.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " my_app.read_file(\"api_key.txt\")\n"
    " |> snag.map_error(my_app.describe_error)\n"
    " |> snag.context(\"Could not load API key\")\n"
    " |> snag.line_print\n"
    " // -> \"error: Could not load API key <- File is locked\"\n"
    " ```\n"
).
-spec map_error({ok, FRJ} | {error, FRK}, fun((FRK) -> binary())) -> {ok, FRJ} |
    {error, snag()}.
map_error(Result, Describer) ->
    case Result of
        {ok, A} ->
            {ok, A};

        {error, B} ->
            _pipe = Describer(B),
            error(_pipe)
    end.

-file("src/snag.gleam", 130).
?DOC(
    " Replace the error type in a `Result` with a `Snag` with the given\n"
    " issue text.\n"
    "\n"
    " This is especially useful for converting functions that return a `Nil`\n"
    " error into a `Snag`. Always prefer using the `map_error` function for\n"
    " non `Nil` errors when possible.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " dict.get(users, \"user_id\")\n"
    " |> snag.replace_error(\"User not found in dict\")\n"
    " |> snag.context(\"Could not get user data\")\n"
    " |> snag.line_print\n"
    " // -> \"error: Could not get user data <- User not found in dict\"\n"
    " ```\n"
).
-spec replace_error({ok, FRO} | {error, any()}, binary()) -> {ok, FRO} |
    {error, snag()}.
replace_error(Result, Issue) ->
    case Result of
        {ok, A} ->
            {ok, A};

        {error, _} ->
            error(Issue)
    end.

-file("src/snag.gleam", 165).
-spec pretty_print_cause(list(binary())) -> binary().
pretty_print_cause(Cause) ->
    _pipe = Cause,
    _pipe@1 = gleam@list:index_map(
        _pipe,
        fun(Line, Index) ->
            gleam@string:concat(
                [<<"  "/utf8>>,
                    gleam@int:to_string(Index),
                    <<": "/utf8>>,
                    Line,
                    <<"\n"/utf8>>]
            )
        end
    ),
    gleam@string:concat(_pipe@1).

-file("src/snag.gleam", 156).
?DOC(
    " Turn a snag into a multi-line string, optimised for readability.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " new(\"Not enough credit\")\n"
    " |> layer(\"Unable to make purchase\")\n"
    " |> layer(\"Character creation failed\")\n"
    " |> pretty_print\n"
    " // -> \"error: Character creation failed\n"
    " //\n"
    " // cause:\n"
    " //   0: Unable to make purchase\n"
    " //   1: Not enough credit\n"
    " // \"\n"
    " ```\n"
).
-spec pretty_print(snag()) -> binary().
pretty_print(Snag) ->
    Output = <<<<"error: "/utf8, (erlang:element(2, Snag))/binary>>/binary,
        "\n"/utf8>>,
    case erlang:element(3, Snag) of
        [] ->
            Output;

        Cause ->
            <<<<Output/binary, "\ncause:\n"/utf8>>/binary,
                (pretty_print_cause(Cause))/binary>>
    end.

-file("src/snag.gleam", 185).
?DOC(
    " Turn a snag into a single-line string, optimised for compactness. This may be\n"
    " useful for logging snags.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " new(\"Not enough credit\")\n"
    " |> layer(\"Unable to make purchase\")\n"
    " |> layer(\"Character creation failed\")\n"
    " |> line_print\n"
    " // -> \"error: Character creation failed <- Unable to make purchase <- Not enough credit\"\n"
    " ```\n"
).
-spec line_print(snag()) -> binary().
line_print(Snag) ->
    _pipe = [gleam@string:append(<<"error: "/utf8>>, erlang:element(2, Snag)) |
        erlang:element(3, Snag)],
    gleam@string:join(_pipe, <<" <- "/utf8>>).
