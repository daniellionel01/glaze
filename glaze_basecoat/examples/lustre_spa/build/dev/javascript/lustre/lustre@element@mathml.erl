-module(lustre@element@mathml).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/lustre/element/mathml.gleam").
-export([merror/2, mphantom/2, mprescripts/2, mrow/2, mstyle/2, semantics/2, mmultiscripts/2, mover/2, msub/2, msubsup/2, msup/2, munder/2, munderover/2, mroot/2, msqrt/2, annotation/2, annotation_xml/2, mfrac/2, mn/2, mo/2, mi/2, mpadded/2, ms/2, mspace/1, mtable/2, mtd/2, mtext/2, mtr/2]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

-file("src/lustre/element/mathml.gleam", 23).
?DOC("\n").
-spec merror(
    list(lustre@vdom@vattr:attribute(XTV)),
    list(lustre@vdom@vnode:element(XTV))
) -> lustre@vdom@vnode:element(XTV).
merror(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"merror"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 31).
?DOC("\n").
-spec mphantom(
    list(lustre@vdom@vattr:attribute(XUB)),
    list(lustre@vdom@vnode:element(XUB))
) -> lustre@vdom@vnode:element(XUB).
mphantom(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mphantom"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 39).
?DOC("\n").
-spec mprescripts(
    list(lustre@vdom@vattr:attribute(XUH)),
    list(lustre@vdom@vnode:element(XUH))
) -> lustre@vdom@vnode:element(XUH).
mprescripts(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mprescripts"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 47).
?DOC("\n").
-spec mrow(
    list(lustre@vdom@vattr:attribute(XUN)),
    list(lustre@vdom@vnode:element(XUN))
) -> lustre@vdom@vnode:element(XUN).
mrow(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mrow"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 55).
?DOC("\n").
-spec mstyle(
    list(lustre@vdom@vattr:attribute(XUT)),
    list(lustre@vdom@vnode:element(XUT))
) -> lustre@vdom@vnode:element(XUT).
mstyle(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mstyle"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 63).
?DOC("\n").
-spec semantics(
    list(lustre@vdom@vattr:attribute(XUZ)),
    list(lustre@vdom@vnode:element(XUZ))
) -> lustre@vdom@vnode:element(XUZ).
semantics(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"semantics"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 73).
?DOC("\n").
-spec mmultiscripts(
    list(lustre@vdom@vattr:attribute(XVF)),
    list(lustre@vdom@vnode:element(XVF))
) -> lustre@vdom@vnode:element(XVF).
mmultiscripts(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mmultiscripts"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 81).
?DOC("\n").
-spec mover(
    list(lustre@vdom@vattr:attribute(XVL)),
    list(lustre@vdom@vnode:element(XVL))
) -> lustre@vdom@vnode:element(XVL).
mover(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mover"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 89).
?DOC("\n").
-spec msub(
    list(lustre@vdom@vattr:attribute(XVR)),
    list(lustre@vdom@vnode:element(XVR))
) -> lustre@vdom@vnode:element(XVR).
msub(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"msub"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 97).
?DOC("\n").
-spec msubsup(
    list(lustre@vdom@vattr:attribute(XVX)),
    list(lustre@vdom@vnode:element(XVX))
) -> lustre@vdom@vnode:element(XVX).
msubsup(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"msubsup"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 105).
?DOC("\n").
-spec msup(
    list(lustre@vdom@vattr:attribute(XWD)),
    list(lustre@vdom@vnode:element(XWD))
) -> lustre@vdom@vnode:element(XWD).
msup(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"msup"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 113).
?DOC("\n").
-spec munder(
    list(lustre@vdom@vattr:attribute(XWJ)),
    list(lustre@vdom@vnode:element(XWJ))
) -> lustre@vdom@vnode:element(XWJ).
munder(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"munder"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 121).
?DOC("\n").
-spec munderover(
    list(lustre@vdom@vattr:attribute(XWP)),
    list(lustre@vdom@vnode:element(XWP))
) -> lustre@vdom@vnode:element(XWP).
munderover(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"munderover"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 131).
?DOC("\n").
-spec mroot(
    list(lustre@vdom@vattr:attribute(XWV)),
    list(lustre@vdom@vnode:element(XWV))
) -> lustre@vdom@vnode:element(XWV).
mroot(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mroot"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 139).
?DOC("\n").
-spec msqrt(
    list(lustre@vdom@vattr:attribute(XXB)),
    list(lustre@vdom@vnode:element(XXB))
) -> lustre@vdom@vnode:element(XXB).
msqrt(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"msqrt"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 149).
?DOC("\n").
-spec annotation(
    list(lustre@vdom@vattr:attribute(XXH)),
    list(lustre@vdom@vnode:element(XXH))
) -> lustre@vdom@vnode:element(XXH).
annotation(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"annotation"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 157).
?DOC("\n").
-spec annotation_xml(
    list(lustre@vdom@vattr:attribute(XXN)),
    list(lustre@vdom@vnode:element(XXN))
) -> lustre@vdom@vnode:element(XXN).
annotation_xml(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"annotation-xml"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 165).
?DOC("\n").
-spec mfrac(
    list(lustre@vdom@vattr:attribute(XXT)),
    list(lustre@vdom@vnode:element(XXT))
) -> lustre@vdom@vnode:element(XXT).
mfrac(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mfrac"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 173).
?DOC("\n").
-spec mn(list(lustre@vdom@vattr:attribute(XXZ)), binary()) -> lustre@vdom@vnode:element(XXZ).
mn(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mn"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 178).
?DOC("\n").
-spec mo(list(lustre@vdom@vattr:attribute(XYD)), binary()) -> lustre@vdom@vnode:element(XYD).
mo(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mo"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 183).
?DOC("\n").
-spec mi(list(lustre@vdom@vattr:attribute(XYH)), binary()) -> lustre@vdom@vnode:element(XYH).
mi(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mi"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 188).
?DOC("\n").
-spec mpadded(
    list(lustre@vdom@vattr:attribute(XYL)),
    list(lustre@vdom@vnode:element(XYL))
) -> lustre@vdom@vnode:element(XYL).
mpadded(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mpadded"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 196).
?DOC("\n").
-spec ms(list(lustre@vdom@vattr:attribute(XYR)), binary()) -> lustre@vdom@vnode:element(XYR).
ms(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"ms"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 201).
?DOC("\n").
-spec mspace(list(lustre@vdom@vattr:attribute(XYV))) -> lustre@vdom@vnode:element(XYV).
mspace(Attrs) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mspace"/utf8>>,
        Attrs,
        []
    ).

-file("src/lustre/element/mathml.gleam", 206).
?DOC("\n").
-spec mtable(
    list(lustre@vdom@vattr:attribute(XYZ)),
    list(lustre@vdom@vnode:element(XYZ))
) -> lustre@vdom@vnode:element(XYZ).
mtable(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mtable"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 214).
?DOC("\n").
-spec mtd(
    list(lustre@vdom@vattr:attribute(XZF)),
    list(lustre@vdom@vnode:element(XZF))
) -> lustre@vdom@vnode:element(XZF).
mtd(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mtd"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 222).
?DOC("\n").
-spec mtext(list(lustre@vdom@vattr:attribute(XZL)), binary()) -> lustre@vdom@vnode:element(XZL).
mtext(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mtext"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 227).
?DOC("\n").
-spec mtr(
    list(lustre@vdom@vattr:attribute(XZP)),
    list(lustre@vdom@vnode:element(XZP))
) -> lustre@vdom@vnode:element(XZP).
mtr(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mtr"/utf8>>,
        Attrs,
        Children
    ).
