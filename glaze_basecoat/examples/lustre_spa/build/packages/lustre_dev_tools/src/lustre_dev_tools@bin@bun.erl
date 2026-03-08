-module(lustre_dev_tools@bin@bun).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre_dev_tools/bin/bun.gleam").
-export([download/3, watch/3, build/5]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-file("src/lustre_dev_tools/bin/bun.gleam", 299).
?DOC(false).
-spec requires_baseline(binary()) -> boolean().
requires_baseline(Os) ->
    case Os of
        <<"linux"/utf8>> ->
            Sh = begin
                _pipe = system_ffi:find(<<"sh"/utf8>>),
                gleam@result:unwrap(_pipe, <<"/bin/sh"/utf8>>)
            end,
            case system_ffi:run(
                Sh,
                [<<"-c"/utf8>>, <<"cat /proc/cpuinfo | grep avx2"/utf8>>],
                []
            ) of
                {ok, Output} ->
                    Output =:= <<""/utf8>>;

                {error, _} ->
                    true
            end;

        <<"win32"/utf8>> ->
            Powershell = begin
                _pipe@1 = system_ffi:find(<<"powershell"/utf8>>),
                gleam@result:unwrap(
                    _pipe@1,
                    <<"c:/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe"/utf8>>
                )
            end,
            Command = <<"(Add-Type -MemberDefinition '[DllImport(\"kernel32.dll\")] public static extern bool IsProcessorFeaturePresent(int ProcessorFeature);' -Name 'Kernel32' -Namespace 'Win32' -PassThru)::IsProcessorFeaturePresent(40)"/utf8>>,
            case system_ffi:run(Powershell, [<<"-Command"/utf8>>, Command], []) of
                {ok, Output@1} ->
                    gleam@string:trim(Output@1) /= <<"True"/utf8>>;

                {error, _} ->
                    true
            end;

        <<"windows"/utf8>> ->
            Powershell = begin
                _pipe@1 = system_ffi:find(<<"powershell"/utf8>>),
                gleam@result:unwrap(
                    _pipe@1,
                    <<"c:/WINDOWS/System32/WindowsPowerShell/v1.0/powershell.exe"/utf8>>
                )
            end,
            Command = <<"(Add-Type -MemberDefinition '[DllImport(\"kernel32.dll\")] public static extern bool IsProcessorFeaturePresent(int ProcessorFeature);' -Name 'Kernel32' -Namespace 'Win32' -PassThru)::IsProcessorFeaturePresent(40)"/utf8>>,
            case system_ffi:run(Powershell, [<<"-Command"/utf8>>, Command], []) of
                {ok, Output@1} ->
                    gleam@string:trim(Output@1) /= <<"True"/utf8>>;

                {error, _} ->
                    true
            end;

        _ ->
            false
    end.

-file("src/lustre_dev_tools/bin/bun.gleam", 273).
?DOC(false).
-spec resolve(binary(), binary()) -> {ok, binary()} | {error, nil}.
resolve(Os, Arch) ->
    Is_alpine = system_ffi:is_alpine(),
    Baseline = requires_baseline(Os),
    case {Os, Arch} of
        {<<"darwin"/utf8>>, <<"aarch64"/utf8>>} ->
            {ok, <<"bun-darwin-aarch64"/utf8>>};

        {<<"darwin"/utf8>>, <<"arm64"/utf8>>} ->
            {ok, <<"bun-darwin-aarch64"/utf8>>};

        {<<"darwin"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"bun-darwin-x64"/utf8>>};

        {<<"darwin"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"bun-darwin-x64"/utf8>>};

        {<<"linux"/utf8>>, <<"aarch64"/utf8>>} when Is_alpine ->
            {ok, <<"bun-linux-aarch64-musl"/utf8>>};

        {<<"linux"/utf8>>, <<"arm64"/utf8>>} when Is_alpine ->
            {ok, <<"bun-linux-aarch64-musl"/utf8>>};

        {<<"linux"/utf8>>, <<"aarch64"/utf8>>} ->
            {ok, <<"bun-linux-aarch64"/utf8>>};

        {<<"linux"/utf8>>, <<"arm64"/utf8>>} ->
            {ok, <<"bun-linux-aarch64"/utf8>>};

        {<<"linux"/utf8>>, <<"x64"/utf8>>} ->
            case {Baseline, Is_alpine} of
                {true, true} ->
                    {ok, <<"bun-linux-x64-musl-baseline"/utf8>>};

                {true, false} ->
                    {ok, <<"bun-linux-x64-baseline"/utf8>>};

                {false, true} ->
                    {ok, <<"bun-linux-x64-musl"/utf8>>};

                {false, false} ->
                    {ok, <<"bun-linux-x64"/utf8>>}
            end;

        {<<"linux"/utf8>>, <<"x86_64"/utf8>>} ->
            case {Baseline, Is_alpine} of
                {true, true} ->
                    {ok, <<"bun-linux-x64-musl-baseline"/utf8>>};

                {true, false} ->
                    {ok, <<"bun-linux-x64-baseline"/utf8>>};

                {false, true} ->
                    {ok, <<"bun-linux-x64-musl"/utf8>>};

                {false, false} ->
                    {ok, <<"bun-linux-x64"/utf8>>}
            end;

        {<<"win32"/utf8>>, <<"x64"/utf8>>} when Baseline ->
            {ok, <<"bun-windows-x64-baseline"/utf8>>};

        {<<"windows"/utf8>>, <<"x64"/utf8>>} when Baseline ->
            {ok, <<"bun-windows-x64-baseline"/utf8>>};

        {<<"win32"/utf8>>, <<"x86_64"/utf8>>} when Baseline ->
            {ok, <<"bun-windows-x64-baseline"/utf8>>};

        {<<"windows"/utf8>>, <<"x86_64"/utf8>>} when Baseline ->
            {ok, <<"bun-windows-x64-baseline"/utf8>>};

        {<<"win32"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"bun-windows-x64"/utf8>>};

        {<<"windows"/utf8>>, <<"x64"/utf8>>} ->
            {ok, <<"bun-windows-x64"/utf8>>};

        {<<"win32"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"bun-windows-x64"/utf8>>};

        {<<"windows"/utf8>>, <<"x86_64"/utf8>>} ->
            {ok, <<"bun-windows-x64"/utf8>>};

        {_, _} ->
            {error, nil}
    end.

-file("src/lustre_dev_tools/bin/bun.gleam", 245).
?DOC(false).
-spec detect_platform() -> {ok, binary()} |
    {error, lustre_dev_tools@error:error()}.
detect_platform() ->
    Os = system_ffi:detect_os(),
    Arch = system_ffi:detect_arch(),
    _pipe = resolve(Os, Arch),
    gleam@result:replace_error(_pipe, {unsupported_platform, Os, Arch}).

-file("src/lustre_dev_tools/bin/bun.gleam", 355).
?DOC(false).
-spec 'maybe'(boolean(), AGAM, AGAM) -> AGAM.
'maybe'(Condition, True, False) ->
    case Condition of
        true ->
            True;

        false ->
            False
    end.

-file("src/lustre_dev_tools/bin/bun.gleam", 340).
?DOC(false).
-spec verify_version(binary()) -> {ok, nil} |
    {error, lustre_dev_tools@error:error()}.
verify_version(Path) ->
    gleam@result:'try'(
        begin
            _pipe = system_ffi:run(Path, [<<"--version"/utf8>>], []),
            gleam@result:replace_error(
                _pipe,
                {could_not_locate_bun_binary, Path}
            )
        end,
        fun(Output) ->
            Actual = gleam@string:trim(Output),
            case Actual =:= <<"1.2.22"/utf8>> of
                true ->
                    {ok, nil};

                false ->
                    {error,
                        {unsupported_bun_version,
                            Path,
                            <<"1.2.22"/utf8>>,
                            Actual}}
            end
        end
    ).

-file("src/lustre_dev_tools/bin/bun.gleam", 258).
?DOC(false).
-spec verify_integrity(bitstring(), binary()) -> {ok, nil} |
    {error, lustre_dev_tools@error:error()}.
verify_integrity(Archive, Name) ->
    Expected@1 = case gleam@list:key_find(
        [{<<"bun-darwin-aarch64"/utf8>>,
                <<"eb8c7e09cbea572414a0a367848e1acbf05294a946a594405a014b1fb3b3fc76"/utf8>>},
            {<<"bun-darwin-x64"/utf8>>,
                <<"a7484721a7ead45887c812e760b124047e663173cf2a3ba7c5aa1992cb22cd3e"/utf8>>},
            {<<"bun-linux-aarch64-musl"/utf8>>,
                <<"88c54cd66169aeb5ff31bc0c9d74a8017c7e6965597472ff49ecc355acb3a884"/utf8>>},
            {<<"bun-linux-aarch64"/utf8>>,
                <<"a97c687fb5e54de4e2fb0869a7ac9a2d9c3af75ac182e2b68138c1dd8f98131b"/utf8>>},
            {<<"bun-linux-x64-baseline"/utf8>>,
                <<"f753e8d9668078ab0f598ee26a9ac5acbbb822e057459dd50c191b86524d98e8"/utf8>>},
            {<<"bun-linux-x64-musl-baseline"/utf8>>,
                <<"4048e872b16fb3a296e89268769d3e41152f477b6f203eff58c672f69ed9f570"/utf8>>},
            {<<"bun-linux-x64-musl"/utf8>>,
                <<"dde5bd79f0e130cb9bf17f55ba1825e98a77f71ef78c575d8ca2ccae5431f47e"/utf8>>},
            {<<"bun-linux-x64"/utf8>>,
                <<"4c446af1a01d7b40e1e11baebc352f9b2bfd12887e51b97dd3b59879cee2743a"/utf8>>},
            {<<"bun-windows-x64-baseline"/utf8>>,
                <<"c44de73dc21c7140a8e15883c28abed60612196faaec9a60c275534280a49f59"/utf8>>},
            {<<"bun-windows-x64"/utf8>>,
                <<"3a28c685b47a159c5707d150accb5b4903c30f1e7b4dd01bb311d4112bdeb452"/utf8>>}],
        Name
    ) of
        {ok, Expected} -> Expected;
        _assert_fail ->
            erlang:error(#{gleam_error => let_assert,
                        message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                        file => <<?FILEPATH/utf8>>,
                        module => <<"lustre_dev_tools/bin/bun"/utf8>>,
                        function => <<"verify_integrity"/utf8>>,
                        line => 259,
                        value => _assert_fail,
                        start => 7236,
                        'end' => 7289,
                        pattern_start => 7247,
                        pattern_end => 7259})
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
            {error, {could_not_verify_bun_hash, Expected@1, Actual}}
    end.

-file("src/lustre_dev_tools/bin/bun.gleam", 30).
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
                <<<<<<<<"/oven-sh/bun/releases/download/bun-v"/utf8,
                                "1.2.22"/utf8>>/binary,
                            "/"/utf8>>/binary,
                        Name/binary>>/binary,
                    ".zip"/utf8>>,
                none},
            lustre_dev_tools@cli:log(
                <<"Downloading Bun v"/utf8, "1.2.22"/utf8>>,
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
                        fun(Field@0) -> {could_not_download_bun_binary, Field@0} end
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
                            gleam@result:'try'(
                                begin
                                    _pipe@4 = bun_ffi:extract(
                                        erlang:element(4, Res),
                                        erlang:element(8, Project)
                                    ),
                                    gleam@result:replace_error(
                                        _pipe@4,
                                        {could_not_extract_bun_archive,
                                            system_ffi:detect_os(),
                                            system_ffi:detect_arch(),
                                            <<"1.2.22"/utf8>>}
                                    )
                                end,
                                fun(Path) ->
                                    gleam@result:'try'(
                                        begin
                                            _pipe@5 = simplifile_erl:set_permissions_octal(
                                                Path,
                                                8#755
                                            ),
                                            gleam@result:map_error(
                                                _pipe@5,
                                                fun(_capture) ->
                                                    {could_not_write_file,
                                                        Path,
                                                        _capture}
                                                end
                                            )
                                        end,
                                        fun(_) ->
                                            gleam@result:'try'(
                                                verify_version(Path),
                                                fun(_) ->
                                                    lustre_dev_tools@cli:success(
                                                        <<<<"Bun v"/utf8,
                                                                "1.2.22"/utf8>>/binary,
                                                            " is ready to go!"/utf8>>,
                                                        Quiet
                                                    ),
                                                    {ok, Path}
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

-file("src/lustre_dev_tools/bin/bun.gleam", 193).
?DOC(false).
-spec locate_bun(lustre_dev_tools@project:project(), boolean()) -> {ok,
        binary()} |
    {error, lustre_dev_tools@error:error()}.
locate_bun(Project, Quiet) ->
    case tom:get_string(
        erlang:element(3, Project),
        [<<"bin"/utf8>>, <<"bun"/utf8>>]
    ) of
        {ok, <<"system"/utf8>>} ->
            _pipe = system_ffi:find(<<"bun"/utf8>>),
            _pipe@1 = gleam@result:replace_error(
                _pipe,
                {could_not_locate_bun_binary, <<"$PATH/bun"/utf8>>}
            ),
            gleam@result:map(
                _pipe@1,
                fun(Path) ->
                    lustre_dev_tools@cli:log(
                        <<"Using system Bun installation"/utf8>>,
                        Quiet
                    ),
                    Path
                end
            );

        {ok, Path@1} ->
            case simplifile_erl:is_file(Path@1) of
                {ok, true} ->
                    lustre_dev_tools@cli:log(
                        <<"Using local Bun installation"/utf8>>,
                        Quiet
                    ),
                    {ok, Path@1};

                {ok, false} ->
                    {error, {could_not_locate_bun_binary, Path@1}};

                {error, _} ->
                    {error, {could_not_locate_bun_binary, Path@1}}
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
                            lustre_dev_tools@system:executable_name(
                                <<"bun"/utf8>>
                            )
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

-file("src/lustre_dev_tools/bin/bun.gleam", 107).
?DOC(false).
-spec watch(
    lustre_dev_tools@project:project(),
    list(binary()),
    fun((binary(), binary()) -> nil)
) -> {ok, gleam@erlang@process:subject(lustre_dev_tools@port:message())} |
    {error, lustre_dev_tools@error:error()}.
watch(Project, Directories, On_change) ->
    gleam@result:'try'(
        locate_bun(Project, false),
        fun(Path) ->
            Priv@1 = case gleam_erlang_ffi:priv_directory(
                <<"lustre_dev_tools"/utf8>>
            ) of
                {ok, Priv} -> Priv;
                _assert_fail ->
                    erlang:error(#{gleam_error => let_assert,
                                message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                file => <<?FILEPATH/utf8>>,
                                module => <<"lustre_dev_tools/bin/bun"/utf8>>,
                                function => <<"watch"/utf8>>,
                                line => 114,
                                value => _assert_fail,
                                start => 3409,
                                'end' => 3477,
                                pattern_start => 3420,
                                pattern_end => 3428})
            end,
            Watcher = filepath:join(Priv@1, <<"bun-watcher.js"/utf8>>),
            gleam@result:'try'(
                begin
                    _pipe = lustre_dev_tools@port:start(
                        Path,
                        [Watcher],
                        fun(Event) ->
                            Decoder = begin
                                gleam@dynamic@decode:field(
                                    <<"in"/utf8>>,
                                    {decoder,
                                        fun gleam@dynamic@decode:decode_string/1},
                                    fun(Root) ->
                                        gleam@dynamic@decode:field(
                                            <<"name"/utf8>>,
                                            {decoder,
                                                fun gleam@dynamic@decode:decode_string/1},
                                            fun(File) ->
                                                gleam@dynamic@decode:success(
                                                    {Root, File}
                                                )
                                            end
                                        )
                                    end
                                )
                            end,
                            case gleam@dynamic@decode:run(Event, Decoder) of
                                {ok, {Root@1, File@1}} ->
                                    On_change(Root@1, File@1);

                                {error, _} ->
                                    nil
                            end
                        end,
                        fun() -> nil end
                    ),
                    gleam@result:replace_error(
                        _pipe,
                        {could_not_start_file_watcher,
                            Path,
                            system_ffi:detect_os(),
                            system_ffi:detect_arch()}
                    )
                end,
                fun(Port) ->
                    gleam@list:each(
                        Directories,
                        fun(Directory) ->
                            lustre_dev_tools@port:send(
                                Port,
                                (gleam@json:object(
                                    [{<<"$"/utf8>>,
                                            gleam@json:string(<<"start"/utf8>>)},
                                        {<<"path"/utf8>>,
                                            gleam@json:string(Directory)}]
                                ))
                            )
                        end
                    ),
                    {ok, Port}
                end
            )
        end
    ).

-file("src/lustre_dev_tools/bin/bun.gleam", 159).
?DOC(false).
-spec build(
    lustre_dev_tools@project:project(),
    list(binary()),
    binary(),
    boolean(),
    boolean()
) -> {ok, nil} | {error, lustre_dev_tools@error:error()}.
build(Project, Entries, Outdir, Minify, Quiet) ->
    gleam@result:'try'(
        locate_bun(Project, Quiet),
        fun(Cmd) ->
            Args = lists:append(
                [[<<"build"/utf8>>],
                    Entries,
                    'maybe'(Minify, [<<"--minify"/utf8>>], []),
                    'maybe'(
                        erlang:length(Entries) > 1,
                        [<<"--splitting"/utf8>>],
                        []
                    ),
                    [<<"--outdir"/utf8>>, Outdir]]
            ),
            lustre_dev_tools@cli:log(
                <<"Creating JavaScript bundle"/utf8>>,
                Quiet
            ),
            gleam@result:'try'(
                begin
                    _pipe = system_ffi:run(Cmd, Args, []),
                    gleam@result:map_error(
                        _pipe,
                        fun(Field@0) -> {failed_to_build_project, Field@0} end
                    )
                end,
                fun(_) ->
                    lustre_dev_tools@cli:success(
                        <<"Bundle successfully built."/utf8>>,
                        Quiet
                    ),
                    {ok, nil}
                end
            )
        end
    ).
