import glaze/basecoat
import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/theme
import lustre
import lustre/attribute
import lustre/element
import lustre/element/html

pub fn main() {
  let app = lustre.element(view())
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub fn view() {
  element.fragment([
    basecoat.inject_elements([
      basecoat.cdn_stylesheet(basecoat.version),
      basecoat.cdn_script(basecoat.version),
      theme.style_tag(theme.default_theme()),
    ]),

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
  ])
}
