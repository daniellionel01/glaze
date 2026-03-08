-module(polly_ffi).

-export([spawn/3, repeatedly/3]).

-compile([no_auto_import]).

spawn(Timeout, State, Callback) ->
    Pid = proc_lib:spawn_link(fun() -> do_repeatedly(Timeout, State, Callback) end),
    Stop = fun() -> Pid ! stop end,
    {Pid, Stop}.

repeatedly(Timeout, State, Callback) ->
    {_Pid, Stop} = spawn(Timeout, State, Callback),
    Stop.

do_repeatedly(Timeout, State, Callback) ->
    receive
        stop ->
            ok
    after Timeout ->
        NewState = Callback(State),
        do_repeatedly(Timeout, NewState, Callback)
    end.
