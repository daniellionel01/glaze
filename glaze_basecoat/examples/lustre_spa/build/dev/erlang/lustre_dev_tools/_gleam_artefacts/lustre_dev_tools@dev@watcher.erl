-module(lustre_dev_tools@dev@watcher).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre_dev_tools/dev/watcher.gleam").
-export([subscribe/2, unsubscribe/2, start/5]).
-export_type([mode/0, event/0, build_state/0, build_message/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type mode() :: events | polling.

-type event() :: {change, binary(), binary()} | styles | build_error.

-type build_state() :: {waiting, gleam@erlang@process:subject(build_message())} |
    {buffering,
        gleam@erlang@process:subject(build_message()),
        gleam@erlang@process:timer()} |
    {building,
        gleam@erlang@process:subject(build_message()),
        binary(),
        binary(),
        gleam@option:option({binary(), binary()})}.

-type build_message() :: {build_finished,
        {ok, nil} | {error, lustre_dev_tools@error:error()}} |
    {file_changed, binary(), binary()} |
    {timer_completed, binary(), binary()}.

-file("src/lustre_dev_tools/dev/watcher.gleam", 109).
?DOC(false).
-spec start_bun_watcher(
    lustre_dev_tools@project:project(),
    list(binary()),
    gleam@option:option(binary()),
    gleam@erlang@process:subject(build_message())
) -> {ok, gleam@erlang@process:subject(lustre_dev_tools@port:message())} |
    {error, lustre_dev_tools@error:error()}.
start_bun_watcher(Project, Watch, Tailwind_entry, Builder) ->
    lustre_dev_tools@bin@bun:watch(
        Project,
        Watch,
        fun(Dir, Path) -> case {some, Path} =:= Tailwind_entry of
                true ->
                    nil;

                false ->
                    gleam@erlang@process:send(
                        Builder,
                        {file_changed, Dir, Path}
                    )
            end end
    ).

-file("src/lustre_dev_tools/dev/watcher.gleam", 123).
?DOC(false).
-spec start_polly_watcher(
    list(binary()),
    gleam@option:option(binary()),
    gleam@erlang@process:subject(build_message())
) -> {ok, polly:watcher()} | {error, list({binary(), simplifile:file_error()})}.
start_polly_watcher(Watch, Tailwind_entry, Builder) ->
    {First@1, Rest@1} = case Watch of
        [First | Rest] -> {First, Rest};
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"lustre_dev_tools/dev/watcher"/utf8>>,
                        function => <<"start_polly_watcher"/utf8>>,
                        line => 128,
                        value => _assert_fail,
                        start => 3231,
                        'end' => 3265,
                        pattern_start => 3242,
                        pattern_end => 3257})
    end,
    _pipe = polly:new(),
    _pipe@1 = polly:add_dir(_pipe, First@1),
    _pipe@2 = polly:ignore_initial_missing(_pipe@1),
    _pipe@3 = gleam@list:fold(Rest@1, _pipe@2, fun polly:add_dir/2),
    _pipe@4 = polly:add_callback(_pipe@3, fun(Change) -> case Change of
                {changed, Path} ->
                    Dir@1 = case gleam@list:find(
                        Watch,
                        fun(_capture) ->
                            gleam_stdlib:string_starts_with(Path, _capture)
                        end
                    ) of
                        {ok, Dir} -> Dir;
                        _assert_fail@1 ->
                            erlang:error(#{gleam_error => let_assert,
                                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                        file => <<?FILEPATH/utf8>>,
                                        module => <<"lustre_dev_tools/dev/watcher"/utf8>>,
                                        function => <<"start_polly_watcher"/utf8>>,
                                        line => 137,
                                        value => _assert_fail@1,
                                        start => 3521,
                                        'end' => 3587,
                                        pattern_start => 3532,
                                        pattern_end => 3539})
                    end,
                    Path@1 = gleam@string:drop_start(
                        Path,
                        string:length(Dir@1) + 1
                    ),
                    case {some, Path@1} =:= Tailwind_entry of
                        true ->
                            nil;

                        false ->
                            gleam@erlang@process:send(
                                Builder,
                                {file_changed, Dir@1, Path@1}
                            )
                    end;

                {created, Path} ->
                    Dir@1 = case gleam@list:find(
                        Watch,
                        fun(_capture) ->
                            gleam_stdlib:string_starts_with(Path, _capture)
                        end
                    ) of
                        {ok, Dir} -> Dir;
                        _assert_fail@1 ->
                            erlang:error(#{gleam_error => let_assert,
                                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                        file => <<?FILEPATH/utf8>>,
                                        module => <<"lustre_dev_tools/dev/watcher"/utf8>>,
                                        function => <<"start_polly_watcher"/utf8>>,
                                        line => 137,
                                        value => _assert_fail@1,
                                        start => 3521,
                                        'end' => 3587,
                                        pattern_start => 3532,
                                        pattern_end => 3539})
                    end,
                    Path@1 = gleam@string:drop_start(
                        Path,
                        string:length(Dir@1) + 1
                    ),
                    case {some, Path@1} =:= Tailwind_entry of
                        true ->
                            nil;

                        false ->
                            gleam@erlang@process:send(
                                Builder,
                                {file_changed, Dir@1, Path@1}
                            )
                    end;

                {deleted, Path} ->
                    Dir@1 = case gleam@list:find(
                        Watch,
                        fun(_capture) ->
                            gleam_stdlib:string_starts_with(Path, _capture)
                        end
                    ) of
                        {ok, Dir} -> Dir;
                        _assert_fail@1 ->
                            erlang:error(#{gleam_error => let_assert,
                                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                        file => <<?FILEPATH/utf8>>,
                                        module => <<"lustre_dev_tools/dev/watcher"/utf8>>,
                                        function => <<"start_polly_watcher"/utf8>>,
                                        line => 137,
                                        value => _assert_fail@1,
                                        start => 3521,
                                        'end' => 3587,
                                        pattern_start => 3532,
                                        pattern_end => 3539})
                    end,
                    Path@1 = gleam@string:drop_start(
                        Path,
                        string:length(Dir@1) + 1
                    ),
                    case {some, Path@1} =:= Tailwind_entry of
                        true ->
                            nil;

                        false ->
                            gleam@erlang@process:send(
                                Builder,
                                {file_changed, Dir@1, Path@1}
                            )
                    end;

                {error, _, _} ->
                    nil
            end end),
    polly:watch(_pipe@4).

-file("src/lustre_dev_tools/dev/watcher.gleam", 154).
?DOC(false).
-spec subscribe(
    group_registry:group_registry(event()),
    gleam@erlang@process:pid_()
) -> gleam@erlang@process:subject(event()).
subscribe(Registry, Client) ->
    group_registry:join(Registry, <<"watch"/utf8>>, Client).

-file("src/lustre_dev_tools/dev/watcher.gleam", 158).
?DOC(false).
-spec unsubscribe(
    group_registry:group_registry(event()),
    gleam@erlang@process:pid_()
) -> nil.
unsubscribe(Registry, Client) ->
    group_registry:leave(Registry, <<"watch"/utf8>>, [Client]).

-file("src/lustre_dev_tools/dev/watcher.gleam", 303).
?DOC(false).
-spec build_project(
    lustre_dev_tools@project:project(),
    gleam@erlang@process:subject(build_message())
) -> gleam@erlang@process:pid_().
build_project(Project, Actor) ->
    proc_lib:spawn_link(
        fun() ->
            Result = begin
                gleam@result:'try'(
                    lustre_dev_tools@bin@gleam:build(Project),
                    fun(_) ->
                        gleam@result:'try'(case erlang:element(10, Project) of
                                true ->
                                    Module = begin
                                        _pipe = <<"import { main } from '../../build/dev/javascript/${name}/${entry}.mjs'; main();"/utf8>>,
                                        _pipe@1 = gleam@string:replace(
                                            _pipe,
                                            <<"${name}"/utf8>>,
                                            erlang:element(2, Project)
                                        ),
                                        gleam@string:replace(
                                            _pipe@1,
                                            <<"${entry}"/utf8>>,
                                            erlang:element(2, Project)
                                        )
                                    end,
                                    Name = <<(justin:snake_case(
                                            erlang:element(2, Project)
                                        ))/binary,
                                        ".dev.mjs"/utf8>>,
                                    Path = filepath:join(
                                        erlang:element(9, Project),
                                        Name
                                    ),
                                    gleam@result:'try'(
                                        begin
                                            _pipe@2 = simplifile:write(
                                                Path,
                                                Module
                                            ),
                                            gleam@result:map_error(
                                                _pipe@2,
                                                fun(_capture) ->
                                                    {could_not_write_file,
                                                        Path,
                                                        _capture}
                                                end
                                            )
                                        end,
                                        fun(_) ->
                                            lustre_dev_tools@bin@bun:build(
                                                Project,
                                                [Path],
                                                filepath:join(
                                                    erlang:element(4, Project),
                                                    <<"build/dev/javascript"/utf8>>
                                                ),
                                                false,
                                                true
                                            )
                                        end
                                    );

                                false ->
                                    {ok, nil}
                            end, fun(_) -> {ok, nil} end)
                    end
                )
            end,
            gleam@erlang@process:send(Actor, {build_finished, Result})
        end
    ).

-file("src/lustre_dev_tools/dev/watcher.gleam", 186).
?DOC(false).
-spec start_build_actor(
    lustre_dev_tools@project:project(),
    booklet:booklet(gleam@option:option(lustre_dev_tools@error:error())),
    group_registry:group_registry(event())
) -> {ok,
        gleam@otp@actor:started(gleam@erlang@process:subject(build_message()))} |
    {error, gleam@otp@actor:start_error()}.
start_build_actor(Project, Error, Watcher) ->
    _pipe@3 = gleam@otp@actor:new_with_initialiser(
        1000,
        fun(Self) -> _pipe = {waiting, Self},
            _pipe@1 = gleam@otp@actor:initialised(_pipe),
            _pipe@2 = gleam@otp@actor:returning(_pipe@1, Self),
            {ok, _pipe@2} end
    ),
    _pipe@6 = gleam@otp@actor:on_message(
        _pipe@3,
        fun(State, Message) -> case {State, Message} of
                {{waiting, _}, {build_finished, _}} ->
                    gleam@otp@actor:continue(State);

                {{waiting, Self@1}, {file_changed, In, Path}} ->
                    Timer = gleam@erlang@process:send_after(
                        Self@1,
                        50,
                        {timer_completed, In, Path}
                    ),
                    gleam@otp@actor:continue({buffering, Self@1, Timer});

                {{waiting, Self@2}, {timer_completed, In@1, Path@1}} ->
                    _ = build_project(Project, Self@2),
                    gleam@otp@actor:continue(
                        {building, Self@2, In@1, Path@1, none}
                    );

                {{buffering, _, _}, {build_finished, _}} ->
                    gleam@otp@actor:continue(State);

                {{buffering, Self@3, Timer@1}, {file_changed, In@2, Path@2}} ->
                    _ = gleam@erlang@process:cancel_timer(Timer@1),
                    Timer@2 = gleam@erlang@process:send_after(
                        Self@3,
                        50,
                        {timer_completed, In@2, Path@2}
                    ),
                    gleam@otp@actor:continue({buffering, Self@3, Timer@2});

                {{buffering, Self@4, _}, {timer_completed, In@3, Path@3}} ->
                    _ = build_project(Project, Self@4),
                    gleam@otp@actor:continue(
                        {building, Self@4, In@3, Path@3, none}
                    );

                {{building, Self@5, In@4, Path@4, Queued},
                    {build_finished, {ok, _}}} ->
                    booklet_ffi:set(Error, none),
                    _pipe@4 = group_registry:members(Watcher, <<"watch"/utf8>>),
                    gleam@list:each(
                        _pipe@4,
                        fun(_capture) ->
                            gleam@erlang@process:send(
                                _capture,
                                {change, In@4, Path@4}
                            )
                        end
                    ),
                    case Queued of
                        none ->
                            gleam@otp@actor:continue({waiting, Self@5});

                        {some, Queued@1} ->
                            _ = build_project(Project, Self@5),
                            gleam@otp@actor:continue(
                                {building,
                                    Self@5,
                                    erlang:element(1, Queued@1),
                                    erlang:element(2, Queued@1),
                                    none}
                            )
                    end;

                {{building, Self@6, _, _, none},
                    {build_finished, {error, Reason}}} ->
                    booklet_ffi:set(Error, {some, Reason}),
                    gleam_stdlib:println_error(<<(case Reason of
                                {external_command_failed,
                                    <<"gleam"/utf8>>,
                                    Reason@1} ->
                                    Reason@1;

                                _ ->
                                    gleam_community@ansi:gray(
                                        lustre_dev_tools@error:explain(Reason)
                                    )
                            end)/binary, "\n"/utf8>>),
                    _pipe@5 = group_registry:members(Watcher, <<"watch"/utf8>>),
                    gleam@list:each(
                        _pipe@5,
                        fun(_capture@1) ->
                            gleam@erlang@process:send(_capture@1, build_error)
                        end
                    ),
                    gleam@otp@actor:continue({waiting, Self@6});

                {{building, Self@7, _, _, {some, Queued@2}},
                    {build_finished, {error, _}}} ->
                    _ = build_project(Project, Self@7),
                    gleam@otp@actor:continue(
                        {building,
                            Self@7,
                            erlang:element(1, Queued@2),
                            erlang:element(2, Queued@2),
                            none}
                    );

                {{building, _, _, _, _}, {file_changed, In@5, Path@5}} ->
                    gleam@otp@actor:continue(
                        {building,
                            erlang:element(2, State),
                            erlang:element(3, State),
                            erlang:element(4, State),
                            {some, {In@5, Path@5}}}
                    );

                {{building, _, _, _, _}, {timer_completed, In@6, Path@6}} ->
                    gleam@otp@actor:continue(
                        {building,
                            erlang:element(2, State),
                            erlang:element(3, State),
                            erlang:element(4, State),
                            {some, {In@6, Path@6}}}
                    )
            end end
    ),
    gleam@otp@actor:start(_pipe@6).

-file("src/lustre_dev_tools/dev/watcher.gleam", 43).
?DOC(false).
-spec start(
    lustre_dev_tools@project:project(),
    gleam@option:option(mode()),
    booklet:booklet(gleam@option:option(lustre_dev_tools@error:error())),
    list(binary()),
    gleam@option:option(binary())
) -> {ok, group_registry:group_registry(event())} |
    {error, lustre_dev_tools@error:error()}.
start(Project, Mode, Error, Watch, Tailwind_entry) ->
    Name = gleam_erlang_ffi:new_name(<<"registry"/utf8>>),
    Registry@1 = case group_registry:start(Name) of
        {ok, {started, _, Registry}} -> Registry;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"lustre_dev_tools/dev/watcher"/utf8>>,
                        function => <<"start"/utf8>>,
                        line => 51,
                        value => _assert_fail,
                        start => 1179,
                        'end' => 1250,
                        pattern_start => 1190,
                        pattern_end => 1221})
    end,
    Builder@1 = case start_build_actor(Project, Error, Registry@1) of
        {ok, {started, _, Builder}} -> Builder;
        _assert_fail@1 ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"lustre_dev_tools/dev/watcher"/utf8>>,
                        function => <<"start"/utf8>>,
                        line => 52,
                        value => _assert_fail@1,
                        start => 1253,
                        'end' => 1344,
                        pattern_start => 1264,
                        pattern_end => 1294})
    end,
    case Mode of
        none ->
            {ok, Registry@1};

        {some, Mode@1} ->
            gleam@result:'try'(case Tailwind_entry of
                    {some, Entry} ->
                        lustre_dev_tools@bin@tailwind:watch(
                            Project,
                            Entry,
                            filepath:join(
                                erlang:element(4, Project),
                                <<"build/dev/javascript"/utf8>>
                            ),
                            true,
                            fun() ->
                                _pipe = group_registry:members(
                                    Registry@1,
                                    <<"watch"/utf8>>
                                ),
                                gleam@list:each(
                                    _pipe,
                                    fun(_capture) ->
                                        gleam@erlang@process:send(
                                            _capture,
                                            styles
                                        )
                                    end
                                )
                            end
                        );

                    none ->
                        {ok, nil}
                end, fun(_) -> case Mode@1 of
                        events ->
                            case start_bun_watcher(
                                Project,
                                Watch,
                                Tailwind_entry,
                                Builder@1
                            ) of
                                {ok, _} ->
                                    {ok, Registry@1};

                                {error, _} ->
                                    lustre_dev_tools@cli:log(
                                        <<"Failed to start file watcher, falling back to polling watcher."/utf8>>,
                                        false
                                    ),
                                    _pipe@1 = start_polly_watcher(
                                        Watch,
                                        Tailwind_entry,
                                        Builder@1
                                    ),
                                    _pipe@2 = gleam@result:replace(
                                        _pipe@1,
                                        Registry@1
                                    ),
                                    gleam@result:replace_error(
                                        _pipe@2,
                                        {could_not_start_file_watcher,
                                            <<"polly"/utf8>>,
                                            system_ffi:detect_os(),
                                            system_ffi:detect_arch()}
                                    )
                            end;

                        polling ->
                            _pipe@3 = start_polly_watcher(
                                Watch,
                                Tailwind_entry,
                                Builder@1
                            ),
                            _pipe@4 = gleam@result:replace(_pipe@3, Registry@1),
                            gleam@result:replace_error(
                                _pipe@4,
                                {could_not_start_file_watcher,
                                    <<"polly"/utf8>>,
                                    system_ffi:detect_os(),
                                    system_ffi:detect_arch()}
                            )
                    end end)
    end.
