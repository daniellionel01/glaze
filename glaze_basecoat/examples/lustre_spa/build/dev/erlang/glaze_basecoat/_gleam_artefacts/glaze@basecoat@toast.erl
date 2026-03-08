-module(glaze@basecoat@toast).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/toast.gleam").
-export([toaster/1, toaster_aligned/2, toast/2, success/0, info/0, warning/0, error/0, duration/1, title/2, description/2, content/2, footer/2, action_button/2, cancel_button/2, show/1, show_simple/2, success_toast/2, error_toast/2]).
-export_type([category/0, config/0, action/0, cancel/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/toast/>\n"
    "\n"
    " Programmatic toast notifications.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " - Render a container once with [`toaster`](#toaster)\n"
    " - Trigger notifications either by rendering [`toast`](#toast) markup, or by\n"
    "   calling [`show`](#show) to build a JavaScript snippet\n"
    "\n"
    " ## Recipes\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/toast\n"
    " import lustre/element/html\n"
    "\n"
    " fn success_toast_markup() {\n"
    "   toast.toast([toast.success()], [\n"
    "     toast.title([], [html.text(\"Success\")]),\n"
    "     toast.description([], [html.text(\"Your changes have been saved.\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " ```gleam\n"
    " fn show_toast_script() {\n"
    "   toast.show(toast.Config(toast.Success, \"Success\", \"Saved!\", None, None))\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN ARIA `status` role: <https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Reference/Roles/status_role>\n"
    " - MDN `CustomEvent`: <https://developer.mozilla.org/en-US/docs/Web/API/CustomEvent>\n"
).

-type category() :: success | info | warning | error.

-type config() :: {config,
        category(),
        binary(),
        binary(),
        gleam@option:option(action()),
        gleam@option:option(cancel())}.

-type action() :: {action, binary(), gleam@option:option(binary())}.

-type cancel() :: {cancel,
        gleam@option:option(binary()),
        gleam@option:option(binary())}.

-file("src/glaze/basecoat/toast.gleam", 86).
?DOC(
    " Add the toaster container required for toast notifications.\n"
    "\n"
    " Place this at the end of your body element.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat\n"
    "\n"
    " html.body([], [\n"
    "   // Your content...\n"
    "   basecoat.toaster(),\n"
    " ])\n"
    " ```\n"
).
-spec toaster(list(lustre@vdom@vattr:attribute(TQM))) -> lustre@vdom@vnode:element(TQM).
toaster(Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(<<"toaster"/utf8>>),
            lustre@attribute:class(<<"toaster"/utf8>>) |
            Attrs],
        []
    ).

-file("src/glaze/basecoat/toast.gleam", 90).
-spec toaster_aligned(binary(), list(lustre@vdom@vattr:attribute(TQQ))) -> lustre@vdom@vnode:element(TQQ).
toaster_aligned(Align, Attrs) ->
    lustre@element@html:'div'(
        [lustre@attribute:id(<<"toaster"/utf8>>),
            lustre@attribute:class(<<"toaster"/utf8>>),
            lustre@attribute:data(<<"align"/utf8>>, Align) |
            Attrs],
        []
    ).

-file("src/glaze/basecoat/toast.gleam", 105).
-spec toast(
    list(lustre@vdom@vattr:attribute(TQU)),
    list(lustre@vdom@vnode:element(TQU))
) -> lustre@vdom@vnode:element(TQU).
toast(Attrs, Children) ->
    lustre@element@html:'div'(
        [lustre@attribute:class(<<"toast"/utf8>>),
            lustre@attribute:role(<<"status"/utf8>>),
            lustre@attribute:aria_atomic(true),
            lustre@attribute:aria_hidden(false) |
            Attrs],
        [lustre@element@html:'div'(
                [lustre@attribute:class(<<"toast-content"/utf8>>)],
                Children
            )]
    ).

-file("src/glaze/basecoat/toast.gleam", 123).
-spec success() -> lustre@vdom@vattr:attribute(any()).
success() ->
    lustre@attribute:data(<<"category"/utf8>>, <<"success"/utf8>>).

-file("src/glaze/basecoat/toast.gleam", 127).
-spec info() -> lustre@vdom@vattr:attribute(any()).
info() ->
    lustre@attribute:data(<<"category"/utf8>>, <<"info"/utf8>>).

-file("src/glaze/basecoat/toast.gleam", 131).
-spec warning() -> lustre@vdom@vattr:attribute(any()).
warning() ->
    lustre@attribute:data(<<"category"/utf8>>, <<"warning"/utf8>>).

-file("src/glaze/basecoat/toast.gleam", 135).
-spec error() -> lustre@vdom@vattr:attribute(any()).
error() ->
    lustre@attribute:data(<<"category"/utf8>>, <<"error"/utf8>>).

-file("src/glaze/basecoat/toast.gleam", 139).
-spec duration(integer()) -> lustre@vdom@vattr:attribute(any()).
duration(Ms) ->
    lustre@attribute:data(<<"duration"/utf8>>, erlang:integer_to_binary(Ms)).

-file("src/glaze/basecoat/toast.gleam", 143).
-spec title(
    list(lustre@vdom@vattr:attribute(TRK)),
    list(lustre@vdom@vnode:element(TRK))
) -> lustre@vdom@vnode:element(TRK).
title(Attrs, Children) ->
    lustre@element@html:h2(Attrs, Children).

-file("src/glaze/basecoat/toast.gleam", 150).
-spec description(
    list(lustre@vdom@vattr:attribute(TRQ)),
    list(lustre@vdom@vnode:element(TRQ))
) -> lustre@vdom@vnode:element(TRQ).
description(Attrs, Children) ->
    lustre@element@html:p(Attrs, Children).

-file("src/glaze/basecoat/toast.gleam", 157).
-spec content(
    list(lustre@vdom@vattr:attribute(TRW)),
    list(lustre@vdom@vnode:element(TRW))
) -> lustre@vdom@vnode:element(TRW).
content(Attrs, Children) ->
    lustre@element@html:section(Attrs, Children).

-file("src/glaze/basecoat/toast.gleam", 164).
-spec footer(
    list(lustre@vdom@vattr:attribute(TSC)),
    list(lustre@vdom@vnode:element(TSC))
) -> lustre@vdom@vnode:element(TSC).
footer(Attrs, Children) ->
    lustre@element@html:footer(Attrs, Children).

-file("src/glaze/basecoat/toast.gleam", 171).
-spec action_button(binary(), list(lustre@vdom@vattr:attribute(TSI))) -> lustre@vdom@vnode:element(TSI).
action_button(Label, Attrs) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:class(<<"btn"/utf8>>),
            lustre@attribute:data(<<"toast-action"/utf8>>, <<""/utf8>>) |
            Attrs],
        [lustre@element@html:text(Label)]
    ).

-file("src/glaze/basecoat/toast.gleam", 183).
-spec cancel_button(binary(), list(lustre@vdom@vattr:attribute(TSM))) -> lustre@vdom@vnode:element(TSM).
cancel_button(Label, Attrs) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:class(<<"btn-outline"/utf8>>) |
            Attrs],
        [lustre@element@html:text(Label)]
    ).

-file("src/glaze/basecoat/toast.gleam", 190).
-spec category_to_string(category()) -> binary().
category_to_string(Cat) ->
    case Cat of
        success ->
            <<"success"/utf8>>;

        info ->
            <<"info"/utf8>>;

        warning ->
            <<"warning"/utf8>>;

        error ->
            <<"error"/utf8>>
    end.

-file("src/glaze/basecoat/toast.gleam", 199).
-spec action_to_json(action()) -> binary().
action_to_json(Action) ->
    Onclick_json = case erlang:element(3, Action) of
        {some, Onclick} ->
            <<<<", \"onclick\": \""/utf8, Onclick/binary>>/binary, "\""/utf8>>;

        none ->
            <<""/utf8>>
    end,
    <<<<<<<<"{\"label\": \""/utf8, (erlang:element(2, Action))/binary>>/binary,
                "\""/utf8>>/binary,
            Onclick_json/binary>>/binary,
        "}"/utf8>>.

-file("src/glaze/basecoat/toast.gleam", 207).
-spec cancel_to_json(cancel()) -> binary().
cancel_to_json(Cancel) ->
    Label_json = case erlang:element(2, Cancel) of
        {some, Label} ->
            <<<<"\"label\": \""/utf8, Label/binary>>/binary, "\""/utf8>>;

        none ->
            <<""/utf8>>
    end,
    Onclick_json = case erlang:element(3, Cancel) of
        {some, Onclick} ->
            <<<<", \"onclick\": \""/utf8, Onclick/binary>>/binary, "\""/utf8>>;

        none ->
            <<""/utf8>>
    end,
    <<<<<<"{"/utf8, Label_json/binary>>/binary, Onclick_json/binary>>/binary,
        "}"/utf8>>.

-file("src/glaze/basecoat/toast.gleam", 219).
-spec show(config()) -> binary().
show(Config) ->
    Category_str = category_to_string(erlang:element(2, Config)),
    Action_json = case erlang:element(5, Config) of
        {some, Action} ->
            <<", \"action\": "/utf8, (action_to_json(Action))/binary>>;

        none ->
            <<""/utf8>>
    end,
    Cancel_json = case erlang:element(6, Config) of
        {some, Cancel} ->
            <<", \"cancel\": "/utf8, (cancel_to_json(Cancel))/binary>>;

        none ->
            <<""/utf8>>
    end,
    <<<<<<<<<<<<<<<<<<"document.dispatchEvent(new CustomEvent('basecoat:toast', { detail: { config: { category: '"/utf8,
                                        Category_str/binary>>/binary,
                                    "', title: '"/utf8>>/binary,
                                (erlang:element(3, Config))/binary>>/binary,
                            "', description: '"/utf8>>/binary,
                        (erlang:element(4, Config))/binary>>/binary,
                    "'"/utf8>>/binary,
                Action_json/binary>>/binary,
            Cancel_json/binary>>/binary,
        " } } }));"/utf8>>.

-file("src/glaze/basecoat/toast.gleam", 241).
-spec show_simple(category(), binary()) -> binary().
show_simple(Category, Title) ->
    show({config, Category, Title, <<""/utf8>>, none, none}).

-file("src/glaze/basecoat/toast.gleam", 245).
-spec success_toast(binary(), binary()) -> binary().
success_toast(Title, Description) ->
    show({config, success, Title, Description, none, none}).

-file("src/glaze/basecoat/toast.gleam", 249).
-spec error_toast(binary(), binary()) -> binary().
error_toast(Title, Description) ->
    show({config, error, Title, Description, none, none}).
