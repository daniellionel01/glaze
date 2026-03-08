-module(glisten@internal@handler).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glisten/internal/handler.gleam").
-export([continue/1, with_selector/2, stop/0, stop_abnormal/1, start/1]).
-export_type([internal_message/0, message/1, loop_message/1, loop_state/2, connection/1, next/2, handler/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(false).

-type internal_message() :: close |
    ready |
    {receive_message, bitstring()} |
    ssl_closed |
    tcp_closed.

-type message(FYY) :: {internal, internal_message()} | {user, FYY}.

-type loop_message(FYZ) :: {packet, bitstring()} | {custom, FYZ}.

-type loop_state(FZA, FZB) :: {loop_state,
        {ok, {glisten@socket@options:ip_address(), integer()}} | {error, nil},
        glisten@socket:socket(),
        gleam@erlang@process:subject(message(FZB)),
        glisten@transport:transport(),
        FZA}.

-type connection(FZC) :: {connection,
        {ok, {glisten@socket@options:ip_address(), integer()}} | {error, nil},
        glisten@socket:socket(),
        glisten@transport:transport(),
        gleam@erlang@process:subject(message(FZC))}.

-type next(FZD, FZE) :: {continue,
        FZD,
        gleam@option:option(gleam@erlang@process:selector(FZE))} |
    normal_stop |
    {abnormal_stop, binary()}.

-type handler(FZF, FZG) :: {handler,
        glisten@socket:socket(),
        fun((FZF, loop_message(FZG), connection(FZG)) -> next(FZF, loop_message(FZG))),
        fun((connection(FZG)) -> {FZF,
            gleam@option:option(gleam@erlang@process:selector(FZG))}),
        gleam@option:option(fun((FZF) -> nil)),
        glisten@transport:transport()}.

-file("src/glisten/internal/handler.gleam", 65).
?DOC(false).
-spec continue(FZT) -> next(FZT, any()).
continue(State) ->
    {continue, State, none}.

-file("src/glisten/internal/handler.gleam", 69).
?DOC(false).
-spec with_selector(next(FZX, FZY), gleam@erlang@process:selector(FZY)) -> next(FZX, FZY).
with_selector(Next, Selector) ->
    case Next of
        {continue, State, _} ->
            {continue, State, {some, Selector}};

        Stop ->
            Stop
    end.

-file("src/glisten/internal/handler.gleam", 79).
?DOC(false).
-spec stop() -> next(any(), any()).
stop() ->
    normal_stop.

-file("src/glisten/internal/handler.gleam", 83).
?DOC(false).
-spec stop_abnormal(binary()) -> next(any(), any()).
stop_abnormal(Reason) ->
    {abnormal_stop, Reason}.

-file("src/glisten/internal/handler.gleam", 103).
?DOC(false).
-spec start(handler(any(), GAN)) -> {ok,
        gleam@otp@actor:started(gleam@erlang@process:subject(message(GAN)))} |
    {error, gleam@otp@actor:start_error()}.
start(Handler) ->
    _pipe@18 = gleam@otp@actor:new_with_initialiser(
        1000,
        fun(Subject) ->
            Client_ip = begin
                _pipe = glisten@transport:peername(
                    erlang:element(6, Handler),
                    erlang:element(2, Handler)
                ),
                gleam@result:replace_error(_pipe, nil)
            end,
            Connection = {connection,
                Client_ip,
                erlang:element(2, Handler),
                erlang:element(6, Handler),
                Subject},
            {Initial_state, User_selector} = (erlang:element(4, Handler))(
                Connection
            ),
            Base_selector = begin
                _pipe@1 = gleam_erlang_ffi:new_selector(),
                gleam@erlang@process:select(_pipe@1, Subject)
            end,
            Selector = begin
                _pipe@2 = gleam_erlang_ffi:new_selector(),
                _pipe@5 = gleam@erlang@process:select_record(
                    _pipe@2,
                    erlang:binary_to_atom(<<"tcp"/utf8>>),
                    2,
                    fun(Record) ->
                        _pipe@3 = begin
                            gleam@dynamic@decode:field(
                                2,
                                {decoder,
                                    fun gleam@dynamic@decode:decode_bit_array/1},
                                fun(Data) ->
                                    gleam@dynamic@decode:success(
                                        {receive_message, Data}
                                    )
                                end
                            )
                        end,
                        _pipe@4 = gleam@dynamic@decode:run(Record, _pipe@3),
                        gleam@result:unwrap(_pipe@4, {receive_message, <<>>})
                    end
                ),
                _pipe@8 = gleam@erlang@process:select_record(
                    _pipe@5,
                    erlang:binary_to_atom(<<"ssl"/utf8>>),
                    2,
                    fun(Record@1) ->
                        _pipe@6 = begin
                            gleam@dynamic@decode:field(
                                2,
                                {decoder,
                                    fun gleam@dynamic@decode:decode_bit_array/1},
                                fun(Data@1) ->
                                    gleam@dynamic@decode:success(
                                        {receive_message, Data@1}
                                    )
                                end
                            )
                        end,
                        _pipe@7 = gleam@dynamic@decode:run(Record@1, _pipe@6),
                        gleam@result:unwrap(_pipe@7, {receive_message, <<>>})
                    end
                ),
                _pipe@9 = gleam@erlang@process:select_record(
                    _pipe@8,
                    erlang:binary_to_atom(<<"ssl_closed"/utf8>>),
                    1,
                    fun(_) -> ssl_closed end
                ),
                _pipe@10 = gleam@erlang@process:select_record(
                    _pipe@9,
                    erlang:binary_to_atom(<<"tcp_closed"/utf8>>),
                    1,
                    fun(_) -> tcp_closed end
                ),
                _pipe@11 = gleam_erlang_ffi:map_selector(
                    _pipe@10,
                    fun(Field@0) -> {internal, Field@0} end
                ),
                gleam_erlang_ffi:merge_selector(_pipe@11, Base_selector)
            end,
            Selector@1 = case User_selector of
                {some, Sel} ->
                    _pipe@12 = Sel,
                    _pipe@13 = gleam_erlang_ffi:map_selector(
                        _pipe@12,
                        fun(Field@0) -> {user, Field@0} end
                    ),
                    gleam_erlang_ffi:merge_selector(Selector, _pipe@13);

                _ ->
                    Selector
            end,
            _pipe@14 = {loop_state,
                Client_ip,
                erlang:element(2, Handler),
                Subject,
                erlang:element(6, Handler),
                Initial_state},
            _pipe@15 = gleam@otp@actor:initialised(_pipe@14),
            _pipe@16 = gleam@otp@actor:selecting(_pipe@15, Selector@1),
            _pipe@17 = gleam@otp@actor:returning(_pipe@16, Subject),
            {ok, _pipe@17}
        end
    ),
    _pipe@19 = gleam@otp@actor:on_message(
        _pipe@18,
        fun(State, Msg) ->
            Connection@1 = {connection,
                erlang:element(2, State),
                erlang:element(3, State),
                erlang:element(5, State),
                erlang:element(4, State)},
            case Msg of
                {internal, tcp_closed} ->
                    case glisten@transport:close(
                        erlang:element(5, State),
                        erlang:element(3, State)
                    ) of
                        {ok, nil} ->
                            _ = case erlang:element(5, Handler) of
                                {some, On_close} ->
                                    On_close(erlang:element(6, State));

                                _ ->
                                    nil
                            end,
                            gleam@otp@actor:stop();

                        {error, Err} ->
                            gleam@otp@actor:stop_abnormal(
                                gleam@string:inspect(Err)
                            )
                    end;

                {internal, ssl_closed} ->
                    case glisten@transport:close(
                        erlang:element(5, State),
                        erlang:element(3, State)
                    ) of
                        {ok, nil} ->
                            _ = case erlang:element(5, Handler) of
                                {some, On_close} ->
                                    On_close(erlang:element(6, State));

                                _ ->
                                    nil
                            end,
                            gleam@otp@actor:stop();

                        {error, Err} ->
                            gleam@otp@actor:stop_abnormal(
                                gleam@string:inspect(Err)
                            )
                    end;

                {internal, close} ->
                    case glisten@transport:close(
                        erlang:element(5, State),
                        erlang:element(3, State)
                    ) of
                        {ok, nil} ->
                            _ = case erlang:element(5, Handler) of
                                {some, On_close} ->
                                    On_close(erlang:element(6, State));

                                _ ->
                                    nil
                            end,
                            gleam@otp@actor:stop();

                        {error, Err} ->
                            gleam@otp@actor:stop_abnormal(
                                gleam@string:inspect(Err)
                            )
                    end;

                {internal, ready} ->
                    case glisten@transport:handshake(
                        erlang:element(5, State),
                        erlang:element(3, State)
                    ) of
                        {error, _} ->
                            gleam@otp@actor:stop_abnormal(
                                <<"Failed to handshake socket"/utf8>>
                            );

                        {ok, _} ->
                            case glisten@transport:set_buffer_size(
                                erlang:element(5, State),
                                erlang:element(3, State)
                            ) of
                                {ok, _} ->
                                    nil;

                                {error, Err@1} ->
                                    Err@2 = <<"Failed to read `recbuf` size, using default: "/utf8,
                                        (gleam@string:inspect(Err@1))/binary>>,
                                    logging:log(warning, Err@2)
                            end,
                            Options = [{active_mode, once}],
                            case glisten@transport:set_opts(
                                erlang:element(5, State),
                                erlang:element(3, State),
                                Options
                            ) of
                                {ok, _} ->
                                    gleam@otp@actor:continue(State);

                                {error, _} ->
                                    gleam@otp@actor:stop_abnormal(
                                        <<"Failed to set socket active"/utf8>>
                                    )
                            end
                    end;

                {user, Msg@1} ->
                    Msg@2 = {custom, Msg@1},
                    Res = glisten_ffi:rescue(
                        fun() ->
                            (erlang:element(3, Handler))(
                                erlang:element(6, State),
                                Msg@2,
                                Connection@1
                            )
                        end
                    ),
                    case Res of
                        {ok, {continue, Next_state, _}} ->
                            case glisten@transport:set_opts(
                                erlang:element(5, State),
                                erlang:element(3, State),
                                [{active_mode, once}]
                            ) of
                                {ok, nil} -> nil;
                                _assert_fail ->
                                    erlang:error(#{gleam_error => let_assert,
                                                message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                                file => <<?FILEPATH/utf8>>,
                                                module => <<"glisten/internal/handler"/utf8>>,
                                                function => <<"start"/utf8>>,
                                                line => 210,
                                                value => _assert_fail,
                                                start => 6051,
                                                'end' => 6204,
                                                pattern_start => 6062,
                                                pattern_end => 6069})
                            end,
                            gleam@otp@actor:continue(
                                {loop_state,
                                    erlang:element(2, State),
                                    erlang:element(3, State),
                                    erlang:element(4, State),
                                    erlang:element(5, State),
                                    Next_state}
                            );

                        {ok, normal_stop} ->
                            gleam@otp@actor:stop();

                        {ok, {abnormal_stop, Reason}} ->
                            gleam@otp@actor:stop_abnormal(Reason);

                        {error, Reason@1} ->
                            logging:log(
                                error,
                                <<"Caught error in user handler: "/utf8,
                                    (gleam@string:inspect(Reason@1))/binary>>
                            ),
                            gleam@otp@actor:continue(State)
                    end;

                {internal, {receive_message, Msg@3}} ->
                    Msg@4 = {packet, Msg@3},
                    Res@1 = glisten_ffi:rescue(
                        fun() ->
                            (erlang:element(3, Handler))(
                                erlang:element(6, State),
                                Msg@4,
                                Connection@1
                            )
                        end
                    ),
                    case Res@1 of
                        {ok, {continue, Next_state@1, _}} ->
                            case glisten@transport:set_opts(
                                erlang:element(5, State),
                                erlang:element(3, State),
                                [{active_mode, once}]
                            ) of
                                {ok, nil} -> nil;
                                _assert_fail@1 ->
                                    erlang:error(#{gleam_error => let_assert,
                                                message => <<"Pattern match failed, no pattern matched the value."/utf8>>,
                                                file => <<?FILEPATH/utf8>>,
                                                module => <<"glisten/internal/handler"/utf8>>,
                                                function => <<"start"/utf8>>,
                                                line => 232,
                                                value => _assert_fail@1,
                                                start => 6856,
                                                'end' => 7009,
                                                pattern_start => 6867,
                                                pattern_end => 6874})
                            end,
                            gleam@otp@actor:continue(
                                {loop_state,
                                    erlang:element(2, State),
                                    erlang:element(3, State),
                                    erlang:element(4, State),
                                    erlang:element(5, State),
                                    Next_state@1}
                            );

                        {ok, normal_stop} ->
                            gleam@otp@actor:stop();

                        {ok, {abnormal_stop, Reason@2}} ->
                            gleam@otp@actor:stop_abnormal(Reason@2);

                        {error, Reason@3} ->
                            logging:log(
                                error,
                                <<"Caught error in user handler: "/utf8,
                                    (gleam@string:inspect(Reason@3))/binary>>
                            ),
                            gleam@otp@actor:continue(State)
                    end
            end
        end
    ),
    gleam@otp@actor:start(_pipe@19).
