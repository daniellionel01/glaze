-module(lustre_dev_tools@bin@tailwind).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre_dev_tools/bin/tailwind.gleam").
-export([detect/2, download/3, build/5, watch/5]).
-export_type([detection/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type detection() :: {has_viable_entry, binary()} |
    {has_tailwind_entry, binary()} |
    has_legacy_config |
    nothing.

-file("src/lustre_dev_tools/bin/tailwind.gleam", 172).
?DOC(false).
-spec detect(lustre_dev_tools@project:project(), binary()) -> {ok, detection()} |
    {error, lustre_dev_tools@error:error()}.
detect(Project, Entry) ->
    Tailwind_config = begin
        Src_path = filepath:join(
            erlang:element(5, Project),
            <<Entry/binary, ".css"/utf8>>
        ),
        Dev_path = filepath:join(
            erlang:element(6, Project),
            <<Entry/binary, ".css"/utf8>>
        ),
        case simplifile_erl:is_file(Src_path) of
            {ok, true} ->
                {ok, Src_path};

            {ok, false} ->
                case simplifile_erl:is_file(Dev_path) of
                    {ok, true} ->
                        {ok, Dev_path};

                    {ok, false} ->
                        {error, nil};

                    {error, _} ->
                        {error, nil}
                end;

            {error, _} ->
                case simplifile_erl:is_file(Dev_path) of
                    {ok, true} ->
                        {ok, Dev_path};

                    {ok, false} ->
                        {error, nil};

                    {error, _} ->
                        {error, nil}
                end
        end
    end,
    Legacy_config = filepath:join(
        erlang:element(4, Project),
        <<"tailwind.config.js"/utf8>>
    ),
    Has_legacy_config = begin
        _pipe = Legacy_config,
        _pipe@1 = simplifile_erl:is_file(_pipe),
        gleam@result:unwrap(_pipe@1, false)
    end,
    case Tailwind_config of
        {ok, Path} ->
            gleam@result:'try'(
                begin
                    _pipe@2 = simplifile:read(Path),
                    gleam@result:map_error(
                        _pipe@2,
                        fun(_capture) ->
                            {could_not_read_file, Path, _capture}
                        end
                    )
                end,
                fun(Css) ->
                    Re@1 = case gleam@regexp:from_string(
                        <<"^@import\\s+['\"]tailwindcss"/utf8>>
                    ) of
                        {ok, Re} -> Re;
                        _assert_fail ->
                            erlang:error(#{gleam_error => let_assert,
                                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                        file => <<?FILEPATH/utf8>>,
                                        module => <<"lustre_dev_tools/bin/tailwind"/utf8>>,
                                        function => <<"detect"/utf8>>,
                                        line => 204,
                                        value => _assert_fail,
                                        start => 5776,
                                        'end' => 5846,
                                        pattern_start => 5787,
                                        pattern_end => 5793})
                    end,
                    case gleam@regexp:check(Re@1, Css) of
                        true ->
                            {ok, {has_tailwind_entry, Path}};

                        false ->
                            {ok, {has_viable_entry, Path}}
                    end
                end
            );

        {error, _} when Has_legacy_config ->
            {ok, has_legacy_config};

        {error, _} ->
            {ok, nothing}
    end.

-file("src/lustre_dev_tools/bin/tailwind.gleam", 384).
?DOC(false).
-spec resolve(binary(), binary()) -> {ok, binary()} | {error, nil}.
resolve(Os, Arch) ->
    Is_alpine = system_ffi:is_alpine(),
    case {Os, Arch} of
        {<<"darwin"/utf8>>, <<"aarch64"/utf8>>} ->
            {ok, <<"tailwindcss-macos-arm64"/utf8>>};

        {<<"darwin"/utf8>>, <<"arm64"/utf8>>} ->
            {ok, <<"tailwindcss-macos-arm64"/utf8>>};

        {<<"darwin"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"tailwindcss-macos-x64"/utf8>>};

        {<<"darwin"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"tailwindcss-macos-x64"/utf8>>};

        {<<"linux"/utf8>>, <<"aarch64"/utf8>>} when Is_alpine ->
            {ok, <<"tailwindcss-linux-arm64-musl"/utf8>>};

        {<<"linux"/utf8>>, <<"arm64"/utf8>>} when Is_alpine ->
            {ok, <<"tailwindcss-linux-arm64-musl"/utf8>>};

        {<<"linux"/utf8>>, <<"aarch64"/utf8>>} ->
            {ok, <<"tailwindcss-linux-arm64"/utf8>>};

        {<<"linux"/utf8>>, <<"arm64"/utf8>>} ->
            {ok, <<"tailwindcss-linux-arm64"/utf8>>};

        {<<"linux"/utf8>>, <<"x64"/utf8>>} when Is_alpine ->
            {ok, <<"tailwindcss-linux-x64-musl"/utf8>>};

        {<<"linux"/utf8>>, <<"x86_64"/utf8>>} when Is_alpine ->
            {ok, <<"tailwindcss-linux-x64-musl"/utf8>>};

        {<<"linux"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"tailwindcss-linux-x64"/utf8>>};

        {<<"linux"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"tailwindcss-linux-x64"/utf8>>};

        {<<"win32"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"tailwindcss-windows-x64"/utf8>>};

        {<<"windows"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"tailwindcss-windows-x64"/utf8>>};

        {<<"win32"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"tailwindcss-windows-x64"/utf8>>};

        {<<"windows"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"tailwindcss-windows-x64"/utf8>>};

        {_, _} ->
            {error, nil}
    end.

-file("src/lustre_dev_tools/bin/tailwind.gleam", 356).
?DOC(false).
-spec detect_platform() -> {ok, binary()} |
    {error, lustre_dev_tools@error:error()}.
detect_platform() ->
    Os = system_ffi:detect_os(),
    Arch = system_ffi:detect_arch(),
    _pipe = resolve(Os, Arch),
    gleam@result:replace_error(_pipe, {unsupported_platform, Os, Arch}).

-file("src/lustre_dev_tools/bin/tailwind.gleam", 406).
?DOC(false).
-spec verify_version(binary()) -> {ok, nil} |
    {error, lustre_dev_tools@error:error()}.
verify_version(Path) ->
    gleam@result:'try'(
        begin
            _pipe = system_ffi:run(
                Path,
                [<<"--help"/utf8>>],
                [{<<"NO_COLOR"/utf8>>, <<"1"/utf8>>}]
            ),
            gleam@result:replace_error(
                _pipe,
                {could_not_locate_tailwind_binary, Path}
            )
        end,
        fun(Output) ->
            gleam@result:'try'(
                begin
                    _pipe@1 = gleam@string:split_once(Output, <<"\n"/utf8>>),
                    gleam@result:replace_error(
                        _pipe@1,
                        {unsupported_tailwind_version,
                            Path,
                            <<"4.1.13"/utf8>>,
                            <<"unknown"/utf8>>}
                    )
                end,
                fun(_use0) ->
                    {Actual, _} = _use0,
                    case gleam_community@ansi:strip(Actual) of
                        <<"≈ tailwindcss v"/utf8, V/binary>> when V =:= <<"4.1.13"/utf8>> ->
                            {ok, nil};

                        <<"≈ tailwindcss v"/utf8, V@1/binary>> ->
                            {error,
                                {unsupported_tailwind_version,
                                    Path,
                                    <<"4.1.13"/utf8>>,
                                    V@1}};

                        _ ->
                            {error,
                                {unsupported_tailwind_version,
                                    Path,
                                    <<"4.1.13"/utf8>>,
                                    <<"unknown"/utf8>>}}
                    end
                end
            )
        end
    ).

-file("src/lustre_dev_tools/bin/tailwind.gleam", 369).
?DOC(false).
-spec verify_integrity(bitstring(), binary()) -> {ok, nil} |
    {error, lustre_dev_tools@error:error()}.
verify_integrity(Archive, Name) ->
    Expected@1 = case gleam@list:key_find(
        [{<<"tailwindcss-linux-arm64"/utf8>>,
                <<"c90529475a398adbf3315898721c0f9fe85f434a2b3ea3eafada68867641819a"/utf8>>},
            {<<"tailwindcss-linux-arm64-musl"/utf8>>,
                <<"09624e1cb6295849020fb78344eb5dfa8196f57dfa6f81a0cb8442151d2f860d"/utf8>>},
            {<<"tailwindcss-linux-x64"/utf8>>,
                <<"b9ed9f8f640d3323711f9f68608aa266dff3adbc42e867c38ea2d009b973be11"/utf8>>},
            {<<"tailwindcss-linux-x64-musl"/utf8>>,
                <<"5785fbf6bc1e489e0d3c9743aa6cf0fe20b4633c1de6e8a4d6cdc0bf86716d71"/utf8>>},
            {<<"tailwindcss-macos-arm64"/utf8>>,
                <<"c47681e9948db20026a913a4aca4ee0269b4c0d4ef3f71343cb891dfdc1e97c9"/utf8>>},
            {<<"tailwindcss-macos-x64"/utf8>>,
                <<"c3b230bdbfaa46c94cad8db44da1f82773f10bac54f56fa196c8977d819c09e4"/utf8>>},
            {<<"tailwindcss-windows-x64"/utf8>>,
                <<"ad16a528e13111e5df4e771b4b4981bd4b73e69140fa021f4102f46f02eeb86d"/utf8>>}],
        Name
    ) of
        {ok, Expected} -> Expected;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"lustre_dev_tools/bin/tailwind"/utf8>>,
                        function => <<"verify_integrity"/utf8>>,
                        line => 370,
                        value => _assert_fail,
                        start => 10573,
                        'end' => 10626,
                        pattern_start => 10584,
                        pattern_end => 10596})
    end,
    Hash = gleam@crypto:hash(sha256, Archive),
    Actual = begin
        _pipe = gleam_stdlib:base16_encode(Hash),
        string:lowercase(_pipe)
    end,
    case Actual =:= Expected@1 of
        true ->
            {ok, nil};

        false ->
            {error, {could_not_verify_tailwind_hash, Expected@1, Actual}}
    end.

-file("src/lustre_dev_tools/bin/tailwind.gleam", 39).
?DOC(false).
-spec download(lustre_dev_tools@project:project(), boolean(), integer()) -> {ok,
        binary()} |
    {error, lustre_dev_tools@error:error()}.
download(Project, Quiet, Timeout_ms) ->
    gleam@result:'try'(
        detect_platform(),
        fun(Name) ->
            Req = {request,
                get,
                [],
                <<>>,
                https,
                <<"github.com"/utf8>>,
                none,
                <<<<<<"/tailwindlabs/tailwindcss/releases/download/v"/utf8,
                            "4.1.13"/utf8>>/binary,
                        "/"/utf8>>/binary,
                    (lustre_dev_tools@system:executable_name(Name))/binary>>,
                none},
            lustre_dev_tools@cli:log(
                <<"Downloading TailwindCSS v"/utf8, "4.1.13"/utf8>>,
                Quiet
            ),
            gleam@result:'try'(
                begin
                    _pipe = gleam@httpc:configure(),
                    _pipe@1 = gleam@httpc:timeout(_pipe, Timeout_ms),
                    _pipe@2 = gleam@httpc:follow_redirects(_pipe@1, true),
                    _pipe@3 = gleam@httpc:dispatch_bits(_pipe@2, Req),
                    gleam@result:map_error(
                        _pipe@3,
                        fun(Field@0) -> {could_not_download_tailwind_binary, Field@0} end
                    )
                end,
                fun(Res) ->
                    lustre_dev_tools@cli:log(
                        <<"Verifying download hash"/utf8>>,
                        Quiet
                    ),
                    gleam@result:'try'(
                        verify_integrity(erlang:element(4, Res), Name),
                        fun(_) ->
                            Path = filepath:join(
                                erlang:element(8, Project),
                                Name
                            ),
                            gleam@result:'try'(
                                begin
                                    _pipe@4 = simplifile:create_directory_all(
                                        Path
                                    ),
                                    gleam@result:map_error(
                                        _pipe@4,
                                        fun(_capture) ->
                                            {could_not_write_file,
                                                Path,
                                                _capture}
                                        end
                                    )
                                end,
                                fun(_) ->
                                    Path@1 = filepath:join(
                                        Path,
                                        lustre_dev_tools@system:executable_name(
                                            Name
                                        )
                                    ),
                                    gleam@result:'try'(
                                        begin
                                            _pipe@5 = simplifile_erl:write_bits(
                                                Path@1,
                                                erlang:element(4, Res)
                                            ),
                                            gleam@result:map_error(
                                                _pipe@5,
                                                fun(_capture@1) ->
                                                    {could_not_write_file,
                                                        Path@1,
                                                        _capture@1}
                                                end
                                            )
                                        end,
                                        fun(_) ->
                                            gleam@result:'try'(
                                                begin
                                                    _pipe@6 = simplifile_erl:set_permissions_octal(
                                                        Path@1,
                                                        8#755
                                                    ),
                                                    gleam@result:map_error(
                                                        _pipe@6,
                                                        fun(_capture@2) ->
                                                            {could_not_write_file,
                                                                Path@1,
                                                                _capture@2}
                                                        end
                                                    )
                                                end,
                                                fun(_) ->
                                                    gleam@result:'try'(
                                                        verify_version(Path@1),
                                                        fun(_) ->
                                                            Path_to_exe = Path@1,
                                                            lustre_dev_tools@cli:success(
                                                                <<<<"TailwindCSS v"/utf8,
                                                                        "4.1.13"/utf8>>/binary,
                                                                    " is ready to go!"/utf8>>,
                                                                Quiet
                                                            ),
                                                            gleam@result:'try'(
                                                                detect(
                                                                    Project,
                                                                    erlang:element(
                                                                        2,
                                                                        Project
                                                                    )
                                                                ),
                                                                fun(Detection) ->
                                                                    case Detection of
                                                                        {has_tailwind_entry,
                                                                            _} ->
                                                                            {ok,
                                                                                Path_to_exe};

                                                                        has_legacy_config ->
                                                                            Css = [<<"@import \"tailwindcss\";"/utf8>>,
                                                                                <<"@config \"../tailwind.config.js\";"/utf8>>,
                                                                                <<""/utf8>>],
                                                                            gleam@result:'try'(
                                                                                begin
                                                                                    _pipe@7 = simplifile:write(
                                                                                        Path@1,
                                                                                        gleam@string:join(
                                                                                            Css,
                                                                                            <<"\n"/utf8>>
                                                                                        )
                                                                                    ),
                                                                                    gleam@result:map_error(
                                                                                        _pipe@7,
                                                                                        fun(
                                                                                            _capture@3
                                                                                        ) ->
                                                                                            {could_not_write_file,
                                                                                                Path@1,
                                                                                                _capture@3}
                                                                                        end
                                                                                    )
                                                                                end,
                                                                                fun(
                                                                                    _
                                                                                ) ->
                                                                                    lustre_dev_tools@cli:success(
                                                                                        <<"Tailwind config generated"/utf8>>,
                                                                                        Quiet
                                                                                    ),
                                                                                    {ok,
                                                                                        Path_to_exe}
                                                                                end
                                                                            );

                                                                        {has_viable_entry,
                                                                            Path@2} ->
                                                                            gleam@result:'try'(
                                                                                begin
                                                                                    _pipe@8 = simplifile:read(
                                                                                        Path@2
                                                                                    ),
                                                                                    gleam@result:map_error(
                                                                                        _pipe@8,
                                                                                        fun(
                                                                                            _capture@4
                                                                                        ) ->
                                                                                            {could_not_read_file,
                                                                                                Path@2,
                                                                                                _capture@4}
                                                                                        end
                                                                                    )
                                                                                end,
                                                                                fun(
                                                                                    Css@1
                                                                                ) ->
                                                                                    Css@2 = [<<"@import \"tailwindcss\";"/utf8>>,
                                                                                        <<""/utf8>>,
                                                                                        Css@1],
                                                                                    gleam@result:'try'(
                                                                                        begin
                                                                                            _pipe@9 = simplifile:write(
                                                                                                Path@2,
                                                                                                gleam@string:join(
                                                                                                    Css@2,
                                                                                                    <<"\n"/utf8>>
                                                                                                )
                                                                                            ),
                                                                                            gleam@result:map_error(
                                                                                                _pipe@9,
                                                                                                fun(
                                                                                                    _capture@5
                                                                                                ) ->
                                                                                                    {could_not_write_file,
                                                                                                        Path@2,
                                                                                                        _capture@5}
                                                                                                end
                                                                                            )
                                                                                        end,
                                                                                        fun(
                                                                                            _
                                                                                        ) ->
                                                                                            lustre_dev_tools@cli:success(
                                                                                                <<"Tailwind config generated"/utf8>>,
                                                                                                Quiet
                                                                                            ),
                                                                                            {ok,
                                                                                                Path_to_exe}
                                                                                        end
                                                                                    )
                                                                                end
                                                                            );

                                                                        nothing ->
                                                                            Css@3 = [<<"@import \"tailwindcss\";"/utf8>>,
                                                                                <<""/utf8>>],
                                                                            gleam@result:'try'(
                                                                                begin
                                                                                    _pipe@10 = simplifile:write(
                                                                                        Path@1,
                                                                                        gleam@string:join(
                                                                                            Css@3,
                                                                                            <<"\n"/utf8>>
                                                                                        )
                                                                                    ),
                                                                                    gleam@result:map_error(
                                                                                        _pipe@10,
                                                                                        fun(
                                                                                            _capture@6
                                                                                        ) ->
                                                                                            {could_not_write_file,
                                                                                                Path@1,
                                                                                                _capture@6}
                                                                                        end
                                                                                    )
                                                                                end,
                                                                                fun(
                                                                                    _
                                                                                ) ->
                                                                                    lustre_dev_tools@cli:success(
                                                                                        <<"Tailwind config generated"/utf8>>,
                                                                                        Quiet
                                                                                    ),
                                                                                    {ok,
                                                                                        Path_to_exe}
                                                                                end
                                                                            )
                                                                    end
                                                                end
                                                            )
                                                        end
                                                    )
                                                end
                                            )
                                        end
                                    )
                                end
                            )
                        end
                    )
                end
            )
        end
    ).

-file("src/lustre_dev_tools/bin/tailwind.gleam", 302).
?DOC(false).
-spec locate_tailwind(lustre_dev_tools@project:project(), boolean()) -> {ok,
        binary()} |
    {error, lustre_dev_tools@error:error()}.
locate_tailwind(Project, Quiet) ->
    case tom:get_string(
        erlang:element(3, Project),
        [<<"bin"/utf8>>, <<"tailwindcss"/utf8>>]
    ) of
        {ok, <<"system"/utf8>>} ->
            _pipe = system_ffi:find(<<"tailwindcss"/utf8>>),
            _pipe@1 = gleam@result:replace_error(
                _pipe,
                {could_not_locate_tailwind_binary, <<"$PATH/tailwindcss"/utf8>>}
            ),
            gleam@result:map(
                _pipe@1,
                fun(Path) ->
                    lustre_dev_tools@cli:log(
                        <<"Using system Tailwind installation"/utf8>>,
                        Quiet
                    ),
                    Path
                end
            );

        {ok, Path@1} ->
            case simplifile_erl:is_file(Path@1) of
                {ok, true} ->
                    lustre_dev_tools@cli:log(
                        <<"Using local Tailwind installation"/utf8>>,
                        Quiet
                    ),
                    {ok, Path@1};

                {ok, false} ->
                    {error, {could_not_locate_tailwind_binary, Path@1}};

                {error, _} ->
                    {error, {could_not_locate_tailwind_binary, Path@1}}
            end;

        {error, _} ->
            gleam@result:'try'(
                detect_platform(),
                fun(Name) ->
                    Path@2 = begin
                        _pipe@2 = erlang:element(8, Project),
                        _pipe@3 = filepath:join(_pipe@2, Name),
                        filepath:join(
                            _pipe@3,
                            lustre_dev_tools@system:executable_name(Name)
                        )
                    end,
                    Timeout = begin
                        _pipe@4 = tom:get_int(
                            erlang:element(3, Project),
                            [<<"bin"/utf8>>, <<"timeout"/utf8>>]
                        ),
                        _pipe@5 = gleam@result:map(
                            _pipe@4,
                            fun(Seconds) -> Seconds * 1000 end
                        ),
                        gleam@result:unwrap(_pipe@5, 60000)
                    end,
                    gleam@result:'try'(case simplifile_erl:is_file(Path@2) of
                            {ok, true} ->
                                case verify_version(Path@2) of
                                    {ok, _} ->
                                        {ok, Path@2};

                                    {error, _} ->
                                        download(Project, Quiet, Timeout)
                                end;

                            _ ->
                                download(Project, Quiet, Timeout)
                        end, fun(Path@3) -> {ok, Path@3} end)
                end
            )
    end.

-file("src/lustre_dev_tools/bin/tailwind.gleam", 215).
?DOC(false).
-spec build(
    lustre_dev_tools@project:project(),
    binary(),
    binary(),
    boolean(),
    boolean()
) -> {ok, nil} | {error, lustre_dev_tools@error:error()}.
build(Project, Entry, Out, Minify, Quiet) ->
    gleam@result:'try'(
        locate_tailwind(Project, Quiet),
        fun(Cmd) ->
            Name = filepath:base_name(Entry),
            Output = begin
                _pipe = filepath:join(erlang:element(4, Project), Out),
                filepath:join(_pipe, Name)
            end,
            Args = lists:append(
                [[<<"-i"/utf8>>, Entry], [<<"-o"/utf8>>, Output], case Minify of
                        true ->
                            [<<"--minify"/utf8>>];

                        false ->
                            []
                    end]
            ),
            lustre_dev_tools@cli:log(
                <<"Building Tailwind stylesheet"/utf8>>,
                Quiet
            ),
            gleam@result:'try'(
                begin
                    _pipe@1 = system_ffi:run(Cmd, Args, []),
                    gleam@result:map_error(
                        _pipe@1,
                        fun(Field@0) -> {failed_to_build_project, Field@0} end
                    )
                end,
                fun(_) ->
                    lustre_dev_tools@cli:success(
                        <<"Stylesheet successfully built."/utf8>>,
                        Quiet
                    ),
                    {ok, nil}
                end
            )
        end
    ).

-file("src/lustre_dev_tools/bin/tailwind.gleam", 249).
?DOC(false).
-spec watch(
    lustre_dev_tools@project:project(),
    binary(),
    binary(),
    boolean(),
    fun(() -> nil)
) -> {ok, nil} | {error, lustre_dev_tools@error:error()}.
watch(Project, Entry, Out, Quiet, Handle_change) ->
    gleam@result:'try'(
        locate_tailwind(Project, Quiet),
        fun(Path) ->
            Name = filepath:base_name(Entry),
            Output = begin
                _pipe = filepath:join(erlang:element(4, Project), Out),
                filepath:join(_pipe, Name)
            end,
            Flags = [<<"-i"/utf8>>, Entry, <<"-o"/utf8>>, Output, <<"-w"/utf8>>],
            gleam@result:'try'(
                begin
                    _pipe@1 = lustre_dev_tools@port:start(
                        Path,
                        Flags,
                        fun(_) -> nil end,
                        fun() ->
                            File_info = simplifile_erl:file_info(Output),
                            case File_info of
                                {ok, Info} ->
                                    case erlang:element(10, Info) > erlang:element(
                                        9,
                                        Info
                                    ) of
                                        true ->
                                            Handle_change();

                                        false ->
                                            nil
                                    end;

                                {error, _} ->
                                    lustre_dev_tools@cli:log(
                                        <<"Failed to locate output css file"/utf8>>,
                                        Quiet
                                    )
                            end
                        end
                    ),
                    gleam@result:replace_error(
                        _pipe@1,
                        {could_not_start_file_watcher,
                            Path,
                            system_ffi:detect_os(),
                            system_ffi:detect_arch()}
                    )
                end,
                fun(_) -> {ok, nil} end
            )
        end
    ).
