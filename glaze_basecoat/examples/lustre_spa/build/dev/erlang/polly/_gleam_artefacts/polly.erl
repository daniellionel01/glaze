-module(polly).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/polly.gleam").
-export([add_dir/2, add_file/2, max_depth/2, interval/2, filter/2, default_filter/2, new/0, ignore_initial_missing/1, add_callback/2, add_subject/2, stop/1, describe_errors/1, step/2, init/1, watch/1, supervised/1, factory/0]).
-export_type([event/0, options/0, watcher/0, state/0, root/0, vfs/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-type event() :: {created, binary()} |
    {changed, binary()} |
    {deleted, binary()} |
    {error, binary(), simplifile:file_error()}.

-opaque options() :: {options,
        integer(),
        list(binary()),
        integer(),
        fun((simplifile:file_type(), binary()) -> boolean()),
        boolean(),
        list(fun((event()) -> nil))}.

-opaque watcher() :: {watcher, fun(() -> nil)}.

-opaque state() :: {state, list(root())}.

-type root() :: {missing, binary()} | {initialised, binary(), vfs()}.

-type vfs() :: {file, binary(), integer()} |
    {folder, binary(), integer(), list(vfs())}.

-file("src/polly.gleam", 103).
?DOC(
    " Tell Polly which directory to watch. If it does not exist, `watch` will return an error.\n"
    "\n"
    " If the directory goes away after watching has started, Polly will continue to\n"
    " check on it to see if it came back.\n"
    "\n"
    " Paths are not expanded by default, so the paths reported by events and passed\n"
    " to the filter function will be prefixed with whatever you specified here.\n"
).
-spec add_dir(options(), binary()) -> options().
add_dir(Options, Path) ->
    {options,
        erlang:element(2, Options),
        [Path | erlang:element(3, Options)],
        erlang:element(4, Options),
        erlang:element(5, Options),
        erlang:element(6, Options),
        erlang:element(7, Options)}.

-file("src/polly.gleam", 111).
?DOC(
    " Tell Polly to watch a single file.\n"
    "\n"
    " Polly doesn't care if you tell her to watch a file or directory, but\n"
    " using this function makes your intent clearer!\n"
).
-spec add_file(options(), binary()) -> options().
add_file(Options, Path) ->
    add_dir(Options, Path).

-file("src/polly.gleam", 126).
?DOC(
    " Limit the maximum depth that Polly will walk each directory.\n"
    "\n"
    " A limit of `0` would mean that Polly _only_ watches the specified list of\n"
    " files or directories. A limit of `1` means that she will also look at the\n"
    " files inside the given directories, but not at any nested directories.\n"
    "\n"
    " There is no limit by default, but setting a limit might be good to\n"
    " better control resource usage of the watcher.\n"
    "\n"
    " Calling this function multiple times will cause polly to only remember the\n"
    " lowest limit provided.\n"
).
-spec max_depth(options(), integer()) -> options().
max_depth(Options, Max_depth) ->
    case (erlang:element(4, Options) < 0) orelse (Max_depth < erlang:element(
        4,
        Options
    )) of
        true ->
            {options,
                erlang:element(2, Options),
                erlang:element(3, Options),
                Max_depth,
                erlang:element(5, Options),
                erlang:element(6, Options),
                erlang:element(7, Options)};

        false ->
            Options
    end.

-file("src/polly.gleam", 140).
?DOC(
    " Set the interval in-between file-system polls, in milliseconds.\n"
    "\n"
    " This is the time that Polly rests between calls, so if scanning your directory\n"
    " tree takes 100ms, and you configured 1000ms here, the total time between calls\n"
    " will roughly be 1100ms.\n"
    "\n"
    " Doing it this way makes sure that Polly doesn't stumble over herself.\n"
).
-spec interval(options(), integer()) -> options().
interval(Options, Interval) ->
    case Interval > 0 of
        true ->
            {options,
                Interval,
                erlang:element(3, Options),
                erlang:element(4, Options),
                erlang:element(5, Options),
                erlang:element(6, Options),
                erlang:element(7, Options)};

        false ->
            Options
    end.

-file("src/polly.gleam", 159).
?DOC(
    " Filter files using the given predicate.\n"
    "\n"
    " Polly will ignore files and directories for which the predicate returns `False`\n"
    " completely, and any event happening for them or for a contained file of them\n"
    " will not get reported.\n"
    "\n"
    " Keep in mind that the filter is checked for every part of a path, not just\n"
    " leaf nodes! So for example, if you have a path `./src/app.gleam`, your filter\n"
    " function will first be called on `.`, then on `./src`, and then finally on\n"
    " `./src/app.gleam`.\n"
    "\n"
    " By default, all hidden files are ignored by using the `default_filter`.\n"
).
-spec filter(options(), fun((simplifile:file_type(), binary()) -> boolean())) -> options().
filter(Options, Filter) ->
    {options,
        erlang:element(2, Options),
        erlang:element(3, Options),
        erlang:element(4, Options),
        Filter,
        erlang:element(6, Options),
        erlang:element(7, Options)}.

-file("src/polly.gleam", 164).
?DOC(" The default filter function, ignoring hidden files starting with a colon `\".\"`\n").
-spec default_filter(simplifile:file_type(), binary()) -> boolean().
default_filter(_, Path) ->
    case filepath:base_name(Path) of
        <<"."/utf8>> ->
            true;

        <<".."/utf8>> ->
            true;

        Basename ->
            not gleam_stdlib:string_starts_with(Basename, <<"."/utf8>>)
    end.

-file("src/polly.gleam", 85).
?DOC(
    " Start creating a new configuration using the default options.\n"
    "\n"
    " By default, an interval of 1 second is set, and the `default_filter` is used.\n"
).
-spec new() -> options().
new() ->
    {options, 1000, [], -1, fun default_filter/2, false, []}.

-file("src/polly.gleam", 179).
?DOC(
    " Tell Polly that it is fine if a file or directory does not exist initially.\n"
    "\n"
    " By default, if a file or directory cannot be found when calling `watch`,\n"
    " Polly will immediately return to you with an `Enoent` error and refuse to run.\n"
    "\n"
    " When this option is active, Polly will instead note the missing directory,\n"
    " and continuously check if it appears, similarly to how she does after a\n"
    " file or directory goes away after she has first seen it.\n"
).
-spec ignore_initial_missing(options()) -> options().
ignore_initial_missing(Options) ->
    {options,
        erlang:element(2, Options),
        erlang:element(3, Options),
        erlang:element(4, Options),
        erlang:element(5, Options),
        true,
        erlang:element(7, Options)}.

-file("src/polly.gleam", 188).
?DOC(
    " Add a callback function that Polly will call whenever she spots an event.\n"
    "\n"
    " You can add multiple callbacks, and Polly will call them each with the event\n"
    " in an undefined order. The callbacks are called synchronously while she's collecting\n"
    " change events, so it's a good idea to keep them light and fast!\n"
).
-spec add_callback(options(), fun((event()) -> nil)) -> options().
add_callback(Options, Callback) ->
    {options,
        erlang:element(2, Options),
        erlang:element(3, Options),
        erlang:element(4, Options),
        erlang:element(5, Options),
        erlang:element(6, Options),
        [Callback | erlang:element(7, Options)]}.

-file("src/polly.gleam", 201).
?DOC(
    " Add a subject that Polly will send events to.\n"
    "\n"
    " This is a convenience wrapper around `add_callback` for when you want to\n"
    " send events to a process subject. Polly will use `process.send` to deliver\n"
    " each event to your subject.\n"
).
-spec add_subject(options(), gleam@erlang@process:subject(event())) -> options().
add_subject(Options, Subject) ->
    add_callback(
        Options,
        fun(_capture) -> gleam@erlang@process:send(Subject, _capture) end
    ).

-file("src/polly.gleam", 267).
-spec broadcast(list(fun((event()) -> nil)), event()) -> nil.
broadcast(Callbacks, Event) ->
    gleam@list:each(Callbacks, fun(Callback) -> Callback(Event) end).

-file("src/polly.gleam", 276).
?DOC(
    " Stop this watcher.\n"
    "\n"
    " If Polly currently scans your directories, she might not hear you rightdo_inity\n"
    " and may still report events for one run, after which she will stop.\n"
).
-spec stop(watcher()) -> nil.
stop(Watcher) ->
    (erlang:element(2, Watcher))().

-file("src/polly.gleam", 284).
?DOC(
    " Format a list of file errors into a human-readable string.\n"
    "\n"
    " This is handy when `watch` returns errors and you want to show them to\n"
    " your users. Each error is formatted as \"path: description\" on its own line.\n"
).
-spec describe_errors(list({binary(), simplifile:file_error()})) -> binary().
describe_errors(Errors) ->
    _pipe = Errors,
    _pipe@1 = gleam@list:map(
        _pipe,
        fun(Error) ->
            {Path, Error@1} = Error,
            <<<<Path/binary, ": "/utf8>>/binary,
                (simplifile:describe_error(Error@1))/binary>>
        end
    ),
    gleam@string:join(_pipe@1, <<"\n"/utf8>>).

-file("src/polly.gleam", 305).
-spec root(binary(), gleam@option:option(vfs())) -> root().
root(Path, Vfs) ->
    case Vfs of
        {some, Vfs@1} ->
            {initialised, Path, Vfs@1};

        none ->
            {missing, Path}
    end.

-file("src/polly.gleam", 665).
-spec delete(binary(), vfs(), list(event())) -> list(event()).
delete(Full_path, Vfs, Events) ->
    case Vfs of
        {file, _, _} ->
            [{deleted, Full_path} | Events];

        {folder, _, _, Children} ->
            Events@2 = gleam@list:fold(
                Children,
                Events,
                fun(Events@1, Child) ->
                    delete(
                        filepath:join(Full_path, erlang:element(2, Child)),
                        Child,
                        Events@1
                    )
                end
            ),
            [{deleted, Full_path} | Events@2]
    end.

-file("src/polly.gleam", 678).
-spec get_modkey(simplifile:file_info()) -> integer().
get_modkey(Stat) ->
    gleam@int:max(erlang:element(10, Stat), erlang:element(11, Stat)).

-file("src/polly.gleam", 682).
-spec readdir(binary()) -> {ok, list(binary())} |
    {error, simplifile:file_error()}.
readdir(Path) ->
    _pipe = simplifile_erl:read_directory(Path),
    gleam@result:map(
        _pipe,
        fun(_capture) ->
            gleam@list:sort(_capture, fun gleam@string:compare/2)
        end
    ).

-file("src/polly.gleam", 609).
-spec children(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    list(vfs()),
    list(binary()),
    list(vfs()),
    list(event())
) -> {list(vfs()), list(event())}.
children(Filter, Depth, Path, Old_children, Entries, New_children, Events) ->
    case {Old_children, Entries} of
        {[], []} ->
            {lists:reverse(New_children), Events};

        {[Prev | Olds], [Entry | Rest]} ->
            case gleam@string:compare(erlang:element(2, Prev), Entry) of
                eq ->
                    {Vfs_opt, Events@1} = diff(
                        Filter,
                        Depth,
                        Path,
                        Prev,
                        Events
                    ),
                    News = case Vfs_opt of
                        {some, New_vfs} ->
                            [New_vfs | New_children];

                        none ->
                            New_children
                    end,
                    children(Filter, Depth, Path, Olds, Rest, News, Events@1);

                gt ->
                    {Vfs_opt@1, Events@2} = create(
                        Filter,
                        Depth,
                        Path,
                        Entry,
                        Events
                    ),
                    News@1 = case Vfs_opt@1 of
                        {some, New_vfs@1} ->
                            [New_vfs@1 | New_children];

                        none ->
                            New_children
                    end,
                    children(
                        Filter,
                        Depth,
                        Path,
                        Old_children,
                        Rest,
                        News@1,
                        Events@2
                    );

                lt ->
                    Events@3 = delete(
                        filepath:join(Path, erlang:element(2, Prev)),
                        Prev,
                        Events
                    ),
                    children(
                        Filter,
                        Depth,
                        Path,
                        Olds,
                        Entries,
                        New_children,
                        Events@3
                    )
            end;

        {[], [Entry@1 | Entries@1]} ->
            {Vfs_opt@2, Events@4} = create(Filter, Depth, Path, Entry@1, Events),
            News@2 = case Vfs_opt@2 of
                {some, New_vfs@2} ->
                    [New_vfs@2 | New_children];

                none ->
                    New_children
            end,
            children(
                Filter,
                Depth,
                Path,
                Old_children,
                Entries@1,
                News@2,
                Events@4
            );

        {[Prev@1 | Olds@1], []} ->
            Events@5 = delete(
                filepath:join(Path, erlang:element(2, Prev@1)),
                Prev@1,
                Events
            ),
            children(
                Filter,
                Depth,
                Path,
                Olds@1,
                Entries,
                New_children,
                Events@5
            )
    end.

-file("src/polly.gleam", 538).
-spec diff(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    vfs(),
    list(event())
) -> {gleam@option:option(vfs()), list(event())}.
diff(Filter, Depth, Path, Vfs, Events) ->
    Full_path = filepath:join(Path, erlang:element(2, Vfs)),
    case simplifile_erl:link_info(Full_path) of
        {ok, Stat} ->
            case Filter(simplifile:file_info_type(Stat), Full_path) of
                true ->
                    do_diff(Filter, Depth, Vfs, Stat, Full_path, Events);

                false ->
                    {none, delete(Full_path, Vfs, Events)}
            end;

        {error, eacces} ->
            {none, delete(Full_path, Vfs, Events)};

        {error, enoent} ->
            {none, delete(Full_path, Vfs, Events)};

        {error, Reason} ->
            {{some, Vfs}, [{error, Path, Reason} | Events]}
    end.

-file("src/polly.gleam", 563).
-spec do_diff(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    vfs(),
    simplifile:file_info(),
    binary(),
    list(event())
) -> {gleam@option:option(vfs()), list(event())}.
do_diff(Filter, Depth, Vfs, Stat, Path, Events) ->
    Type_ = simplifile:file_info_type(Stat),
    case {Type_, Vfs} of
        {file, {file, Name, Old_key}} ->
            case get_modkey(Stat) of
                Key when Key =:= Old_key ->
                    {{some, Vfs}, Events};

                Key@1 ->
                    {{some, {file, Name, Key@1}}, [{changed, Path} | Events]}
            end;

        {directory, {folder, _, _, _}} when Depth =:= 0 ->
            {{some, Vfs}, Events};

        {directory, {folder, Name@1, _, Old_children}} when Depth =/= 0 ->
            case readdir(Path) of
                {ok, Entries} ->
                    {Children, Events@1} = children(
                        Filter,
                        Depth - 1,
                        Path,
                        Old_children,
                        Entries,
                        [],
                        Events
                    ),
                    {{some, {folder, Name@1, get_modkey(Stat), Children}},
                        Events@1};

                {error, enoent} ->
                    {none, delete(Path, Vfs, Events)};

                {error, eacces} ->
                    {none, delete(Path, Vfs, Events)};

                {error, Reason} ->
                    {{some, Vfs}, [{error, Path, Reason} | Events]}
            end;

        {_, _} ->
            Events@2 = delete(Path, Vfs, Events),
            create_stat(
                Filter,
                Depth,
                erlang:element(2, Vfs),
                Path,
                Stat,
                Events@2
            )
    end.

-file("src/polly.gleam", 517).
-spec create_children(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    list(binary()),
    list(vfs()),
    list(event())
) -> {list(vfs()), list(event())}.
create_children(Filter, Depth, Path, Children, Oks, Events) ->
    case Children of
        [] ->
            {lists:reverse(Oks), Events};

        [First | Rest] ->
            {Vfs_opt, Events@1} = create(Filter, Depth, Path, First, Events),
            Oks@1 = case Vfs_opt of
                {some, Vfs} ->
                    [Vfs | Oks];

                none ->
                    Oks
            end,
            create_children(Filter, Depth, Path, Rest, Oks@1, Events@1)
    end.

-file("src/polly.gleam", 462).
-spec create(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    binary(),
    list(event())
) -> {gleam@option:option(vfs()), list(event())}.
create(Filter, Depth, Path, Name, Events) ->
    Full_path = filepath:join(Path, Name),
    case simplifile_erl:link_info(Full_path) of
        {ok, Stat} ->
            create_stat(Filter, Depth, Name, Full_path, Stat, Events);

        {error, enoent} ->
            {none, Events};

        {error, eacces} ->
            {none, Events};

        {error, Reason} ->
            {none, [{error, Full_path, Reason} | Events]}
    end.

-file("src/polly.gleam", 478).
-spec create_stat(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    binary(),
    simplifile:file_info(),
    list(event())
) -> {gleam@option:option(vfs()), list(event())}.
create_stat(Filter, Depth, Name, Full_path, Stat, Events) ->
    Type_ = simplifile:file_info_type(Stat),
    gleam@bool:guard(
        not Filter(Type_, Full_path),
        {none, Events},
        fun() -> case Type_ of
                file ->
                    {{some, {file, Name, get_modkey(Stat)}},
                        [{created, Full_path} | Events]};

                directory when Depth =:= 0 ->
                    {{some, {folder, Name, get_modkey(Stat), []}},
                        [{created, Full_path} | Events]};

                directory when Depth =/= 0 ->
                    case readdir(Full_path) of
                        {ok, Entries} ->
                            Depth@1 = Depth - 1,
                            Events@1 = [{created, Full_path} | Events],
                            {Children, Events@2} = create_children(
                                Filter,
                                Depth@1,
                                Full_path,
                                Entries,
                                [],
                                Events@1
                            ),
                            {{some, {folder, Name, get_modkey(Stat), Children}},
                                Events@2};

                        {error, enoent} ->
                            {none, Events};

                        {error, eacces} ->
                            {none, Events};

                        {error, Reason} ->
                            {none, [{error, Full_path, Reason} | Events]}
                    end;

                _ ->
                    {none, Events}
            end end
    ).

-file("src/polly.gleam", 358).
-spec step_roots(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    list(root()),
    list(root()),
    list(event())
) -> {list(root()), list(event())}.
step_roots(Filter, Max_depth, Roots, New_roots, Events) ->
    case Roots of
        [] ->
            {New_roots, Events};

        [{initialised, Path, Vfs} | Rest] ->
            {Vfs@1, Events@1} = diff(Filter, Max_depth, Path, Vfs, Events),
            New_roots@1 = [root(Path, Vfs@1) | New_roots],
            step_roots(Filter, Max_depth, Rest, New_roots@1, Events@1);

        [{missing, Path@1} | Rest@1] ->
            {New_vfs, Events@2} = create(
                Filter,
                Max_depth,
                Path@1,
                <<""/utf8>>,
                Events
            ),
            New_roots@2 = [root(Path@1, New_vfs) | New_roots],
            step_roots(Filter, Max_depth, Rest@1, New_roots@2, Events@2)
    end.

-file("src/polly.gleam", 352).
?DOC(
    " Perform a single polling step, returning the updated state and any events\n"
    " that were detected since the last step.\n"
    "\n"
    " Events are ordered the same way as with `watch`: directories are reported\n"
    " before their contents on creation, and contents are reported before their\n"
    " parent on deletion.\n"
    "\n"
    " Note that this function will NOT call the configured callbacks or send\n"
    " messages to the registered subjects.\n"
).
-spec step(options(), state()) -> {state(), list(event())}.
step(Options, State) ->
    {options, _, _, Max_depth, Filter, _, _} = Options,
    {New_roots, Events} = step_roots(
        Filter,
        Max_depth,
        erlang:element(2, State),
        [],
        []
    ),
    {{state, New_roots}, lists:reverse(Events)}.

-file("src/polly.gleam", 261).
-spec run(options(), state()) -> state().
run(Options, State) ->
    {State@1, Events} = step(Options, State),
    gleam@list:each(
        Events,
        fun(_capture) -> broadcast(erlang:element(7, Options), _capture) end
    ),
    State@1.

-file("src/polly.gleam", 442).
-spec init_children(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    list(binary()),
    list(vfs()),
    list({binary(), simplifile:file_error()})
) -> {list(vfs()), list({binary(), simplifile:file_error()})}.
init_children(Filter, Depth, Path, Children, Oks, Errors) ->
    case Children of
        [] ->
            {lists:reverse(Oks), Errors};

        [First | Rest] ->
            case do_init(Filter, Depth, Path, First, Errors) of
                {{some, Vfs}, Errors@1} ->
                    init_children(
                        Filter,
                        Depth,
                        Path,
                        Rest,
                        [Vfs | Oks],
                        Errors@1
                    );

                {none, Errors@2} ->
                    init_children(Filter, Depth, Path, Rest, Oks, Errors@2)
            end
    end.

-file("src/polly.gleam", 388).
-spec do_init(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    binary(),
    list({binary(), simplifile:file_error()})
) -> {gleam@option:option(vfs()), list({binary(), simplifile:file_error()})}.
do_init(Filter, Depth, Path, Name, Errors) ->
    Full_path = filepath:join(Path, Name),
    case simplifile_erl:link_info(Full_path) of
        {ok, Stat} ->
            init_stat(Filter, Depth, Name, Full_path, Stat, Errors);

        {error, enoent} ->
            {none, Errors};

        {error, eacces} ->
            {none, Errors};

        {error, Reason} ->
            {none, [{Full_path, Reason} | Errors]}
    end.

-file("src/polly.gleam", 404).
-spec init_stat(
    fun((simplifile:file_type(), binary()) -> boolean()),
    integer(),
    binary(),
    binary(),
    simplifile:file_info(),
    list({binary(), simplifile:file_error()})
) -> {gleam@option:option(vfs()), list({binary(), simplifile:file_error()})}.
init_stat(Filter, Depth, Name, Full_path, Stat, Errors) ->
    Type_ = simplifile:file_info_type(Stat),
    gleam@bool:guard(
        not Filter(Type_, Full_path),
        {none, Errors},
        fun() -> case Type_ of
                file ->
                    {{some, {file, Name, get_modkey(Stat)}}, Errors};

                directory when Depth =:= 0 ->
                    {{some, {folder, Name, get_modkey(Stat), []}}, Errors};

                directory when Depth =/= 0 ->
                    case readdir(Full_path) of
                        {ok, Entries} ->
                            Depth@1 = Depth - 1,
                            {Children, Errors@1} = init_children(
                                Filter,
                                Depth@1,
                                Full_path,
                                Entries,
                                [],
                                Errors
                            ),
                            {{some, {folder, Name, get_modkey(Stat), Children}},
                                Errors@1};

                        {error, enoent} ->
                            {none, Errors};

                        {error, eacces} ->
                            {none, Errors};

                        {error, Reason} ->
                            {none, [{Full_path, Reason} | Errors]}
                    end;

                _ ->
                    {none, []}
            end end
    ).

-file("src/polly.gleam", 320).
?DOC(
    " Initialise Polly's internal state by scanning all the specified paths.\n"
    "\n"
    " This is the manual alternative to `watch` — it gives you direct access to\n"
    " Polly's state so you can drive the polling loop yourself.\n"
    "\n"
    " Returns an error if any of the specified paths cannot be found and\n"
    " `ignore_initial_missing` has not been set. Use `step` to advance the state\n"
    " and collect events.\n"
).
-spec init(options()) -> {ok, state()} |
    {error, list({binary(), simplifile:file_error()})}.
init(Options) ->
    {options, _, Paths, Max_depth, Filter, Ignore_initial_missing, _} = Options,
    gleam@bool:guard(
        Paths =:= [],
        {error, []},
        fun() ->
            Roots = begin
                gleam@list:try_map(
                    Paths,
                    fun(Path) ->
                        case do_init(Filter, Max_depth, Path, <<""/utf8>>, []) of
                            {{some, Vfs}, []} ->
                                {ok, {initialised, Path, Vfs}};

                            {none, []} ->
                                case Ignore_initial_missing of
                                    false ->
                                        {error, [{Path, enoent}]};

                                    true ->
                                        {ok, {missing, Path}}
                                end;

                            {_, Errors} ->
                                {error, Errors}
                        end
                    end
                )
            end,
            gleam@result:map(Roots, fun(Field@0) -> {state, Field@0} end)
        end
    ).

-file("src/polly.gleam", 217).
?DOC(
    " Tell Polly to start watching all the specified directories for changes.\n"
    "\n"
    " The callbacks are called synchronously while collecting change events since\n"
    " the last run. It is adviseable to move heavier cpu-bound tasks from this\n"
    " callback into their own processes or threads.\n"
    "\n"
    " When running on the Erlang target, this spawns a new linked process.\n"
).
-spec watch(options()) -> {ok, watcher()} |
    {error, list({binary(), simplifile:file_error()})}.
watch(Options) ->
    gleam@result:'try'(
        init(Options),
        fun(Roots) ->
            Stop = polly_ffi:repeatedly(
                erlang:element(2, Options),
                Roots,
                fun(_capture) -> run(Options, _capture) end
            ),
            {ok, {watcher, Stop}}
        end
    ).

-file("src/polly.gleam", 248).
-spec start_process(options()) -> {ok, gleam@otp@actor:started(watcher())} |
    {error, gleam@otp@actor:start_error()}.
start_process(Options) ->
    gleam@result:'try'(
        begin
            _pipe = init(Options),
            gleam@result:map_error(
                _pipe,
                fun(Errors) -> {init_failed, describe_errors(Errors)} end
            )
        end,
        fun(Roots) ->
            {Pid, Stop} = polly_ffi:spawn(
                erlang:element(2, Options),
                Roots,
                fun(_capture) -> run(Options, _capture) end
            ),
            {ok, {started, Pid, {watcher, Stop}}}
        end
    ).

-file("src/polly.gleam", 231).
?DOC(
    " Create a child specification for running Polly under a supervisor.\n"
    "\n"
    " This lets you add Polly to your supervision tree, so she'll automatically\n"
    " restart if something goes wrong. The supervisor will make sure she keeps\n"
    " watching your files reliably!\n"
).
-spec supervised(options()) -> gleam@otp@supervision:child_specification(watcher()).
supervised(Options) ->
    gleam@otp@supervision:worker(fun() -> start_process(Options) end).

-file("src/polly.gleam", 242).
?DOC(
    " Create a factory builder for dynamically starting multiple Polly watchers.\n"
    "\n"
    " This is useful when you want to spawn and manage multiple watchers at runtime,\n"
    " each watching different paths with different options. The factory supervisor\n"
    " handles starting, stopping, and supervising all your Polly instances!\n"
).
-spec factory() -> gleam@otp@factory_supervisor:builder(options(), watcher()).
factory() ->
    gleam@otp@factory_supervisor:worker_child(
        fun(Options) -> start_process(Options) end
    ).
