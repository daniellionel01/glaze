import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import lustre
import lustre/attribute
import lustre/element/html

pub fn main() {
  let app = lustre.element(view())
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub fn view() {
  basecoat.append_cdn_script_to_head(basecoat.version)
  basecoat.append_cdn_stylesheet_to_head(basecoat.version)

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
  ])
}
