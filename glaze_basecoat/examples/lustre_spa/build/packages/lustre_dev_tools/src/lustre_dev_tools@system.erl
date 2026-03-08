-module(lustre_dev_tools@system).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre_dev_tools/system.gleam").
-export([detect_os/0, executable_name/1, detect_arch/0, is_alpine/0, run/3, find/1, cwd/0, exit/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-file("src/lustre_dev_tools/system.gleam", 12).
?DOC(false).
-spec detect_os() -> binary().
detect_os() ->
    system_ffi:detect_os().

-file("src/lustre_dev_tools/system.gleam", 2).
?DOC(false).
-spec executable_name(binary()) -> binary().
executable_name(Name) ->
    case system_ffi:detect_os() of
        <<"win32"/utf8>> ->
            <<Name/binary, ".exe"/utf8>>;

        <<"windows"/utf8>> ->
            <<Name/binary, ".exe"/utf8>>;

        _ ->
            Name
    end.

-file("src/lustre_dev_tools/system.gleam", 17).
?DOC(false).
-spec detect_arch() -> binary().
detect_arch() ->
    system_ffi:detect_arch().

-file("src/lustre_dev_tools/system.gleam", 22).
?DOC(false).
-spec is_alpine() -> boolean().
is_alpine() ->
    system_ffi:is_alpine().

-file("src/lustre_dev_tools/system.gleam", 28).
?DOC(false).
-spec run(binary(), list(binary()), list({binary(), binary()})) -> {ok,
        binary()} |
    {error, binary()}.
run(Command, Args, Variables) ->
    system_ffi:run(Command, Args, Variables).

-file("src/lustre_dev_tools/system.gleam", 35).
?DOC(false).
-spec find(binary()) -> {ok, binary()} | {error, nil}.
find(Executable) ->
    system_ffi:find(Executable).

-file("src/lustre_dev_tools/system.gleam", 40).
?DOC(false).
-spec cwd() -> binary().
cwd() ->
    system_ffi:cwd().

-file("src/lustre_dev_tools/system.gleam", 45).
?DOC(false).
-spec exit(integer()) -> nil.
exit(Code) ->
    system_ffi:exit(Code).
