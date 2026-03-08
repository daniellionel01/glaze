-module(lustre@element).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/element.gleam").
-export([element/3, namespaced/4, advanced/6, text/1, none/0, fragment/1, unsafe_raw_html/4, memo/2, ref/1, map/2, to_string/1, to_document_string/1, to_string_tree/1, to_document_string_tree/1, to_readable_string/1]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Lustre wouldn't be much use as a frontend framework if it didn't provide a\n"
    " way to create HTML elements. This module contains the basic functions\n"
    " necessary to construct and manipulate different HTML elements.\n"
    "\n"
    " It is also possible to use Lustre as a HTML templating library, without\n"
    " using its runtime or framework features.\n"
    "\n"
).

-file("src/lustre/element.gleam", 107).
?DOC(
    " A general function for constructing any kind of element. In most cases you\n"
    " will want to use the [`lustre/element/html`](./element/html.html) instead but this\n"
    " function is particularly handy when constructing custom elements, either\n"
    " from your own Lustre components or from external JavaScript libraries.\n"
    "\n"
    " > **Note**: Because Lustre is primarily used to create HTML, this function\n"
    " > special-cases the following tags which render as\n"
    " > [void elements](https://developer.mozilla.org/en-US/docs/Glossary/Void_element):\n"
    " >\n"
    " >   - area\n"
    " >   - base\n"
    " >   - br\n"
    " >   - col\n"
    " >   - embed\n"
    " >   - hr\n"
    " >   - img\n"
    " >   - input\n"
    " >   - link\n"
    " >   - meta\n"
    " >   - param\n"
    " >   - source\n"
    " >   - track\n"
    " >   - wbr\n"
    " >\n"
    " > This will only affect the output of `to_string` and `to_string_builder`!\n"
    " > If you need to render any of these tags with children, *or* you want to\n"
    " > render some other tag as self-closing or void, use [`advanced`](#advanced)\n"
    " > to construct the element instead.\n"
).
-spec element(
    binary(),
    list(lustre@vdom@vattr:attribute(RMV)),
    list(lustre@vdom@vnode:element(RMV))
) -> lustre@vdom@vnode:element(RMV).
element(Tag, Attributes, Children) ->
    lustre@vdom@vnode:element(
        <<""/utf8>>,
        <<""/utf8>>,
        Tag,
        Attributes,
        Children,
        maps:new(),
        false,
        lustre@vdom@vnode:is_void_html_element(Tag, <<""/utf8>>)
    ).

-file("src/lustre/element.gleam", 127).
?DOC(
    " A function for constructing elements in a specific XML namespace. This can\n"
    " be used to construct SVG or MathML elements, for example.\n"
).
-spec namespaced(
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RNB)),
    list(lustre@vdom@vnode:element(RNB))
) -> lustre@vdom@vnode:element(RNB).
namespaced(Namespace, Tag, Attributes, Children) ->
    lustre@vdom@vnode:element(
        <<""/utf8>>,
        Namespace,
        Tag,
        Attributes,
        Children,
        maps:new(),
        false,
        lustre@vdom@vnode:is_void_html_element(Tag, Namespace)
    ).

-file("src/lustre/element.gleam", 150).
?DOC(
    " A function for constructing elements with more control over how the element\n"
    " is rendered when converted to a string. This is necessary because some HTML,\n"
    " SVG, and MathML elements are self-closing or void elements, and Lustre needs\n"
    " to know how to render them correctly!\n"
).
-spec advanced(
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RNH)),
    list(lustre@vdom@vnode:element(RNH)),
    boolean(),
    boolean()
) -> lustre@vdom@vnode:element(RNH).
advanced(Namespace, Tag, Attributes, Children, Self_closing, Void) ->
    lustre@vdom@vnode:element(
        <<""/utf8>>,
        Namespace,
        Tag,
        Attributes,
        Children,
        maps:new(),
        Self_closing,
        Void
    ).

-file("src/lustre/element.gleam", 175).
?DOC(
    " A function for turning a Gleam string into a text node. Gleam doesn't have\n"
    " union types like some other languages you may be familiar with, like TypeScript.\n"
    " Instead, we need a way to take a `String` and turn it into an `Element` somehow:\n"
    " this function is exactly that!\n"
).
-spec text(binary()) -> lustre@vdom@vnode:element(any()).
text(Content) ->
    lustre@vdom@vnode:text(<<""/utf8>>, Content).

-file("src/lustre/element.gleam", 183).
?DOC(
    " A function for rendering nothing. This is mostly useful for conditional\n"
    " rendering, where you might want to render something only if a certain\n"
    " condition is met.\n"
).
-spec none() -> lustre@vdom@vnode:element(any()).
none() ->
    lustre@vdom@vnode:text(<<""/utf8>>, <<""/utf8>>).

-file("src/lustre/element.gleam", 192).
?DOC(
    " A function for constructing a wrapper element with no tag name. This is\n"
    " useful for wrapping a list of elements together without adding an extra\n"
    " `<div>` or other container element, or returning multiple elements in places\n"
    " where only one `Element` is expected.\n"
).
-spec fragment(list(lustre@vdom@vnode:element(RNR))) -> lustre@vdom@vnode:element(RNR).
fragment(Children) ->
    lustre@vdom@vnode:fragment(<<""/utf8>>, Children, maps:new()).

-file("src/lustre/element.gleam", 207).
?DOC(
    " A function for constructing a wrapper element with custom raw HTML as its\n"
    " content. Lustre will render the provided HTML verbatim, and will not touch\n"
    " its children except when replacing the entire inner html on changes.\n"
    "\n"
    " For HTML elements you can use an empty string for the namespace.\n"
    "\n"
    " > **Note:** The provided HTML will not be escaped automatically and may expose\n"
    " > your applications to XSS attacks! Make sure you absolutely trust the HTML you\n"
    " > pass to this function. In particular, never use this to display un-sanitised\n"
    " > user HTML!\n"
).
-spec unsafe_raw_html(
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RNV)),
    binary()
) -> lustre@vdom@vnode:element(RNV).
unsafe_raw_html(Namespace, Tag, Attributes, Inner_html) ->
    lustre@vdom@vnode:unsafe_inner_html(
        <<""/utf8>>,
        Namespace,
        Tag,
        Attributes,
        Inner_html
    ).

-file("src/lustre/element.gleam", 246).
?DOC(
    " A function for creating \"memoised\" or \"lazy\" elements. Lustre will use the\n"
    " dependencies list to skip calling the provided view function if all of the\n"
    " dependencies a _reference equal_ to their previous values.\n"
    "\n"
    " `memo` can be used to optimise performance-critical parts of your application,\n"
    " for example in cases where many instances of the same element are rendered but\n"
    " only one may change at a time, or cases where a part of your view may update\n"
    " very frequently but other parts remain largely static. When Lustre can tell\n"
    " that the dependencies haven't changed, almost all the work typically done to\n"
    " update the DOM can be skipped.\n"
    "\n"
    " In many cases `memo` will not be necessary, so think twice before considering\n"
    " its use! Lustre is designed to handle rerenders and large vdom trees efficiently,\n"
    " so in most cases the naive approach of re-rendering everything will be perfectly\n"
    " fine.\n"
    "\n"
    " > **Note**: reference equality is not the same as Gleam's normal equality.\n"
    " > Two custom types with the same values are not reference equal unless they\n"
    " > are the exact same instance in memory! Because of this, it's important to\n"
    " > avoid list literals or constructing custom types in the dependencies list.\n"
    "\n"
    " > **Note**: memoisation comes with its own trade-offs and can cause performance\n"
    " > regressions in two ways. First, every use of `memo` increases your application's\n"
    " > memory usage slightly, as Lustre needs to keep dependencies around to compare\n"
    " > them on subsequent renders. Second, if dependencies change regularly, the\n"
    " > overhead of comparing dependencies and managing memoisation may be more than\n"
    " > the naive cost of re-rendering the element each time.\n"
).
-spec memo(
    list(lustre@internals@ref:ref()),
    fun(() -> lustre@vdom@vnode:element(ROA))
) -> lustre@vdom@vnode:element(ROA).
memo(Dependencies, View) ->
    lustre@vdom@vnode:memo(<<""/utf8>>, Dependencies, View).

-file("src/lustre/element.gleam", 259).
?DOC(
    " Create a `Ref` dependency value used for [`memo`](#memo) elements.\n"
    "\n"
    " Lustre uses reference equality to compare dependencies. On JavaScript, values\n"
    " are compared using [same-value-zero](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Equality_comparisons_and_sameness#same-value-zero_equality)\n"
    " semantics. This means Lustre will treat `+0` and `-0` as equal, and any errant\n"
    " `NaN` values (which are not typically producible in Gleam code) as equal. On\n"
    " Erlang, there is no difference between reference equality and value equality,\n"
    " so all values are compared using normal equality semantics.\n"
).
-spec ref(any()) -> lustre@internals@ref:ref().
ref(Value) ->
    gleam@function:identity(Value).

-file("src/lustre/element.gleam", 272).
?DOC(
    " The `Element` type is parameterised by the type of messages it can produce\n"
    " from events. Sometimes you might end up with a fragment of HTML from another\n"
    " library or module that produces a different type of message: this function lets\n"
    " you map the messages produced from one type to another.\n"
    "\n"
    " Think of it like `list.map` or `result.map` but for HTML events!\n"
).
-spec map(lustre@vdom@vnode:element(ROE), fun((ROE) -> ROG)) -> lustre@vdom@vnode:element(ROG).
map(Element, F) ->
    lustre@vdom@vnode:map(Element, F).

-file("src/lustre/element.gleam", 284).
?DOC(
    " Convert a Lustre `Element` to a string. This is _not_ pretty-printed, so\n"
    " there are no newlines or indentation. If you need to pretty-print an element,\n"
    " reach out on the [Gleam Discord](https://discord.gg/Fm8Pwmy) or\n"
    " [open an issue](https://github.com/lustre-labs/lustre/issues/new) with your\n"
    " use case and we'll see what we can do!\n"
).
-spec to_string(lustre@vdom@vnode:element(any())) -> binary().
to_string(Element) ->
    lustre@vdom@vnode:to_string(Element).

-file("src/lustre/element.gleam", 295).
?DOC(
    " Converts an element to a string like [`to_string`](#to_string), but prepends\n"
    " a `<!doctype html>` declaration to the string. This is useful for rendering\n"
    " complete HTML documents.\n"
    "\n"
    " If the provided element is not an `html` element, it will be wrapped in both\n"
    " a `html` and `body` element.\n"
).
-spec to_document_string(lustre@vdom@vnode:element(any())) -> binary().
to_document_string(El) ->
    _pipe = lustre@vdom@vnode:to_string(case El of
            {element, _, _, _, <<"html"/utf8>>, _, _, _, _, _} ->
                El;

            {element, _, _, _, <<"head"/utf8>>, _, _, _, _, _} ->
                element(<<"html"/utf8>>, [], [El]);

            {element, _, _, _, <<"body"/utf8>>, _, _, _, _, _} ->
                element(<<"html"/utf8>>, [], [El]);

            _ ->
                element(
                    <<"html"/utf8>>,
                    [],
                    [element(<<"body"/utf8>>, [], [El])]
                )
        end),
    gleam@string:append(<<"<!doctype html>\n"/utf8>>, _pipe).

-file("src/lustre/element.gleam", 311).
?DOC(
    " Convert a Lustre `Element` to a `StringTree`. This is _not_ pretty-printed,\n"
    " so there are no newlines or indentation. If you need to pretty-print an element,\n"
    " reach out on the [Gleam Discord](https://discord.gg/Fm8Pwmy) or\n"
    " [open an issue](https://github.com/lustre-labs/lustre/issues/new) with your\n"
    " use case and we'll see what we can do!\n"
).
-spec to_string_tree(lustre@vdom@vnode:element(any())) -> gleam@string_tree:string_tree().
to_string_tree(Element) ->
    lustre@vdom@vnode:to_string_tree(Element, <<""/utf8>>).

-file("src/lustre/element.gleam", 322).
?DOC(
    " Converts an element to a `StringTree` like [`to_string_builder`](#to_string_builder),\n"
    " but prepends a `<!doctype html>` declaration. This is useful for rendering\n"
    " complete HTML documents.\n"
    "\n"
    " If the provided element is not an `html` element, it will be wrapped in both\n"
    " a `html` and `body` element.\n"
).
-spec to_document_string_tree(lustre@vdom@vnode:element(any())) -> gleam@string_tree:string_tree().
to_document_string_tree(El) ->
    _pipe = lustre@vdom@vnode:to_string_tree(case El of
            {element, _, _, _, <<"html"/utf8>>, _, _, _, _, _} ->
                El;

            {element, _, _, _, <<"head"/utf8>>, _, _, _, _, _} ->
                element(<<"html"/utf8>>, [], [El]);

            {element, _, _, _, <<"body"/utf8>>, _, _, _, _, _} ->
                element(<<"html"/utf8>>, [], [El]);

            _ ->
                element(
                    <<"html"/utf8>>,
                    [],
                    [element(<<"body"/utf8>>, [], [El])]
                )
        end, <<""/utf8>>),
    gleam@string_tree:prepend(_pipe, <<"<!doctype html>\n"/utf8>>).

-file("src/lustre/element.gleam", 359).
?DOC(
    " Converts a Lustre `Element` to a human-readable string by inserting new lines\n"
    " and indentation where appropriate. This is useful for debugging and testing,\n"
    " but for production code you should use [`to_string`](#to_string) or\n"
    " [`to_document_string`](#to_document_string) instead.\n"
    "\n"
    " 💡 This function works great with the snapshot testing library\n"
    "    [birdie](https://hexdocs.pm/birdie)!\n"
    "\n"
    " ## Using `to_string`:\n"
    "\n"
    " ```html\n"
    " <header><h1>Hello, world!</h1></header>\n"
    " ```\n"
    "\n"
    " ## Using `to_readable_string`\n"
    "\n"
    " ```html\n"
    " <header>\n"
    "   <h1>\n"
    "     Hello, world!\n"
    "   </h1>\n"
    " </header>\n"
    " ```\n"
).
-spec to_readable_string(lustre@vdom@vnode:element(any())) -> binary().
to_readable_string(El) ->
    lustre@vdom@vnode:to_snapshot(El, false).
