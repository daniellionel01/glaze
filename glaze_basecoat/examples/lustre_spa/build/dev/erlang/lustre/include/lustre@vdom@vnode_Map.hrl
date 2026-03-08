-record(map, {
    kind :: integer(),
    key :: binary(),
    mapper :: fun((gleam@dynamic:dynamic_()) -> gleam@dynamic:dynamic_()),
    child :: lustre@vdom@vnode:element(any())
}).
