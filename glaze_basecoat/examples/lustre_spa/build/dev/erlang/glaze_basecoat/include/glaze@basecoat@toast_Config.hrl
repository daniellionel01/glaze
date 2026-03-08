-record(config, {
    category :: glaze@basecoat@toast:category(),
    title :: binary(),
    description :: binary(),
    action :: gleam@option:option(glaze@basecoat@toast:action()),
    cancel :: gleam@option:option(glaze@basecoat@toast:cancel())
}).
