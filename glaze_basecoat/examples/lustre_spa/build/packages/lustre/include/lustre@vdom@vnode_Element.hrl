-record(element, {
    kind :: integer(),
    key :: binary(),
    namespace :: binary(),
    tag :: binary(),
    attributes :: list(lustre@vdom@vattr:attribute(any())),
    children :: list(lustre@vdom@vnode:element(any())),
    keyed_children :: lustre@internals@mutable_map:mutable_map(binary(), lustre@vdom@vnode:element(any())),
    self_closing :: boolean(),
    void :: boolean()
}).
