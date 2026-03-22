import glaze/oat
import glaze/oat/card
import glaze/oat/theme
import gleam/erlang/process
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import mist
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn page() {
  let custom_theme =
    theme.default_theme()
    |> theme.set(theme.Primary, "#166ab4")

  html.html([attribute("lang", "en")], [
    html.head([], [
      html.title([], "Basecoat x Gleam"),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),

      oat.register(oat.version),
      theme.style_tag(custom_theme),
    ]),
    html.body([], [
      html.div([attribute.style("padding", "10px")], [
        card.card([], [
          card.header([], [html.h3([], [html.text("Profile")])]),
          card.content([attribute.style("margin", "10px 0")], [
            html.p([], [html.text("Update your details.")]),
          ]),
          card.footer([], [html.button([], [html.text("Save")])]),
        ]),
      ]),
    ]),
  ])
}

pub fn handle_request(req: Request) -> Response {
  use _req <- middleware(req)

  page()
  |> element.to_document_string
  |> wisp.html_response(200)
}

pub fn main() -> Nil {
  wisp.configure_logger()

  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    wisp_mist.handler(handle_request, secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start

  process.sleep_forever()
}

pub fn middleware(
  req: wisp.Request,
  handle_request: fn(wisp.Request) -> wisp.Response,
) -> wisp.Response {
  let req = wisp.method_override(req)

  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes
  use req <- wisp.handle_head(req)
  use req <- wisp.csrf_known_header_protection(req)

  handle_request(req)
}
