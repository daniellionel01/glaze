import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/theme
import gleam/erlang/process
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import mist
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub type Context {
  Context(static_directory: String)
}

pub fn page() {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.title([], "Basecoat x Gleam"),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),

      // generate before running the server:
      // > # download tailwind cli from https://github.com/tailwindlabs/tailwindcss/releases
      // > ./tailwindcss -i src/app.css -o priv/static/app.css
      //
      html.link([attribute.rel("stylesheet"), attribute.href("/static/app.css")]),

      basecoat.cdn_script(basecoat.version),
      theme.style_tag(theme.default_theme()),
    ]),
    html.body([], [
      html.div([attribute.class("p-10")], [
        card.card([], [
          card.header([], [
            card.title([], [html.text("Welcome")]),
            card.description([], [html.text("Hello!")]),
          ]),
          card.content([], [
            button.button([], [html.text("Get Started")]),
          ]),
        ]),
      ]),
    ]),
  ])
}

pub fn handle_request(req: Request, ctx: Context) -> Response {
  use _req <- middleware(req, ctx)

  page()
  |> element.to_document_string
  |> wisp.html_response(200)
}

pub fn main() -> Nil {
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)

  let ctx = Context(static_directory: static_directory())

  let assert Ok(_) =
    wisp_mist.handler(handle_request(_, ctx), secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start

  process.sleep_forever()
}

pub fn static_directory() -> String {
  let assert Ok(priv_directory) = wisp.priv_directory("app")
  priv_directory <> "/static"
}

pub fn middleware(
  req: wisp.Request,
  ctx: Context,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)

  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)
  use req <- wisp.csrf_known_header_protection(req)
  use <- wisp.serve_static(req, under: "/static", from: ctx.static_directory)

  handle_request(req)
}
