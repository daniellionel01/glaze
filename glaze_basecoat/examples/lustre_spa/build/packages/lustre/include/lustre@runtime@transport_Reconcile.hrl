-record(reconcile, {
    kind :: integer(),
    patch :: lustre@vdom@patch:patch(any()),
    memos :: lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(any())), lustre@vdom@vnode:element(any()))
}).
