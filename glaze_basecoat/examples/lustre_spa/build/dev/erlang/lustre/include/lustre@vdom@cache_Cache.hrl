-record(cache, {
    events :: lustre@vdom@cache:events(any()),
    vdoms :: lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(any())), lustre@vdom@vnode:element(any())),
    old_vdoms :: lustre@internals@mutable_map:mutable_map(fun(() -> lustre@vdom@vnode:element(any())), lustre@vdom@vnode:element(any())),
    dispatched_paths :: list(binary()),
    next_dispatched_paths :: list(binary())
}).
