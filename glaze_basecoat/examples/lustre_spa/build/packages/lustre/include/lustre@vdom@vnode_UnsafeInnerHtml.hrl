-record(unsafe_inner_html, {
    kind :: integer(),
    key :: binary(),
    namespace :: binary(),
    tag :: binary(),
    attributes :: list(lustre@vdom@vattr:attribute(any())),
    inner_html :: binary()
}).
