import glaze_basecoat
import glaze_basecoat/accordion
import glaze_basecoat/alert
import glaze_basecoat/avatar
import glaze_basecoat/badge
import glaze_basecoat/breadcrumb
import glaze_basecoat/button
import glaze_basecoat/card
import glaze_basecoat/checkbox
import glaze_basecoat/empty
import glaze_basecoat/input
import glaze_basecoat/item
import glaze_basecoat/kbd
import glaze_basecoat/label
import glaze_basecoat/pagination
import glaze_basecoat/progress
import glaze_basecoat/radio_group
import glaze_basecoat/select
import glaze_basecoat/skeleton
import glaze_basecoat/slider
import glaze_basecoat/spinner
import glaze_basecoat/switch
import glaze_basecoat/table
import glaze_basecoat/tabs
import glaze_basecoat/textarea
import glaze_basecoat/theme
import glaze_basecoat/theme_switcher
import gleam/io
import lustre/attribute.{attribute}
import lustre/element
import lustre/element/html
import simplifile

pub fn page() {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], "Glaze / Basecoat UI"),
      html.script(
        [attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")],
        "",
      ),
      theme.tailwind_v4_bridge_style_tag(),
      glaze_basecoat.register(glaze_basecoat.version),
      theme.style_tag(theme.default_theme()),
      html.style(
        [],
        "
        body { font-family: system-ui, sans-serif; }
        .container { max-width: 1200px; margin: 0 auto; padding: 2rem; }
        .section { margin-bottom: 2rem; }
        .grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: 1rem; }
        .flex-wrap { display: flex; flex-wrap: wrap; gap: 0.5rem; align-items: center; }
        .demo-panel { border: 1px solid var(--border); border-radius: 0.5rem; padding: 1rem; background: var(--card); }
        ",
      ),
    ]),
    html.body([], [
      html.div([attribute.class("container")], [
        html.header([attribute.class("section")], [
          html.div([attribute.class("flex-wrap")], [
            html.h1([], [html.text("Glaze Basecoat")]),
            theme_switcher.button([]),
          ]),
          html.p([], [
            html.text(
              "Lustre bindings for Basecoat UI - A components library built with Tailwind CSS.",
            ),
          ]),
        ]),

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
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Badge")]),
          html.div([attribute.class("flex-wrap")], [
            badge.badge([], [html.text("Primary")]),
            badge.secondary([], [html.text("Secondary")]),
            badge.outline([], [html.text("Outline")]),
            badge.destructive([], [html.text("Destructive")]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Card")]),
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
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Alert")]),
          alert.alert([], [
            alert.title([], [html.text("Success!")]),
            alert.description([], [html.text("Your changes have been saved.")]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Avatar")]),
          html.div([attribute.class("flex-wrap")], [
            avatar.avatar([
              attribute.src("https://github.com/hunvreus.png"),
              attribute.alt("User"),
            ]),
            avatar.initials("JD", []),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Accordion")]),
          accordion.accordion([], [
            accordion.item("Is it accessible?", [], [
              html.p([], [
                html.text("Yes. It adheres to the WAI-ARIA design pattern."),
              ]),
            ]),
            accordion.item("Is it styled?", [], [
              html.p([], [html.text("Yes. It comes with default styles.")]),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Breadcrumb")]),
          breadcrumb.breadcrumb([], [
            breadcrumb.item([attribute.href("#")], [html.text("Home")]),
            breadcrumb.separator([]),
            breadcrumb.item([attribute.href("#")], [html.text("Products")]),
            breadcrumb.separator([]),
            breadcrumb.current([], [html.text("Details")]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Input")]),
          input.input([attribute.placeholder("Enter text...")]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Textarea")]),
          textarea.textarea([attribute.placeholder("Enter description...")], ""),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Checkbox")]),
          checkbox.with_label("terms", "Accept terms", []),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Switch")]),
          switch.with_label("notifications", "Enable notifications", []),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Radio Group")]),
          radio_group.group(
            "plan",
            [
              #("free", "Free", False),
              #("pro", "Pro", True),
              #("enterprise", "Enterprise", False),
            ],
            [],
          ),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Select")]),
          select.select([select.name("fruit")], [
            select.optgroup("Fruits", [
              select.option("apple", "Apple", True),
              select.option("banana", "Banana", False),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Slider")]),
          html.div([attribute.class("demo-panel")], [
            slider.slider([
              attribute("min", "0"),
              attribute("max", "100"),
              attribute("value", "50"),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Progress")]),
          html.div([attribute.class("demo-panel")], [
            html.div([attribute.class("grid gap-3")], [
              html.div([attribute.class("grid gap-1")], [
                html.small([attribute.class("text-muted-foreground")], [
                  html.text("Upload - 60%"),
                ]),
                progress.progress([
                  progress.value(60),
                  progress.max(100),
                  attribute.class("w-full"),
                ]),
              ]),
              html.div([attribute.class("grid gap-1")], [
                html.small([attribute.class("text-muted-foreground")], [
                  html.text("Indexing - 25%"),
                ]),
                progress.progress([
                  progress.value(25),
                  progress.max(100),
                  attribute.class("w-full"),
                ]),
              ]),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Skeleton")]),
          html.div([attribute.class("demo-panel grid gap-3")], [
            html.div([attribute.class("grid gap-2")], [
              skeleton.text([attribute.class("w-[60%]")]),
              skeleton.text([attribute.class("w-[90%]")]),
              skeleton.text([attribute.class("w-[75%]")]),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Spinner")]),
          html.div([attribute.class("demo-panel flex-wrap")], [
            html.div([attribute.class("grid gap-2 justify-items-center")], [
              spinner.spinner([spinner.small()]),
              html.small([], [html.text("Small")]),
            ]),
            html.div([attribute.class("grid gap-2 justify-items-center")], [
              spinner.spinner([]),
              html.small([], [html.text("Default")]),
            ]),
            html.div([attribute.class("grid gap-2 justify-items-center")], [
              spinner.spinner([spinner.large()]),
              html.small([], [html.text("Large")]),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Kbd")]),
          kbd.shortcut(["⌘", "K"], []),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Label")]),
          html.div([attribute.class("demo-panel")], [
            label.with_input("email", "Email", [
              attribute.type_("email"),
              attribute.placeholder("you@example.com"),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Pagination")]),
          pagination.pagination([], [
            pagination.prev([attribute.href("#")]),
            pagination.page(1, True, [attribute.href("#")]),
            pagination.page(2, False, [attribute.href("#")]),
            pagination.page(3, False, [attribute.href("#")]),
            pagination.next([attribute.href("#")]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Table")]),
          table.table([], [
            table.thead([], [
              table.tr([], [
                table.th([], [html.text("Name")]),
                table.th([], [html.text("Email")]),
              ]),
            ]),
            table.tbody([], [
              table.tr([], [
                table.td([], [html.text("John Doe")]),
                table.td([], [html.text("john@example.com")]),
              ]),
              table.tr([], [
                table.td([], [html.text("Jane Smith")]),
                table.td([], [html.text("jane@example.com")]),
              ]),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Tabs")]),
          tabs.tab_set(
            "demo-tabs",
            [
              #(
                "account",
                "Account",
                True,
                html.p([], [html.text("Account settings here.")]),
              ),
              #(
                "password",
                "Password",
                False,
                html.p([], [html.text("Password settings here.")]),
              ),
            ],
            [],
          ),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Empty")]),
          html.div([attribute.class("demo-panel")], [
            empty.empty([], [
              empty.title([], [html.text("No items found")]),
              empty.description([], [html.text("Try adjusting your search.")]),
            ]),
          ]),
        ]),

        html.section([attribute.class("section")], [
          html.h2([], [html.text("Item")]),
          item.item([], [
            item.content([], [
              item.title([], [html.text("Item Title")]),
              item.description([], [html.text("Item description goes here.")]),
            ]),
          ]),
        ]),

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
