-module(glaze@basecoat@dialog).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/dialog.gleam").
-export([header/2, dialog/4, dialog_with_description/5, content/2, scrollable_content/2, footer/2, close_button/1, max_width/1, max_height/1, full_width/0, responsive_width/1, close_on_backdrop/0, open_script/1, close_script/1, trigger_button/3]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Basecoat documentation: <https://basecoatui.com/components/dialog/>\n"
    "\n"
    " The [`dialog`](#dialog) helpers build native HTML dialog flows for\n"
    " confirmations, forms, and focused tasks.\n"
    "\n"
    " ## Anatomy\n"
    "\n"
    " A dialog flow usually includes a dialog container and a trigger that opens it.\n"
    "\n"
    " ## Recipe\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat/dialog\n"
    " import lustre/attribute\n"
    " import lustre/element/html\n"
    "\n"
    " fn edit_profile_dialog() {\n"
    "   dialog.dialog_with_description(\n"
    "     \"edit-profile\",\n"
    "     \"Edit profile\",\n"
    "     \"Make changes to your profile here.\",\n"
    "     [dialog.max_width(\"425px\")],\n"
    "     [\n"
    "     dialog.content([], [html.text(\"Dialog content here.\")]),\n"
    "     dialog.footer([], [\n"
    "       button.button([], [html.text(\"Save\")]),\n"
    "     ]),\n"
    "     ],\n"
    "   )\n"
    " }\n"
    " ```\n"
    "\n"
    " ## References\n"
    "\n"
    " - MDN `<dialog>`: <https://developer.mozilla.org/en-US/docs/Web/HTML/Element/dialog>\n"
    " - MDN `HTMLDialogElement`: <https://developer.mozilla.org/en-US/docs/Web/API/HTMLDialogElement>\n"
).

-file("src/glaze/basecoat/dialog.gleam", 97).
-spec header(
    list(lustre@vdom@vattr:attribute(RCL)),
    list(lustre@vdom@vnode:element(RCL))
) -> lustre@vdom@vnode:element(RCL).
header(Attrs, Children) ->
    lustre@element@html:header(Attrs, Children).

-file("src/glaze/basecoat/dialog.gleam", 43).
-spec dialog(
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RBZ)),
    list(lustre@vdom@vnode:element(RBZ))
) -> lustre@vdom@vnode:element(RBZ).
dialog(Id, Title, Attrs, Children) ->
    Title_id = <<Id/binary, "-title"/utf8>>,
    lustre@element@html:dialog(
        [lustre@attribute:class(<<"dialog"/utf8>>),
            lustre@attribute:id(Id),
            lustre@attribute:aria_labelledby(Title_id) |
            Attrs],
        [lustre@element@html:'div'(
                [],
                [header(
                        [],
                        [lustre@element@html:h2(
                                [lustre@attribute:id(Title_id)],
                                [lustre@element@html:text(Title)]
                            )]
                    ) |
                    Children]
            )]
    ).

-file("src/glaze/basecoat/dialog.gleam", 68).
-spec dialog_with_description(
    binary(),
    binary(),
    binary(),
    list(lustre@vdom@vattr:attribute(RCF)),
    list(lustre@vdom@vnode:element(RCF))
) -> lustre@vdom@vnode:element(RCF).
dialog_with_description(Id, Title, Description, Attrs, Children) ->
    Title_id = <<Id/binary, "-title"/utf8>>,
    Desc_id = <<Id/binary, "-description"/utf8>>,
    lustre@element@html:dialog(
        [lustre@attribute:class(<<"dialog"/utf8>>),
            lustre@attribute:id(Id),
            lustre@attribute:aria_labelledby(Title_id),
            lustre@attribute:aria_describedby(Desc_id) |
            Attrs],
        [lustre@element@html:'div'(
                [],
                [header(
                        [],
                        [lustre@element@html:h2(
                                [lustre@attribute:id(Title_id)],
                                [lustre@element@html:text(Title)]
                            ),
                            lustre@element@html:p(
                                [lustre@attribute:id(Desc_id)],
                                [lustre@element@html:text(Description)]
                            )]
                    ) |
                    Children]
            )]
    ).

-file("src/glaze/basecoat/dialog.gleam", 104).
-spec content(
    list(lustre@vdom@vattr:attribute(RCR)),
    list(lustre@vdom@vnode:element(RCR))
) -> lustre@vdom@vnode:element(RCR).
content(Attrs, Children) ->
    lustre@element@html:section(Attrs, Children).

-file("src/glaze/basecoat/dialog.gleam", 111).
-spec scrollable_content(
    list(lustre@vdom@vattr:attribute(RCX)),
    list(lustre@vdom@vnode:element(RCX))
) -> lustre@vdom@vnode:element(RCX).
scrollable_content(Attrs, Children) ->
    lustre@element@html:section(
        [lustre@attribute:class(<<"overflow-y-auto scrollbar"/utf8>>) | Attrs],
        Children
    ).

-file("src/glaze/basecoat/dialog.gleam", 121).
-spec footer(
    list(lustre@vdom@vattr:attribute(RDD)),
    list(lustre@vdom@vnode:element(RDD))
) -> lustre@vdom@vnode:element(RDD).
footer(Attrs, Children) ->
    lustre@element@html:footer(Attrs, Children).

-file("src/glaze/basecoat/dialog.gleam", 128).
-spec close_button(list(lustre@vdom@vattr:attribute(RDJ))) -> lustre@vdom@vnode:element(RDJ).
close_button(Attrs) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:aria_label(<<"Close dialog"/utf8>>),
            lustre@attribute:attribute(
                <<"onclick"/utf8>>,
                <<"this.closest('dialog').close()"/utf8>>
            ) |
            Attrs],
        [lustre@element@svg:svg(
                [lustre@attribute:attribute(
                        <<"xmlns"/utf8>>,
                        <<"http://www.w3.org/2000/svg"/utf8>>
                    ),
                    lustre@attribute:attribute(<<"width"/utf8>>, <<"24"/utf8>>),
                    lustre@attribute:attribute(<<"height"/utf8>>, <<"24"/utf8>>),
                    lustre@attribute:attribute(
                        <<"viewBox"/utf8>>,
                        <<"0 0 24 24"/utf8>>
                    ),
                    lustre@attribute:attribute(<<"fill"/utf8>>, <<"none"/utf8>>),
                    lustre@attribute:attribute(
                        <<"stroke"/utf8>>,
                        <<"currentColor"/utf8>>
                    ),
                    lustre@attribute:attribute(
                        <<"stroke-width"/utf8>>,
                        <<"2"/utf8>>
                    ),
                    lustre@attribute:attribute(
                        <<"stroke-linecap"/utf8>>,
                        <<"round"/utf8>>
                    ),
                    lustre@attribute:attribute(
                        <<"stroke-linejoin"/utf8>>,
                        <<"round"/utf8>>
                    )],
                [lustre@element@svg:path(
                        [lustre@attribute:attribute(
                                <<"d"/utf8>>,
                                <<"M18 6 6 18"/utf8>>
                            )]
                    ),
                    lustre@element@svg:path(
                        [lustre@attribute:attribute(
                                <<"d"/utf8>>,
                                <<"m6 6 12 12"/utf8>>
                            )]
                    )]
            )]
    ).

-file("src/glaze/basecoat/dialog.gleam", 158).
-spec max_width(binary()) -> lustre@vdom@vattr:attribute(any()).
max_width(Width) ->
    lustre@attribute:style(<<"max-width"/utf8>>, Width).

-file("src/glaze/basecoat/dialog.gleam", 162).
-spec max_height(binary()) -> lustre@vdom@vattr:attribute(any()).
max_height(Height) ->
    lustre@attribute:style(<<"max-height"/utf8>>, Height).

-file("src/glaze/basecoat/dialog.gleam", 166).
-spec full_width() -> lustre@vdom@vattr:attribute(any()).
full_width() ->
    lustre@attribute:class(<<"w-full"/utf8>>).

-file("src/glaze/basecoat/dialog.gleam", 170).
-spec responsive_width(binary()) -> lustre@vdom@vattr:attribute(any()).
responsive_width(Width) ->
    lustre@attribute:class(
        <<<<"w-full sm:max-w-["/utf8, Width/binary>>/binary, "]"/utf8>>
    ).

-file("src/glaze/basecoat/dialog.gleam", 174).
-spec close_on_backdrop() -> lustre@vdom@vattr:attribute(any()).
close_on_backdrop() ->
    lustre@attribute:attribute(
        <<"onclick"/utf8>>,
        <<"if (event.target === this) this.close()"/utf8>>
    ).

-file("src/glaze/basecoat/dialog.gleam", 178).
-spec open_script(binary()) -> binary().
open_script(Dialog_id) ->
    <<<<"document.getElementById('"/utf8, Dialog_id/binary>>/binary,
        "').showModal()"/utf8>>.

-file("src/glaze/basecoat/dialog.gleam", 182).
-spec close_script(binary()) -> binary().
close_script(Dialog_id) ->
    <<<<"document.getElementById('"/utf8, Dialog_id/binary>>/binary,
        "').close()"/utf8>>.

-file("src/glaze/basecoat/dialog.gleam", 186).
-spec trigger_button(
    binary(),
    list(lustre@vdom@vattr:attribute(RDX)),
    list(lustre@vdom@vnode:element(RDX))
) -> lustre@vdom@vnode:element(RDX).
trigger_button(Dialog_id, Attrs, Children) ->
    lustre@element@html:button(
        [lustre@attribute:type_(<<"button"/utf8>>),
            lustre@attribute:attribute(
                <<"onclick"/utf8>>,
                open_script(Dialog_id)
            ) |
            Attrs],
        Children
    ).
