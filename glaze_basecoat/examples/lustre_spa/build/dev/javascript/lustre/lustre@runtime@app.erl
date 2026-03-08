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

-type app(VSP, VSQ, VSR) :: {app,
        gleam@option:option(gleam@erlang@process:name(lustre@runtime@server@runtime:message(VSR))),
        fun((VSP) -> {VSQ, lustre@effect:effect(VSR)}),
        fun((VSQ, VSR) -> {VSQ, lustre@effect:effect(VSR)}),
        fun((VSQ) -> lustre@vdom@vnode:element(VSR)),
        config(VSR)}.

-type config(VSS) :: {config,
        boolean(),
        boolean(),
        boolean(),
        list({binary(), fun((binary()) -> {ok, VSS} | {error, nil})}),
        list({binary(), gleam@dynamic@decode:decoder(VSS)}),
        list({binary(), gleam@dynamic@decode:decoder(VSS)}),
        boolean(),
        gleam@option:option(fun((binary()) -> VSS)),
        gleam@option:option(VSS),
        gleam@option:option(fun((binary()) -> VSS)),
        gleam@option:option(VSS),
        gleam@option:option(VSS),
        gleam@option:option(VSS)}.

-type option(VST) :: {option, fun((config(VST)) -> config(VST))}.

-file("src/lustre/runtime/app.gleam", 75).
?DOC(false).
-spec configure_server_component(config(VSY)) -> lustre@runtime@server@runtime:config(VSY).
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
-spec configure(list(option(VSU))) -> config(VSU).
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
