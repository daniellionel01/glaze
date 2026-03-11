import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/theme
import glaze/basecoat/toast
import gleam/erlang/process
import gleam/option.{None}
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import mist
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn page() {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.title([], "Basecoat x Gleam"),
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),

      html.script(
        [attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")],
        "",
      ),

      basecoat.register(basecoat.version),
      theme.style_tag(theme.default_theme()),
    ]),
    html.body([], [
      html.div([attribute.class("p-10")], [
        card.card([], [
          card.header([], [
            card.title([], [html.text("Welcome")]),
            card.description([], [html.text("Hello!")]),
          ]),
          card.content([], []),
          card.footer([], [
            button.button(
              [
                // "onclick" is a bad practice for real applications.
                // Instead, use custom elements or more explicit / isolated
                // javascript instead!
                //
                attribute.attribute(
                  "onclick",
                  toast.serialize_dispatch(toast.Config(
                    category: toast.Success,
                    title: "Lorem Ipsum!",
                    description: "This is an alert",
                    action: None,
                    cancel: None,
                  )),
                ),
              ],
              [
                html.text("Cheers!"),
              ],
            ),
          ]),
        ]),
      ]),
      toast.container([]),
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
