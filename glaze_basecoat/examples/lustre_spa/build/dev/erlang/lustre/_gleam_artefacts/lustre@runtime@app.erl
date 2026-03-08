-module(lustre@runtime@app).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/runtime/app.gleam").
-export([configure_server_component/1, configure/1]).
-export_type([app/3, config/1, option/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type app(MBZ, MCA, MCB) :: {app,
        gleam@option:option(gleam@erlang@process:name(lustre@runtime@server@runtime:message(MCB))),
        fun((MBZ) -> {MCA, lustre@effect:effect(MCB)}),
        fun((MCA, MCB) -> {MCA, lustre@effect:effect(MCB)}),
        fun((MCA) -> lustre@vdom@vnode:element(MCB)),
        config(MCB)}.

-type config(MCC) :: {config,
        boolean(),
        boolean(),
        boolean(),
        list({binary(), fun((binary()) -> {ok, MCC} | {error, nil})}),
        list({binary(), gleam@dynamic@decode:decoder(MCC)}),
        list({binary(), gleam@dynamic@decode:decoder(MCC)}),
        boolean(),
        gleam@option:option(fun((binary()) -> MCC)),
        gleam@option:option(MCC),
        gleam@option:option(fun((binary()) -> MCC)),
        gleam@option:option(MCC),
        gleam@option:option(MCC),
        gleam@option:option(MCC)}.

-type option(MCD) :: {option, fun((config(MCD)) -> config(MCD))}.

-file("src/lustre/runtime/app.gleam", 75).
?DOC(false).
-spec configure_server_component(config(MCI)) -> lustre@runtime@server@runtime:config(MCI).
configure_server_component(Config) ->
    {config,
        erlang:element(2, Config),
        erlang:element(3, Config),
        maps:from_list(lists:reverse(erlang:element(5, Config))),
        maps:from_list(lists:reverse(erlang:element(6, Config))),
        maps:from_list(lists:reverse(erlang:element(7, Config))),
        erlang:element(12, Config),
        erlang:element(14, Config)}.

-file("src/lustre/runtime/app.gleam", 71).
?DOC(false).
-spec configure(list(option(MCE))) -> config(MCE).
configure(Options) ->
    gleam@list:fold(
        Options,
        {config,
            true,
            true,
            false,
            [],
            [],
            [],
            false,
            none,
            none,
            none,
            none,
            none,
            none},
        fun(Config, Option) -> (erlang:element(2, Option))(Config) end
    ).
