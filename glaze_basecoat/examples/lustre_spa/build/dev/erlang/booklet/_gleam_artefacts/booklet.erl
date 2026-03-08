-module(booklet).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/booklet.gleam").
-export([new/1, get/1, update/2, set/2, erase/1]).
-export_type([booklet/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-type booklet(S) :: any() | {gleam_phantom, S}.

-file("src/booklet.gleam", 18).
?DOC(" Create a new Booklet, storing an initial value in it.\n").
-spec new(T) -> booklet(T).
new(Initial_value) ->
    booklet_ffi:make(Initial_value).

-file("src/booklet.gleam", 23).
?DOC(" Get the current value stored in the Booklet.\n").
-spec get(booklet(V)) -> V.
get(Booklet) ->
    booklet_ffi:get(Booklet).

-file("src/booklet.gleam", 34).
?DOC(
    " Atomically update the value stored in the booklet, and return the final value.\n"
    "\n"
    " Updates are guaranteed to be atomic and serialisable. If multiple processes\n"
    " try to update the value at the same time, all but one process  have to retry\n"
    " their update operation (by calling the updater again) until the update succeeds.\n"
    "\n"
    " Note that Javascript is single-threaded, so no extra guards are in place.\n"
).
-spec update(booklet(X), fun((X) -> X)) -> X.
update(Booklet, Updater) ->
    booklet_ffi:update(Booklet, Updater).

-file("src/booklet.gleam", 42).
?DOC(" Atomically replace the value stored in the booklet.\n").
-spec set(booklet(Z), Z) -> nil.
set(Booklet, New_value) ->
    booklet_ffi:set(Booklet, New_value).

-file("src/booklet.gleam", 50).
?DOC(
    " Erase the value stored in a booklet, resetting it to it's default\n"
    " value provided to `new`.\n"
    "\n"
    " On Erlang, this will remove the ETS Table entry.\n"
).
-spec erase(booklet(any())) -> nil.
erase(Booklet) ->
    booklet_ffi:erase(Booklet).
