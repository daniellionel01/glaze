-module(lustre_dev_tools@dev@live_reload).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre_dev_tools/dev/live_reload.gleam").
-export([start/4]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-file("src/lustre_dev_tools/dev/live_reload.gleam", 17).
?DOC(false).
-spec start(
    gleam@http@request:request(mist@internal@http:connection()),
    lustre_dev_tools@project:project(),
    booklet:booklet(gleam@option:option(lustre_dev_tools@error:error())),
    group_registry:group_registry(lustre_dev_tools@dev@watcher:event())
) -> gleam@http@response:response(mist:response_data()).
start(Request, Project, Error, Watcher) ->
    mist:websocket(Request, fun(_, Message, Connection) -> case Message of
                {custom, {change, Dir, Path}} when Dir =:= erlang:element(
                    7,
                    Project
                ) ->
                    _ = begin
                        _pipe = gleam@json:object(
                            [{<<"type"/utf8>>,
                                    gleam@json:string(<<"asset-update"/utf8>>)},
                                {<<"asset"/utf8>>, gleam@json:string(Path)}]
                        ),
                        _pipe@1 = gleam@json:to_string(_pipe),
                        mist:send_text_frame(Connection, _pipe@1)
                    end,
                    mist:continue(nil);

                {custom, {change, _, _}} ->
                    _ = begin
                        _pipe@2 = gleam@json:object(
                            [{<<"type"/utf8>>,
                                    gleam@json:string(<<"reload"/utf8>>)}]
                        ),
                        _pipe@3 = gleam@json:to_string(_pipe@2),
                        mist:send_text_frame(Connection, _pipe@3)
                    end,
                    mist:continue(nil);

                {custom, styles} ->
                    _ = begin
                        _pipe@4 = gleam@json:object(
                            [{<<"type"/utf8>>,
                                    gleam@json:string(<<"asset-update"/utf8>>)},
                                {<<"asset"/utf8>>,
                                    gleam@json:string(
                                        <<(erlang:element(2, Project))/binary,
                                            ".css"/utf8>>
                                    )}]
                        ),
                        _pipe@5 = gleam@json:to_string(_pipe@4),
                        mist:send_text_frame(Connection, _pipe@5)
                    end,
                    mist:continue(nil);

                {custom, build_error} ->
                    _ = case booklet_ffi:get(Error) of
                        {some, Reason} ->
                            _pipe@6 = gleam@json:object(
                                [{<<"type"/utf8>>,
                                        gleam@json:string(<<"error"/utf8>>)},
                                    {<<"message"/utf8>>,
                                        gleam@json:string(
                                            gleam_community@ansi:strip(
                                                lustre_dev_tools@error:explain(
                                                    Reason
                                                )
                                            )
                                        )}]
                            ),
                            _pipe@7 = gleam@json:to_string(_pipe@6),
                            mist:send_text_frame(Connection, _pipe@7);

                        none ->
                            {ok, nil}
                    end,
                    mist:continue(nil);

                {binary, _} ->
                    mist:continue(nil);

                {text, _} ->
                    mist:continue(nil);

                closed ->
                    mist:stop();

                shutdown ->
                    mist:stop()
            end end, fun(Connection@1) ->
            Self = erlang:self(),
            Subject = lustre_dev_tools@dev@watcher:subscribe(Watcher, Self),
            Selector = begin
                _pipe@8 = gleam_erlang_ffi:new_selector(),
                gleam@erlang@process:select(_pipe@8, Subject)
            end,
            case booklet_ffi:get(Error) of
                {some, Reason@1} ->
                    Message@1 = gleam_community@ansi:strip(
                        lustre_dev_tools@error:explain(Reason@1)
                    ),
                    _ = begin
                        _pipe@9 = gleam@json:object(
                            [{<<"type"/utf8>>,
                                    gleam@json:string(<<"error"/utf8>>)},
                                {<<"message"/utf8>>,
                                    gleam@json:string(Message@1)}]
                        ),
                        _pipe@10 = gleam@json:to_string(_pipe@9),
                        mist:send_text_frame(Connection@1, _pipe@10)
                    end,
                    nil;

                none ->
                    nil
            end,
            {nil, {some, Selector}}
        end, fun(_) ->
            Self@1 = erlang:self(),
            lustre_dev_tools@dev@watcher:unsubscribe(Watcher, Self@1)
        end).
