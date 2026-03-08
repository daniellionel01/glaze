-module(booklet_ffi).

-behaviour(application).

-export([start/2, stop/1]).
-export([make/1, get/1, set/2, update/2, erase/1]).

-compile([no_auto_import]).

% -- Public API ----------------------------------------------------------------

make(DefaultValue) ->
    {erlang:make_ref(), DefaultValue}.

get({Key, DefaultValue}) ->
    Table = persistent_term:get(?MODULE),
    try
        ets:lookup_element(Table, Key, 3)
    catch
        error:badarg ->
            DefaultValue
    end.

set({Key, _}, Value) ->
    Table = persistent_term:get(?MODULE),
    true = ets:insert(Table, {Key, 0, Value}),
    nil.

update({Key, DefaultValue} = Booklet, Updater) ->
    Table = persistent_term:get(?MODULE),
    case ets:lookup(Table, Key) of
        [{_, Rev, Value}] ->
            NewValue = Updater(Value),
            Replacement = {const, {Key, Rev + 1, NewValue}},
            case ets:select_replace(Table, [{{Key, Rev, '_'}, [], [Replacement]}]) of
                0 ->
                    update(Booklet, Updater);
                _ ->
                    NewValue
            end;
        [] ->
            NewValue = Updater(DefaultValue),
            case ets:insert_new(Table, {Key, 0, NewValue}) of
                true ->
                    NewValue;
                false ->
                    update(Booklet, Updater)
            end
    end.

erase({Key, _}) ->
    Table = persistent_term:get(?MODULE),
    ets:delete(Table, Key),
    nil.

% -- APPLICATION ---------------------------------------------------------------

start(_StartType, _StartArgs) ->
    Table =
        ets:new(booklet,
                [set, public, {keypos, 1}, {write_concurrency, auto}, {read_concurrency, true}]),
    ok = persistent_term:put(?MODULE, Table),
    {ok, erlang:self()}.

stop(_State) ->
    persistent_term:erase(?MODULE),
    ok.
