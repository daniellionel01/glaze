-module(lustre@component).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/component.gleam").
-export([on_attribute_change/2, on_property_change/2, on_context_change/2, form_associated/0, on_form_autofill/1, on_form_reset/1, on_form_restore/1, open_shadow_root/1, adopt_styles/1, delegates_focus/1, on_connect/1, on_adopt/1, on_disconnect/1, default_slot/2, named_slot/3, part/1, parts/1, exportparts/1, slot/1, set_form_value/1, clear_form_value/0, set_pseudo_state/1, remove_pseudo_state/1, prerender/4]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Lustre's component system is built on top of the Custom Elements API and\n"
    " the Shadow DOM API. This module helps you configure new components and\n"
    " interact with existing ones.\n"
    "\n"
    " While it's not required, understanding the spec and how it works will help\n"
    " you get the most out of Lustre's component system. The following resources\n"
    " are a great place to start:\n"
    "\n"
    "   - https://developer.mozilla.org/en-US/docs/Web/Web_Components\n"
    "\n"
    "   - https://css-tricks.com/web-components-demystified/\n"
    "\n"
    "   - https://github.com/web-padawan/awesome-web-components\n"
    "\n"
    " ## Examples\n"
    "\n"
    " We have a small number of examples showing how to set up and use components\n"
    " that are a great place to see some code:\n"
    "\n"
    " - [`Basic setup`](https://github.com/lustre-labs/lustre/tree/main/examples/05-components/01-basic-setup)\n"
    "\n"
    " - [`Custom attributes and events`](https://github.com/lustre-labs/lustre/tree/main/examples/05-components/02-attributes-and-events)\n"
    "\n"
    " - [`Slots`](https://github.com/lustre-labs/lustre/tree/main/examples/05-components/03-slots)\n"
    "\n"
    " This list of examples is likely to grow over time, so be sure to check back\n"
    " every now and then to see what's new!\n"
    "\n"
    " ## Getting help\n"
    "\n"
    " If you're having trouble with Lustre or not sure what the right way to do\n"
    " something is, the best place to get help is the [Gleam Discord server](https://discord.gg/Fm8Pwmy).\n"
    " You could also open an issue on the [Lustre GitHub repository](https://github.com/lustre-labs/lustre/issues).\n"
    "\n"
).

-file("src/lustre/component.gleam", 118).
?DOC(
    " Register a decoder to run whenever the named attribute changes. Attributes\n"
    " can be set in Lustre using the [`attribute`](./attribute.html#attribute)\n"
    " function, set directly on the component's HTML tag, or in JavaScript using\n"
    " the [`setAttribute`](https://developer.mozilla.org/en-US/docs/Web/API/Element/setAttribute)\n"
    " method.\n"
    "\n"
    " Attributes are always strings, but your decoder is responsible for decoding\n"
    " the string into a message that your component can understand.\n"
).
-spec on_attribute_change(binary(), fun((binary()) -> {ok, VVL} | {error, nil})) -> lustre@runtime@app:option(VVL).
on_attribute_change(Name, Decoder) ->
    {option,
        fun(Config) ->
            Attributes = [{Name, Decoder} | erlang:element(5, Config)],
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                Attributes,
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 136).
?DOC(
    " Register decoder to run whenever the given property is set on the component.\n"
    " Properties can be set in Lustre using the [`property`](./attribute.html#property)\n"
    " function or in JavaScript by setting a property directly on the component\n"
    " object.\n"
    "\n"
    " Properties can be any JavaScript object. For server components, properties\n"
    " will be any _JSON-serialisable_ value.\n"
).
-spec on_property_change(binary(), gleam@dynamic@decode:decoder(VVP)) -> lustre@runtime@app:option(VVP).
on_property_change(Name, Decoder) ->
    {option,
        fun(Config) ->
            Properties = [{Name, Decoder} | erlang:element(6, Config)],
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                Properties,
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 155).
?DOC(
    " Register a decoder to run whenever a parent component or application\n"
    " [provides](./effect.html#provide) a new context value for the given `key`.\n"
    " Contexts are a powerful feature that allow parents to inject data into\n"
    " child components without knowledge of the DOM structurre, making them great\n"
    " for advanced use-cases like design systems and flexible component hierarchies.\n"
    "\n"
    " Contexts can be any JavaScript object. For server components, contexts will\n"
    " be any _JSON-serialisable_ value.\n"
).
-spec on_context_change(binary(), gleam@dynamic@decode:decoder(VVS)) -> lustre@runtime@app:option(VVS).
on_context_change(Key, Decoder) ->
    {option,
        fun(Config) ->
            Contexts = [{Key, Decoder} | erlang:element(7, Config)],
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                Contexts,
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 173).
?DOC(
    " Mark a component as \"form-associated\". This lets your component participate\n"
    " in form submission and respond to additional form-specific events such as\n"
    " the form being reset or the browser autofilling this component's value.\n"
    "\n"
    " > **Note**: form-associated components are not supported in server components\n"
    " > for both technical and ideological reasons. If you'd like a component that\n"
    " > participates in form submission, you should use a client component!\n"
).
-spec form_associated() -> lustre@runtime@app:option(any()).
form_associated() ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                true,
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 187).
?DOC(
    " Register a callback that runs when the browser autofills this\n"
    " [form-associated](#form_associated) component's `\"value\"` attribute. The\n"
    " callback should convert the autofilled value into a message that you handle\n"
    " in your `update` function.\n"
    "\n"
    " > **Note**: server components cannot participate in form submission and configuring\n"
    " > this option will do nothing.\n"
).
-spec on_form_autofill(fun((binary()) -> VVX)) -> lustre@runtime@app:option(VVX).
on_form_autofill(Handler) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                true,
                {some, Handler},
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 199).
?DOC(
    " Set a message to be dispatched whenever a form containing this\n"
    " [form-associated](#form_associated) component is reset.\n"
    "\n"
    " > **Note**: server components cannot participate in form submission and configuring\n"
    " > this option will do nothing.\n"
).
-spec on_form_reset(VVZ) -> lustre@runtime@app:option(VVZ).
on_form_reset(Message) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                true,
                erlang:element(9, Config),
                {some, Message},
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 212).
?DOC(
    " Set a callback that runs when the browser restores this\n"
    " [form-associated](#form_associated) component's `\"value\"` attribute. This is\n"
    " often triggered when the user navigates back or forward in their history.\n"
    "\n"
    " > **Note**: server components cannot participate in form submission and configuring\n"
    " > this option will do nothing.\n"
).
-spec on_form_restore(fun((binary()) -> VWB)) -> lustre@runtime@app:option(VWB).
on_form_restore(Handler) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                true,
                erlang:element(9, Config),
                erlang:element(10, Config),
                {some, Handler},
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 226).
?DOC(
    " Configure whether a component's [Shadow Root](https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot)\n"
    " is open or closed. A closed shadow root means the elements rendered inside\n"
    " the component are not accessible from JavaScript outside the component.\n"
    "\n"
    " By default a component's shadow root is **open**. You may want to configure\n"
    " this option manually if you intend to build a component for use outside of\n"
    " Lustre.\n"
).
-spec open_shadow_root(boolean()) -> lustre@runtime@app:option(any()).
open_shadow_root(Open) ->
    {option,
        fun(Config) ->
            {config,
                Open,
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 246).
?DOC(
    " Configure whether a component should attempt to adopt stylesheets from\n"
    " its parent document. Components in Lustre use the shadow DOM to unlock native\n"
    " web component features like slots, but this means elements rendered inside a\n"
    " component are isolated from the document's styles.\n"
    "\n"
    " To get around this, Lustre can attempt to adopt all stylesheets from the\n"
    " parent document when the component is first created; meaning in many cases\n"
    " you can use the same CSS to style your components as you do the rest of your\n"
    " application.\n"
    "\n"
    " By default, this option is **enabled**. You may want to disable this option\n"
    " if you are building a component for use outside of Lustre and do not want\n"
    " document styles to interfere with your component's styling\n"
).
-spec adopt_styles(boolean()) -> lustre@runtime@app:option(any()).
adopt_styles(Adopt) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                Adopt,
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 268).
?DOC(
    " Indicates whether or not this component should delegate focus to its children.\n"
    " When set to `True`, a number of focus-related features are enabled:\n"
    "\n"
    " - Clicking on any non-interactive part of the component will automatically\n"
    "   focus the first focusable child element.\n"
    "\n"
    " - The component can receive focus through the `.focus()` method or the\n"
    "   `autofocus` attribute, and it will automatically focus the first\n"
    "   focusable child element.\n"
    "\n"
    " - The component receives the `:focus` CSS pseudo-class when any of its\n"
    "   focusable children have focus.\n"
    "\n"
    " By default this option is **disabled**. You may want to enable this option\n"
    " when creating complex interactive widgets.\n"
).
-spec delegates_focus(boolean()) -> lustre@runtime@app:option(any()).
delegates_focus(Delegates) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                Delegates,
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 293).
?DOC(
    " Set a message to be sent when a client component is connected to a document\n"
    " or a server component registers a new connection.\n"
    "\n"
    " ## Client components\n"
    "\n"
    " The provided message will be dispatched when the component is connected to a\n"
    " new document. This corresponds to the custom element `connectedCallback` and\n"
    " is a good signal to perform effects that interact with the DOM or many browser\n"
    " APIs.\n"
    "\n"
    " ## Server components\n"
    "\n"
    " The provided message will be dispatched when a new connection is registered\n"
    " by either [`server_component.register_subject`](./server_component.html#register_subject)\n"
    " or [`server_component.register_callback`](./server_component.html#register_callback).\n"
    " Importantly, repeated calls to either of these functions will **not** trigger\n"
    " the message multiple times.\n"
).
-spec on_connect(VWJ) -> lustre@runtime@app:option(VWJ).
on_connect(Message) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                {some, Message},
                erlang:element(13, Config),
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 305).
?DOC(
    " The message provided to this option will be dispatched whenever a client component\n"
    " is adopted into a new document.\n"
    "\n"
    " > **Note**: this option is only useful for components that will be built and\n"
    " > distributed outside of a typical Lustre application.\n"
).
-spec on_adopt(VWL) -> lustre@runtime@app:option(VWL).
on_adopt(Message) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                {some, Message},
                erlang:element(14, Config)}
        end}.

-file("src/lustre/component.gleam", 327).
?DOC(
    " Set a message to be sent when a client component is disconnected from a document\n"
    " or a server component deregisters a connection.\n"
    "\n"
    " ## Client components\n"
    "\n"
    " The provided message will be dispatched when the component is disconnected from\n"
    " a document, for example when the element is no longer rendered by your app's\n"
    " `view` function. This corresponds to the custom element `disconnectedCallback`\n"
    " and should be used to clean up any effects.\n"
    "\n"
    " ## Server components\n"
    "\n"
    " The provided message will be dispatched when a connection is deregistered by\n"
    " either [`server_component.deregister_subject`](./server_component.html#deregister_subject)\n"
    " or [`server_component.deregister_callback`](./server_component.html#deregister_callback).\n"
).
-spec on_disconnect(VWN) -> lustre@runtime@app:option(VWN).
on_disconnect(Message) ->
    {option,
        fun(Config) ->
            {config,
                erlang:element(2, Config),
                erlang:element(3, Config),
                erlang:element(4, Config),
                erlang:element(5, Config),
                erlang:element(6, Config),
                erlang:element(7, Config),
                erlang:element(8, Config),
                erlang:element(9, Config),
                erlang:element(10, Config),
                erlang:element(11, Config),
                erlang:element(12, Config),
                erlang:element(13, Config),
                {some, Message}}
        end}.

-file("src/lustre/component.gleam", 346).
?DOC(
    " Create a default slot for a component. Any elements rendered as children of\n"
    " the component will be placed inside the default slot unless explicitly\n"
    " redirected using the [`slot`](#slot) attribute.\n"
    "\n"
    " If no children are placed into the slot, the `fallback` elements will be\n"
    " rendered instead.\n"
    "\n"
    " To learn more about Shadow DOM and slots, see this excellent guide:\n"
    "\n"
    "   - https://javascript.info/slots-composition\n"
).
-spec default_slot(
    list(lustre@vdom@vattr:attribute(VWP)),
    list(lustre@vdom@vnode:element(VWP))
) -> lustre@vdom@vnode:element(VWP).
default_slot(Attributes, Fallback) ->
    lustre@element@html:slot(Attributes, Fallback).

-file("src/lustre/component.gleam", 364).
?DOC(
    " Create a named slot for a component. Any elements rendered as children of\n"
    " the component with a [`slot`](#slot) attribute matching the `name` will be\n"
    " rendered inside this slot.\n"
    "\n"
    " If no children are placed into the slot, the `fallback` elements will be\n"
    " rendered instead.\n"
    "\n"
    " To learn more about Shadow DOM and slots, see this excellent guide:\n"
    "\n"
    "   - https://javascript.info/slots-composition\n"
).
-spec named_slot(
    binary(),
    list(lustre@vdom@vattr:attribute(VWV)),
    list(lustre@vdom@vnode:element(VWV))
) -> lustre@vdom@vnode:element(VWV).
named_slot(Name, Attributes, Fallback) ->
    lustre@element@html:slot(
        [lustre@attribute:attribute(<<"name"/utf8>>, Name) | Attributes],
        Fallback
    ).

-file("src/lustre/component.gleam", 415).
?DOC(
    " Lustre's component system is built on top the Custom Elements API and the\n"
    " Shadow DOM API. A component's `view` function is rendered inside a shadow\n"
    " root, which means the component's HTML is isolated from the rest of the\n"
    " document.\n"
    "\n"
    " This can make it difficult to style components from CSS outside the component.\n"
    " To help with this, the `part` attribute lets you expose parts of your component\n"
    " by name to be styled by external CSS.\n"
    "\n"
    " For example, if the `view` function for a component called `\"my-component`\"\n"
    " looks like this:\n"
    "\n"
    " ```gleam\n"
    " import gleam/int\n"
    " import lustre/component\n"
    " import lustre/element/html\n"
    "\n"
    " fn view(model) {\n"
    "   html.div([], [\n"
    "     html.button([], [html.text(\"-\")]),\n"
    "     html.p([component.part(\"count\")], [html.text(int.to_string(model.count))]),\n"
    "     html.button([], [html.text(\"+\")]),\n"
    "   ])\n"
    " }\n"
    " ```\n"
    "\n"
    " Then the following CSS in the **parent** document can be used to style the\n"
    " `<p>` element:\n"
    "\n"
    " ```css\n"
    " my-component::part(count) {\n"
    "   color: red;\n"
    " }\n"
    " ```\n"
    "\n"
    " To learn more about the CSS Shadow Parts specification, see:\n"
    "\n"
    "   - https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/part\n"
    "\n"
    "   - https://developer.mozilla.org/en-US/docs/Web/CSS/::part\n"
).
-spec part(binary()) -> lustre@vdom@vattr:attribute(any()).
part(Name) ->
    lustre@attribute:attribute(<<"part"/utf8>>, Name).

-file("src/lustre/component.gleam", 444).
-spec do_parts(list({binary(), boolean()}), binary()) -> binary().
do_parts(Names, Part) ->
    case Names of
        [] ->
            Part;

        [{Name, true} | Rest] ->
            <<<<<<Part/binary, Name/binary>>/binary, " "/utf8>>/binary,
                (do_parts(Rest, Part))/binary>>;

        [{_, false} | Rest@1] ->
            do_parts(Rest@1, Part)
    end.

-file("src/lustre/component.gleam", 440).
?DOC(
    " A convenience function that makes it possible to toggle different parts on or\n"
    " off in a single call. This is useful for example when you have a menu item\n"
    " that may be active and you want to conditionally assign the `\"active\"` part:\n"
    "\n"
    " ```gleam\n"
    " import lustre/component\n"
    " import lustre/element/html\n"
    "\n"
    " fn view(item) {\n"
    "   html.li(\n"
    "     [\n"
    "       component.parts([\n"
    "         #(\"item\", True)\n"
    "         #(\"active\", item.is_active)\n"
    "       ]),\n"
    "     ],\n"
    "     [html.text(item.label)],\n"
    "   ])\n"
    " }\n"
    " ```\n"
).
-spec parts(list({binary(), boolean()})) -> lustre@vdom@vattr:attribute(any()).
parts(Names) ->
    part(do_parts(Names, <<""/utf8>>)).

-file("src/lustre/component.gleam", 509).
?DOC(
    " While the [`part`](#part) attribute can be used to expose parts of a component\n"
    " to its parent, these parts will not automatically become available to the\n"
    " _document_ when components are nested inside each other.\n"
    "\n"
    " The `exportparts` attribute lets you forward the parts of a nested component\n"
    " to the parent component so they can be styled from the parent document.\n"
    "\n"
    " Consider we have two components, `\"my-component\"` and `\"my-nested-component\"`\n"
    " with the following `view` functions:\n"
    "\n"
    " ```gleam\n"
    " import gleam/int\n"
    " import lustre/attribute.{property}\n"
    " import lustre/component\n"
    " import lustre/element.{element}\n"
    " import lustre/element/html\n"
    "\n"
    " fn my_component_view(model) {\n"
    "   html.div([], [\n"
    "     html.button([], [html.text(\"-\")]),\n"
    "     element(\n"
    "       \"my-nested-component\",\n"
    "       [\n"
    "         property(\"count\", model.count),\n"
    "         component.exportparts([\"count\"]),\n"
    "       ],\n"
    "       []\n"
    "     )\n"
    "     html.button([], [html.text(\"+\")]),\n"
    "   ])\n"
    " }\n"
    "\n"
    " fn my_nested_component_view(model) {\n"
    "   html.p([component.part(\"count\")], [html.text(int.to_string(model.count))])\n"
    " }\n"
    " ```\n"
    "\n"
    " The `<my-nested-component />` component has a part called `\"count\"` which the\n"
    " `<my-component />` then forwards to the parent document using the `\"exportparts\"`\n"
    " attribute. Now the following CSS can be used to style the `<p>` element nested\n"
    " deep inside the `<my-component />`:\n"
    "\n"
    " ```css\n"
    " my-component::part(count) {\n"
    "   color: red;\n"
    " }\n"
    " ```\n"
    "\n"
    " Notice how the styles are applied to the `<my-component />` element, not the\n"
    " `<my-nested-component />` element!\n"
    "\n"
    " To learn more about the CSS Shadow Parts specification, see:\n"
    "\n"
    "   - https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/exportparts\n"
    "\n"
    "   - https://developer.mozilla.org/en-US/docs/Web/CSS/::part\n"
).
-spec exportparts(list(binary())) -> lustre@vdom@vattr:attribute(any()).
exportparts(Names) ->
    lustre@attribute:attribute(
        <<"exportparts"/utf8>>,
        gleam@string:join(Names, <<", "/utf8>>)
    ).

-file("src/lustre/component.gleam", 522).
?DOC(
    " Associate an element with a [named slot](#named_slot) in a component. Multiple\n"
    " elements can be associated with the same slot name.\n"
    "\n"
    " To learn more about Shadow DOM and slots, see:\n"
    "\n"
    "   - https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/slot\n"
    "\n"
    "   - https://javascript.info/slots-composition\n"
).
-spec slot(binary()) -> lustre@vdom@vattr:attribute(any()).
slot(Name) ->
    lustre@attribute:attribute(<<"slot"/utf8>>, Name).

-file("src/lustre/component.gleam", 539).
-spec do_set_form_value(gleam@dynamic:dynamic_(), binary()) -> nil.
do_set_form_value(_, _) ->
    nil.

-file("src/lustre/component.gleam", 533).
?DOC(
    " Set the value of a [form-associated component](#form_associated). If the\n"
    " component is rendered inside a `<form>` element, the value will be\n"
    " automatically included in the form submission and available in the form's\n"
    " `FormData` object.\n"
).
-spec set_form_value(binary()) -> lustre@effect:effect(any()).
set_form_value(Value) ->
    lustre@effect:before_paint(
        fun(_, Root) -> do_set_form_value(Root, Value) end
    ).

-file("src/lustre/component.gleam", 553).
-spec do_clear_form_value(gleam@dynamic:dynamic_()) -> nil.
do_clear_form_value(_) ->
    nil.

-file("src/lustre/component.gleam", 547).
?DOC(
    " Clear a form value previously set with [`set_form_value`](#set_form_value).\n"
    " When the form is submitted, this component's value will not be included in\n"
    " the form data.\n"
).
-spec clear_form_value() -> lustre@effect:effect(any()).
clear_form_value() ->
    lustre@effect:before_paint(fun(_, Root) -> do_clear_form_value(Root) end).

-file("src/lustre/component.gleam", 583).
-spec do_set_pseudo_state(gleam@dynamic:dynamic_(), binary()) -> nil.
do_set_pseudo_state(_, _) ->
    nil.

-file("src/lustre/component.gleam", 577).
?DOC(
    " Set a custom state on the component. This state is not reflected in the DOM\n"
    " but can be selected in CSS using the `:state` pseudo-class. For example,\n"
    " calling `set_pseudo_state(\"checked\")` on a component called `\"my-checkbox\"`\n"
    " means the following CSS will apply:\n"
    "\n"
    " ```css\n"
    " my-checkbox:state(checked) {\n"
    "   border: solid;\n"
    " }\n"
    " ```\n"
    "\n"
    " If you are styling a component by rendering a `<style>` element _inside_ the\n"
    " component, the previous CSS would be rewritten as:\n"
    "\n"
    " ```css\n"
    " :host(:state(checked)) {\n"
    "   border: solid;\n"
    " }\n"
    " ```\n"
).
-spec set_pseudo_state(binary()) -> lustre@effect:effect(any()).
set_pseudo_state(Value) ->
    lustre@effect:before_paint(
        fun(_, Root) -> do_set_pseudo_state(Root, Value) end
    ).

-file("src/lustre/component.gleam", 595).
-spec do_remove_pseudo_state(gleam@dynamic:dynamic_(), binary()) -> nil.
do_remove_pseudo_state(_, _) ->
    nil.

-file("src/lustre/component.gleam", 589).
?DOC(" Remove a custom state set by [`set_pseudo_state`](#set_pseudo_state).\n").
-spec remove_pseudo_state(binary()) -> lustre@effect:effect(any()).
remove_pseudo_state(Value) ->
    lustre@effect:before_paint(
        fun(_, Root) -> do_remove_pseudo_state(Root, Value) end
    ).

-file("src/lustre/component.gleam", 637).
?DOC(
    " Prerender a component with a declarative shadow DOM. This is different to\n"
    " just rendering the component's tag because it also renders the component's\n"
    " internal `view`. Calling this when server-rendering a component allows components\n"
    " to benefit from hydration by providing an initial HTML structure similar to\n"
    " hydratation for client applications.\n"
    "\n"
    " If the component responds to attribute changes, the attributes passed here\n"
    " will be applied before the component is rendered.\n"
    "\n"
    " To support both prerendering and client-side rendering, component authors\n"
    " can use [`lustre.is_browser`](../lustre.html#is_browser) to detect the\n"
    " environment and prerender the component where appropriate:\n"
    "\n"
    " ```gleam\n"
    " import lustre.{type App}\n"
    " import lustre/attribute.{type Attribute}\n"
    " import lustre/component\n"
    " import lustre/element.{type Element, element}\n"
    "\n"
    " pub fn element(\n"
    "   attributes: List(Attribute(message)),\n"
    "   children: List(Element(message))\n"
    " ) -> Element(message) {\n"
    "   case lustre.is_browser() {\n"
    "     True -> element(tag, attributes, children)\n"
    "     False -> component.prerender(component(), tag, attributes, children)\n"
    "   }\n"
    " }\n"
    "\n"
    " const tag = \"my-component\"\n"
    "\n"
    " fn component() -> App(Nil, Model, Message) {\n"
    "   lustre.component(init:, update:, view:, options:)\n"
    " }\n"
    " ```\n"
).
-spec prerender(
    lustre@runtime@app:app(nil, any(), VXV),
    binary(),
    list(lustre@vdom@vattr:attribute(VXV)),
    list(lustre@vdom@vnode:element(VXV))
) -> lustre@vdom@vnode:element(VXV).
prerender(Component, Tag, Attributes, Children) ->
    {Model, _} = gleam@list:fold(
        Attributes,
        (erlang:element(3, Component))(nil),
        fun(State, Attribute) -> case Attribute of
                {attribute, _, Name, Value} ->
                    case gleam@list:key_find(
                        erlang:element(5, erlang:element(6, Component)),
                        Name
                    ) of
                        {ok, Handler} ->
                            case Handler(Value) of
                                {ok, Message} ->
                                    (erlang:element(4, Component))(
                                        erlang:element(1, State),
                                        Message
                                    );

                                {error, _} ->
                                    State
                            end;

                        {error, _} ->
                            State
                    end;

                {property, _, _, _} ->
                    State;

                {event, _, _, _, _, _, _, _, _} ->
                    State
            end end
    ),
    Shadowrootmode = lustre@attribute:shadowrootmode(
        case erlang:element(2, erlang:element(6, Component)) of
            true ->
                <<"open"/utf8>>;

            false ->
                <<"closed"/utf8>>
        end
    ),
    Shadowrootdelegatesfocus = lustre@attribute:shadowrootdelegatesfocus(
        erlang:element(4, erlang:element(6, Component))
    ),
    lustre@element:element(
        Tag,
        Attributes,
        [lustre@element@html:template(
                [Shadowrootmode, Shadowrootdelegatesfocus],
                [(erlang:element(5, Component))(Model)]
            ) |
            Children]
    ).
