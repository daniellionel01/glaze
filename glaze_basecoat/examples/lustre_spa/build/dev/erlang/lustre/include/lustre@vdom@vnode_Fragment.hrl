-record(fragment, {
    kind :: integer(),
    key :: binary(),
    children :: list(lustre@vdom@vnode:element(any())),
    keyed_children :: lustre@internals@mutable_map:mutable_map(binary(), lustre@vdom@vnode:element(any()))
}).
