import glaze/button
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
}

fn init(_args) -> #(Model, Effect(a)) {
  #(Model(counter: 0), effect.none())
}

fn update(model: Model, msg: Msg) -> #(Model, Effect(Msg)) {
  let Model(counter:) = model
  let model = case msg {
    Increment -> Model(counter: counter + 1)
    Decrement -> Model(counter: counter - 1)
    _ -> model
  }

  #(model, effect.none())
}

pub fn view(model: Model) -> Element(Msg) {
  element.fragment([
    html.div([attribute.class("p-10 space-y-2")], [
      html.div([], [
        html.text("Counter: " <> int.to_string(model.counter)),
      ]),
      html.div([attribute.class("space-x-2")], [
        button.outline([event.on_click(Decrement)], [html.text("Decrement")]),
        button.default([event.on_click(Increment)], [html.text("Increment")]),
        button.ghost([event.on_click(Increment)], [html.text("Increment")]),
        button.secondary([event.on_click(Increment)], [html.text("Increment")]),
        button.destructive([event.on_click(Increment)], [html.text("Increment")]),
      ]),
    ]),
  ])
}
