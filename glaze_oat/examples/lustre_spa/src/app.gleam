import glaze/oat/button
import glaze/oat/card
import glaze/oat/toast
import gleam/int
import lustre
import lustre/attribute
import lustre/effect.{type Effect}
import lustre/element.{type Element}
import lustre/element/html
import lustre/event

pub fn main() {
  let app = lustre.application(init, update, view)
  let assert Ok(_) = lustre.start(app, "#app", Nil)

  Nil
}

pub type Model {
  Model(counter: Int)
}

pub type Msg {
  Increment
  Decrement
  Alert(message: String)
}

fn init(_args) -> #(Model, Effect(a)) {
  #(Model(counter: 0), effect.none())
}

fn alert(message: String) -> Effect(Msg) {
  effect.from(fn(_) {
    toast.dispatch(message, "", toast.default_options(toast.Info))
  })
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  let Model(counter:) = model
  let model = case msg {
    Increment -> Model(counter: counter + 1)
    Decrement -> Model(counter: counter - 1)
    _ -> model
  }

  let effect = case msg {
    Alert(message) -> alert(message)
    _ -> effect.none()
  }

  #(model, effect)
}

pub fn view(model: Model) -> Element(Msg) {
  element.fragment([
    html.div([attribute.style("padding", "10px")], [
      card.card([], [
        card.header([], [html.text("Counter: " <> int.to_string(model.counter))]),
        card.content(
          [
            attribute.styles([
              #("margin", "10px 0"),
              #("display", "inline-grid"),
              #("grid-auto-flow", "column"),
              #("gap", "10px"),
            ]),
          ],
          [
            button.button([button.outline(), event.on_click(Decrement)], [
              html.text("Decrement"),
            ]),
            button.button([button.outline(), event.on_click(Increment)], [
              html.text("Increment"),
            ]),
          ],
        ),
        card.footer([], [
          button.button([event.on_click(Alert("Hi Haighley!"))], [
            html.text("Cheers!"),
          ]),
        ]),
      ]),
    ]),
  ])
}
