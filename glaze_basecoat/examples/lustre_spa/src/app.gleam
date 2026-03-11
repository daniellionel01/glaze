import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/toast
import gleam/int
import gleam/option.{None}
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
    toast.dispatch(toast.Config(
      category: toast.Info,
      title: message,
      description: "",
      cancel: None,
      action: None,
    ))
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
    html.div([attribute.class("p-10")], [
      card.card([], [
        card.header([], [
          card.title([], [html.text("Welcome")]),
          card.description([], [
            html.text("Counter: " <> int.to_string(model.counter)),
          ]),
        ]),
        card.content([attribute.class("space-x-2")], [
          button.outline([event.on_click(Decrement)], [html.text("Decrement")]),
          button.outline([event.on_click(Increment)], [html.text("Increment")]),
        ]),
        card.footer([], [
          button.button([event.on_click(Alert("Hi Haighley!"))], [
            html.text("Cheers!"),
          ]),
        ]),
      ]),
    ]),

    toast.container_aligned(toast.AlignEnd, []),
  ])
}
