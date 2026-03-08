-record(events, {
    handlers :: lustre@internals@mutable_map:mutable_map(binary(), gleam@dynamic@decode:decoder(lustre@vdom@vattr:handler(any()))),
    children :: lustre@internals@mutable_map:mutable_map(binary(), lustre@vdom@cache:child(any()))
}).
