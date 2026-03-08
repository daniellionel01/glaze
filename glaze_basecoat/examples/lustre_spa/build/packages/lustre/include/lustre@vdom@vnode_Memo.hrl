-record(memo, {
    kind :: integer(),
    key :: binary(),
    dependencies :: list(lustre@internals@ref:ref()),
    view :: fun(() -> lustre@vdom@vnode:element(any()))
}).
