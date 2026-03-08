-module(glaze@basecoat@kbd).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/kbd.gleam").
-export([kbd/2, shortcut/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/kbd/>\n"
    "\n"
    " Keyboard shortcut helpers built on `<kbd>`.\n"
    "\n"
    " Use `kbd` for individual keys and [`shortcut`](#shortcut) for small key\n"
    " sequences.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/kbd\n"
    " import lustre/element/html\n"
    "\n"
    " fn shortcut() {\n"
    "   html.p([], [\n"
    "     html.text(\"Press \"),\n"
    "     kbd.kbd([], [html.text(\"⌘\")]),\n"
    "     kbd.kbd([], [html.text(\"K\")]),\n"
    "     html.text(\" to search\"),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
).

-file("src/glaze/basecoat/kbd.gleam", 30).
-spec kbd(
    list(lustre@vdom@vattr:attribute(SDC)),
    list(lustre@vdom@vnode:element(SDC))
) -> lustre@vdom@vnode:element(SDC).
kbd(Attrs, Children) ->
    lustre@element@html:kbd(
        [lustre@attribute:class(<<"kbd"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/kbd.gleam", 37).
-spec shortcut(list(binary()), list(lustre@vdom@vattr:attribute(SDJ))) -> lustre@vdom@vnode:element(SDJ).
shortcut(Keys, Attrs) ->
    Key_elements = begin
        _pipe = Keys,
        _pipe@1 = gleam@list:map(
            _pipe,
            fun(Key) -> kbd([], [lustre@element@html:text(Key)]) end
        ),
        gleam@list:intersperse(
            _pipe@1,
            lustre@element@html:text(<<" + "/utf8>>)
        )
    end,
    lustre@element@html:span(Attrs, Key_elements).
