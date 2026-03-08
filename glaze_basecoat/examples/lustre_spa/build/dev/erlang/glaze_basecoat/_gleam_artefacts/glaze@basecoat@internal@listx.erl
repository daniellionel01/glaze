-module(glaze@basecoat@internal@listx).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/internal/listx.gleam").
-export([append3/3]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-file("src/glaze/basecoat/internal/listx.gleam", 3).
?DOC(false).
-spec append3(list(RYR), list(RYR), list(RYR)) -> list(RYR).
append3(First, Second, Tercary) ->
    lists:append(First, lists:append(Second, Tercary)).
