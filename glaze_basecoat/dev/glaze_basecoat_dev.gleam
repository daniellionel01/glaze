import glaze_basecoat
import glaze_basecoat/alert
import glaze_basecoat/avatar
import glaze_basecoat/badge
import glaze_basecoat/button
import glaze_basecoat/card
import glaze_basecoat/kbd
import glaze_basecoat/label
import glaze_basecoat/progress
import glaze_basecoat/skeleton
import glaze_basecoat/spinner
import glaze_basecoat/theme
import gleam/io
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import simplifile

/// Kitchen sink demo showing all available components.
///
pub fn page() {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], "Glaze / Basecoat UI"),
      glaze_basecoat.register(glaze_basecoat.version),
      theme.style_tag(theme.default_theme()),
      html.style(
        [],
        "
        body {
          font-family: system-ui, sans-serif;
        }
        .container {
          max-width: 1200px;
          margin: 0 auto;
          padding: 2rem;
        }
        .section {
          margin-bottom: 3rem;
        }
        .grid-2 {
          display: grid;
          grid-template-columns: repeat(2, 1fr);
          gap: 1rem;
        }
        .flex-wrap {
          display: flex;
          flex-wrap: wrap;
          gap: 0.5rem;
        }
        ",
      ),
    ]),
    html.body([], [
      html.div([attribute.class("container")], [
        // Header
        html.header([attribute.class("section")], [
          html.h1([], [html.text("Glaze Basecoat")]),
          html.p([], [
            html.text(
              "Lustre bindings for Basecoat UI - A components library built with Tailwind CSS.",
            ),
          ]),
        ]),

        // Button Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Button")]),
          html.div([attribute.class("flex-wrap")], [
            button.button([], [html.text("Primary")]),
            button.secondary([], [html.text("Secondary")]),
            button.destructive([], [html.text("Destructive")]),
            button.outline([], [html.text("Outline")]),
            button.ghost([], [html.text("Ghost")]),
            button.link_style([], [html.text("Link")]),
          ]),
          html.h3([], [html.text("Sizes")]),
          html.div([attribute.class("flex-wrap")], [
            button.button([button.small()], [html.text("Small")]),
            button.button([], [html.text("Default")]),
            button.button([button.large()], [html.text("Large")]),
          ]),
          html.h3([], [html.text("Button Group")]),
          button.group([], [
            button.outline([], [html.text("Cancel")]),
            button.button([], [html.text("Save")]),
          ]),
        ]),

        // Badge Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Badge")]),
          html.div([attribute.class("flex-wrap")], [
            badge.badge([], [html.text("Primary")]),
            badge.secondary([], [html.text("Secondary")]),
            badge.outline([], [html.text("Outline")]),
            badge.destructive([], [html.text("Destructive")]),
          ]),
        ]),

        // Card Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Card")]),
          html.div([attribute.class("grid-2")], [
            card.card([], [
              card.header([], [
                card.title([], [html.text("Card Title")]),
                card.description([], [html.text("Card description text.")]),
              ]),
              card.content([], [html.text("Card content goes here.")]),
              card.footer([], [
                button.button([button.small()], [html.text("Action")]),
              ]),
            ]),
            card.card([], [
              card.header([], [
                card.title([], [html.text("Simple Card")]),
              ]),
              card.content([], [
                html.text("This card has no footer."),
              ]),
            ]),
          ]),
        ]),

        // Alert Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Alert")]),
          alert.alert([], [
            alert.title([], [html.text("Success!")]),
            alert.description([], [html.text("Your changes have been saved.")]),
          ]),
          alert.destructive([], [
            alert.title([], [html.text("Error!")]),
            alert.description([], [
              html.text("Something went wrong. Please try again."),
            ]),
          ]),
        ]),

        // Avatar Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Avatar")]),
          html.div([attribute.class("flex-wrap")], [
            avatar.avatar([
              attribute.src("https://github.com/hunvreus.png"),
              attribute.alt("User"),
            ]),
            avatar.initials("JD", []),
            avatar.initials("AB", [avatar.large()]),
          ]),
          html.h3([], [html.text("Avatar Group")]),
          avatar.group([], [
            avatar.avatar([
              attribute.src("https://github.com/hunvreus.png"),
              attribute.alt("User 1"),
            ]),
            avatar.avatar([
              attribute.src("https://github.com/shadcn.png"),
              attribute.alt("User 2"),
            ]),
            avatar.avatar([
              attribute.src("https://github.com/adamwathan.png"),
              attribute.alt("User 3"),
            ]),
          ]),
        ]),

        // Progress Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Progress")]),
          html.p([], [html.text("25%")]),
          progress.progress([progress.value(25), progress.max(100)]),
          html.p([], [html.text("75%")]),
          progress.progress([progress.value(75), progress.max(100)]),
        ]),

        // Skeleton Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Skeleton")]),
          html.div([attribute.class("grid-2")], [
            skeleton.skeleton([attribute.class("h-4 w-full")]),
            skeleton.circle([]),
          ]),
        ]),

        // Spinner Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Spinner")]),
          html.div([attribute.class("flex-wrap")], [
            spinner.spinner([spinner.small()]),
            spinner.spinner([]),
            spinner.spinner([spinner.large()]),
          ]),
        ]),

        // Kbd Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Keyboard Shortcuts")]),
          html.p([], [
            html.text("Press "),
            kbd.shortcut(["⌘", "K"], []),
            html.text(" to open search."),
          ]),
        ]),

        // Label Section
        html.section([attribute.class("section")], [
          html.h2([], [html.text("Label")]),
          label.with_input("email", "Email", [attribute.type_("email")]),
        ]),

        // Footer
        html.footer([attribute.class("section")], [
          html.p([], [
            html.text("Built with "),
            html.a([attribute.href("https://basecoatui.com/")], [
              html.text("Basecoat UI"),
            ]),
            html.text(" and "),
            html.a([attribute.href("https://lustre.build/")], [
              html.text("Lustre"),
            ]),
          ]),
        ]),
      ]),
    ]),
  ])
}

pub fn main() {
  let html_content = element.to_string(page())
  let _ = simplifile.write("basecoat.html", html_content)
  io.println("Generated basecoat.html")
}
