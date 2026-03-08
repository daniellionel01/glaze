-module(lustre@vdom@path).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/vdom/path.gleam").
-export([add/3, subtree/1, split_subtree_path/1, child/1, to_string/1, matches/2, event/2]).
-export_type([path/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-opaque path() :: root |
    {key, binary(), path()} |
    {index, integer(), path()} |
    {subtree, path()}.

-file("src/lustre/vdom/path.gleam", 47).
?DOC(false).
-spec do_matches(binary(), list(binary())) -> boolean().
do_matches(Path, Candidates) ->
    case Candidates of
        [] ->
            false;

        [Candidate | Rest] ->
            case gleam_stdlib:string_starts_with(Path, Candidate) of
                true ->
                    true;

                false ->
                    do_matches(Path, Rest)
            end
    end.

-file("src/lustre/vdom/path.gleam", 66).
?DOC(false).
-spec add(path(), integer(), binary()) -> path().
add(Parent, Index, Key) ->
    case Key of
        <<""/utf8>> ->
            {index, Index, Parent};

        _ ->
            {key, Key, Parent}
    end.

-file("src/lustre/vdom/path.gleam", 73).
?DOC(false).
-spec subtree(path()) -> path().
subtree(Path) ->
    {subtree, Path}.

-file("src/lustre/vdom/path.gleam", 119).
?DOC(false).
-spec finish_to_string(list(binary())) -> binary().
finish_to_string(Acc) ->
    case Acc of
        [] ->
            <<""/utf8>>;

        [_ | Segments] ->
            erlang:list_to_binary(Segments)
    end.

-file("src/lustre/vdom/path.gleam", 58).
?DOC(false).
-spec split_subtree_path(binary()) -> list(binary()).
split_subtree_path(Path) ->
    gleam@string:split(Path, <<"\r"/utf8>>).

-file("src/lustre/vdom/path.gleam", 98).
?DOC(false).
-spec do_to_string(boolean(), path(), list(binary())) -> binary().
do_to_string(Full, Path, Acc) ->
    case Path of
        root ->
            finish_to_string(Acc);

        {key, Key, Parent} ->
            do_to_string(Full, Parent, [<<"\t"/utf8>>, Key | Acc]);

        {index, Index, Parent@1} ->
            Acc@1 = [<<"\t"/utf8>>, erlang:integer_to_binary(Index) | Acc],
            do_to_string(Full, Parent@1, Acc@1);

        {subtree, _} when not Full ->
            finish_to_string(Acc);

        {subtree, Parent@2} ->
            case Acc of
                [] ->
                    do_to_string(Full, Parent@2, Acc);

                [_ | Acc@2] ->
                    do_to_string(Full, Parent@2, [<<"\r"/utf8>> | Acc@2])
            end
    end.

-file("src/lustre/vdom/path.gleam", 88).
?DOC(false).
-spec child(path()) -> binary().
child(Path) ->
    do_to_string(false, Path, []).

-file("src/lustre/vdom/path.gleam", 94).
?DOC(false).
-spec to_string(path()) -> binary().
to_string(Path) ->
    do_to_string(true, Path, []).

-file("src/lustre/vdom/path.gleam", 40).
?DOC(false).
-spec matches(path(), list(binary())) -> boolean().
matches(Path, Candidates) ->
    case Candidates of
        [] ->
            false;

        _ ->
            do_matches(to_string(Path), Candidates)
    end.

-file("src/lustre/vdom/path.gleam", 82).
?DOC(false).
-spec event(path(), binary()) -> binary().
event(Path, Event) ->
    do_to_string(false, Path, [<<"\n"/utf8>>, Event | []]).
