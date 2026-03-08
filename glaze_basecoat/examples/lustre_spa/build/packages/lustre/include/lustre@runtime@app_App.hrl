-record(app, {
    name :: gleam@option:option(gleam@erlang@process:name(lustre@runtime@server@runtime:message(any()))),
    init :: fun((any()) -> {any(), lustre@effect:effect(any())}),
    update :: fun((any(), any()) -> {any(), lustre@effect:effect(any())}),
    view :: fun((any()) -> lustre@vdom@vnode:element(any())),
    config :: lustre@runtime@app:config(any())
}).
