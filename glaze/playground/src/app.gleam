import glaze/accordion
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
  html.div([attribute.class("p-10 space-y-8")], [
    html.div([attribute.class("space-y-2")], [
      html.div([], [html.text("Counter: " <> int.to_string(model.counter))]),
      html.div([attribute.class("space-x-2")], [
        button.outline([event.on_click(Increment)], [html.text("Increment")]),
        button.default([event.on_click(Increment)], [html.text("Increment")]),
        button.ghost([event.on_click(Increment)], [html.text("Increment")]),
        button.secondary([event.on_click(Increment)], [html.text("Increment")]),
        button.destructive([event.on_click(Increment)], [html.text("Increment")]),
      ]),
    ]),
    html.div([attribute.class("space-y-2")], [
      accordion.accordion([], [
        accordion.item([], [
          accordion.trigger([], [html.text("What are your shipping options?")]),
          accordion.content([], [
            html.text(
              "We offer standard (5-7 days), express (2-3 days), and overnight shipping. Free shipping on international orders.",
            ),
          ]),
        ]),
        accordion.item([], [
          accordion.trigger([attribute.aria_disabled(True)], [
            html.text("What is your return policy?"),
          ]),
          accordion.content([], [
            html.text(
              "Returns accepted within 30 days. Items must be unused and in original packaging. Refunds processed within 5-7 business days.",
            ),
          ]),
        ]),
        accordion.item([], [
          accordion.trigger([], [
            html.text("How can I contact customer support?"),
          ]),
          accordion.content([], [
            html.text(
              "Reach us via email, live chat, or phone. We respond within 24 hours during business days.",
            ),
          ]),
        ]),
      ]),
    ]),
  ])
}
