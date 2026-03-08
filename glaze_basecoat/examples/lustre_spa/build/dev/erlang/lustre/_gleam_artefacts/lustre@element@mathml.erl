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
    list(lustre@vdom@vattr:attribute(ODF)),
    list(lustre@vdom@vnode:element(ODF))
) -> lustre@vdom@vnode:element(ODF).
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
    list(lustre@vdom@vattr:attribute(ODL)),
    list(lustre@vdom@vnode:element(ODL))
) -> lustre@vdom@vnode:element(ODL).
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
    list(lustre@vdom@vattr:attribute(ODR)),
    list(lustre@vdom@vnode:element(ODR))
) -> lustre@vdom@vnode:element(ODR).
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
    list(lustre@vdom@vattr:attribute(ODX)),
    list(lustre@vdom@vnode:element(ODX))
) -> lustre@vdom@vnode:element(ODX).
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
    list(lustre@vdom@vattr:attribute(OED)),
    list(lustre@vdom@vnode:element(OED))
) -> lustre@vdom@vnode:element(OED).
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
    list(lustre@vdom@vattr:attribute(OEJ)),
    list(lustre@vdom@vnode:element(OEJ))
) -> lustre@vdom@vnode:element(OEJ).
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
    list(lustre@vdom@vattr:attribute(OEP)),
    list(lustre@vdom@vnode:element(OEP))
) -> lustre@vdom@vnode:element(OEP).
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
    list(lustre@vdom@vattr:attribute(OEV)),
    list(lustre@vdom@vnode:element(OEV))
) -> lustre@vdom@vnode:element(OEV).
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
    list(lustre@vdom@vattr:attribute(OFB)),
    list(lustre@vdom@vnode:element(OFB))
) -> lustre@vdom@vnode:element(OFB).
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
    list(lustre@vdom@vattr:attribute(OFH)),
    list(lustre@vdom@vnode:element(OFH))
) -> lustre@vdom@vnode:element(OFH).
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
    list(lustre@vdom@vattr:attribute(OFN)),
    list(lustre@vdom@vnode:element(OFN))
) -> lustre@vdom@vnode:element(OFN).
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
    list(lustre@vdom@vattr:attribute(OFT)),
    list(lustre@vdom@vnode:element(OFT))
) -> lustre@vdom@vnode:element(OFT).
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
    list(lustre@vdom@vattr:attribute(OFZ)),
    list(lustre@vdom@vnode:element(OFZ))
) -> lustre@vdom@vnode:element(OFZ).
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
    list(lustre@vdom@vattr:attribute(OGF)),
    list(lustre@vdom@vnode:element(OGF))
) -> lustre@vdom@vnode:element(OGF).
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
    list(lustre@vdom@vattr:attribute(OGL)),
    list(lustre@vdom@vnode:element(OGL))
) -> lustre@vdom@vnode:element(OGL).
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
    list(lustre@vdom@vattr:attribute(OGR)),
    list(lustre@vdom@vnode:element(OGR))
) -> lustre@vdom@vnode:element(OGR).
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
    list(lustre@vdom@vattr:attribute(OGX)),
    list(lustre@vdom@vnode:element(OGX))
) -> lustre@vdom@vnode:element(OGX).
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
    list(lustre@vdom@vattr:attribute(OHD)),
    list(lustre@vdom@vnode:element(OHD))
) -> lustre@vdom@vnode:element(OHD).
mfrac(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mfrac"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 173).
?DOC("\n").
-spec mn(list(lustre@vdom@vattr:attribute(OHJ)), binary()) -> lustre@vdom@vnode:element(OHJ).
mn(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mn"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 178).
?DOC("\n").
-spec mo(list(lustre@vdom@vattr:attribute(OHN)), binary()) -> lustre@vdom@vnode:element(OHN).
mo(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mo"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 183).
?DOC("\n").
-spec mi(list(lustre@vdom@vattr:attribute(OHR)), binary()) -> lustre@vdom@vnode:element(OHR).
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
    list(lustre@vdom@vattr:attribute(OHV)),
    list(lustre@vdom@vnode:element(OHV))
) -> lustre@vdom@vnode:element(OHV).
mpadded(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mpadded"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 196).
?DOC("\n").
-spec ms(list(lustre@vdom@vattr:attribute(OIB)), binary()) -> lustre@vdom@vnode:element(OIB).
ms(Attrs, Text) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"ms"/utf8>>,
        Attrs,
        [lustre@element:text(Text)]
    ).

-file("src/lustre/element/mathml.gleam", 201).
?DOC("\n").
-spec mspace(list(lustre@vdom@vattr:attribute(OIF))) -> lustre@vdom@vnode:element(OIF).
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
    list(lustre@vdom@vattr:attribute(OIJ)),
    list(lustre@vdom@vnode:element(OIJ))
) -> lustre@vdom@vnode:element(OIJ).
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
    list(lustre@vdom@vattr:attribute(OIP)),
    list(lustre@vdom@vnode:element(OIP))
) -> lustre@vdom@vnode:element(OIP).
mtd(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mtd"/utf8>>,
        Attrs,
        Children
    ).

-file("src/lustre/element/mathml.gleam", 222).
?DOC("\n").
-spec mtext(list(lustre@vdom@vattr:attribute(OIV)), binary()) -> lustre@vdom@vnode:element(OIV).
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
    list(lustre@vdom@vattr:attribute(OIZ)),
    list(lustre@vdom@vnode:element(OIZ))
) -> lustre@vdom@vnode:element(OIZ).
mtr(Attrs, Children) ->
    lustre@element:namespaced(
        <<"http://www.w3.org/1998/Math/MathML"/utf8>>,
        <<"mtr"/utf8>>,
        Attrs,
        Children
    ).
