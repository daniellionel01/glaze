//// Generates a static HTML demo page for `glaze_basecoat`.
////
//// Running this module writes the GitHub Pages demo file directly to
//// `docs/glaze_basecoat/index.html` at the repository root:
////
//// ```sh
//// gleam dev
//// ```
////
//// A GitHub Workflow check keeps the file from going stale by regenerating the demo and
//// failing if `docs/glaze_basecoat/index.html` has changed.
////

import gleam/int
import gleam/list
import gleam/option.{None}

import glaze/basecoat
import glaze/basecoat/accordion
import glaze/basecoat/alert
import glaze/basecoat/alert_dialog
import glaze/basecoat/avatar
import glaze/basecoat/badge
import glaze/basecoat/button
import glaze/basecoat/card
import glaze/basecoat/checkbox
import glaze/basecoat/command
import glaze/basecoat/dialog
import glaze/basecoat/dropdown_menu
import glaze/basecoat/empty
import glaze/basecoat/field
import glaze/basecoat/form
import glaze/basecoat/icon
import glaze/basecoat/input
import glaze/basecoat/item
import glaze/basecoat/kbd
import glaze/basecoat/label
import glaze/basecoat/popover
import glaze/basecoat/progress
import glaze/basecoat/sidebar
import glaze/basecoat/skeleton
import glaze/basecoat/spinner
import glaze/basecoat/table
import glaze/basecoat/tabs
import glaze/basecoat/textarea
import glaze/basecoat/theme
import glaze/basecoat/theme_switcher
import glaze/basecoat/toast
import lustre/attribute.{type Attribute, attribute}
import lustre/element as lustre_element
import lustre/element/html
import simplifile

/// Generates `docs/glaze_basecoat/index.html` (GitHub Pages artifact).
///
/// This is the entry point used by `gleam dev`.
///
pub fn main() {
  let html =
    page()
    |> lustre_element.to_document_string

  let assert Ok(_) =
    simplifile.write(contents: html, to: "../docs/glaze_basecoat/index.html")
}

pub fn page() {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], "Kitchen Sink | Glaze Basecoat"),

      theme_switcher.init_script(),
      icon.register_cdn("latest"),

      html.script(
        [attribute.src("https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4")],
        "",
      ),
      theme.tailwind_v4_bridge_style_tag(),

      basecoat.register(basecoat.version),
      theme.style_tag_light_dark(theme.default_theme(), theme.dark_theme()),
    ]),
    html.body([], [
      html.main([attribute.class("p-4 md:p-6 xl:p-12")], [
        html.div([attribute.class("flex gap-x-10 justify-center")], [
          html.div([], [
            html.header([attribute.class("space-y-2 mb-8")], [
              html.h1(
                [
                  attribute.class("text-3xl font-semibold tracking-tight"),
                ],
                [html.text("Kitchen Sink")],
              ),
              html.p([attribute.class("text-muted-foreground")], [
                html.text(
                  "A collection of all the components available in Basecoat.",
                ),
              ]),
              html.div([attribute.class("flex flex-wrap items-center gap-2")], [
                theme_switcher.button([]),
                html.a(
                  [
                    attribute.href("https://github.com/daniellionel01/glaze"),
                    attribute.class("btn-icon-outline size-8"),
                    attribute.target("_blank"),
                    attribute.rel("noopener noreferrer"),
                    attribute.data("tooltip", "GitHub repository"),
                    attribute.data("side", "bottom"),
                  ],
                  [icon.github([])],
                ),
              ]),
            ]),
            html.div(
              [attribute.class("grid gap-4 flex-1")],
              kitchen_sink_sections(),
            ),
          ]),
          html.div(
            [attribute.class("hidden text-sm xl:block w-full max-w-[200px]")],
            [
              toc_nav(kitchen_sink_components()),
            ],
          ),
        ]),
      ]),
      toast.toaster([]),
    ]),
  ])
}

fn kitchen_sink_components() -> List(#(String, String, String)) {
  [
    #("Accordion", "accordion", "https://basecoatui.com/components/accordion"),
    #("Alert", "alert", "https://basecoatui.com/components/alert"),
    #(
      "Alert Dialog",
      "alert-dialog",
      "https://basecoatui.com/components/alert-dialog",
    ),
    #("Avatar", "avatar", "https://basecoatui.com/components/avatar"),
    #("Badge", "badge", "https://basecoatui.com/components/badge"),
    #(
      "Breadcrumb",
      "breadcrumb",
      "https://basecoatui.com/components/breadcrumb",
    ),
    #("Button", "button", "https://basecoatui.com/components/button"),
    #("Card", "card", "https://basecoatui.com/components/card"),
    #("Checkbox", "checkbox", "https://basecoatui.com/components/checkbox"),
    #("Command", "command", "https://basecoatui.com/components/command"),
    #("Combobox", "combobox", "https://basecoatui.com/components/combobox"),
    #("Dialog", "dialog", "https://basecoatui.com/components/dialog"),
    #(
      "Dropdown Menu",
      "dropdown-menu",
      "https://basecoatui.com/components/dropdown-menu",
    ),
    #("Empty", "empty", "https://basecoatui.com/components/empty"),
    #("Field", "field", "https://basecoatui.com/components/field"),
    #("Form", "form", "https://basecoatui.com/components/form"),
    #("Icon", "icon", "https://basecoatui.com"),
    #("Input", "input", "https://basecoatui.com/components/input"),
    #("Item", "item", "https://basecoatui.com/components/item"),
    #("Kbd", "kbd", "https://basecoatui.com/components/kbd"),
    #("Label", "label", "https://basecoatui.com/components/label"),
    #(
      "Pagination",
      "pagination",
      "https://basecoatui.com/components/pagination",
    ),
    #("Popover", "popover", "https://basecoatui.com/components/popover"),
    #("Progress", "progress", "https://basecoatui.com/components/progress"),
    #(
      "Radio Group",
      "radio-group",
      "https://basecoatui.com/components/radio-group",
    ),
    #("Select", "select", "https://basecoatui.com/components/select"),
    #("Sidebar", "sidebar", "https://basecoatui.com/components/sidebar"),
    #("Skeleton", "skeleton", "https://basecoatui.com/components/skeleton"),
    #("Slider", "slider", "https://basecoatui.com/components/slider"),
    #("Spinner", "spinner", "https://basecoatui.com/components/spinner"),
    #("Switch", "switch", "https://basecoatui.com/components/switch"),
    #("Table", "table", "https://basecoatui.com/components/table"),
    #("Tabs", "tabs", "https://basecoatui.com/components/tabs"),
    #(
      "Theme Switcher",
      "theme-switcher",
      "https://basecoatui.com/components/theme-switcher",
    ),
    #("Theme", "theme", "https://basecoatui.com/themes"),
    #("Textarea", "textarea", "https://basecoatui.com/components/textarea"),
    #("Toast", "toast", "https://basecoatui.com/components/toast"),
    #("Tooltip", "tooltip", "https://basecoatui.com/components/tooltip"),
  ]
}

fn kitchen_sink_sections() -> List(lustre_element.Element(msg)) {
  [
    section_accordion(),
    section_alert(),
    section_alert_dialog(),
    section_avatar(),
    section_badge(),
    section_breadcrumb(),
    section_button(),
    section_card(),
    section_checkbox(),
    section_command(),
    section_combobox(),
    section_dialog(),
    section_dropdown_menu(),
    section_empty(),
    section_field(),
    section_form(),
    section_icon(),
    section_input(),
    section_item(),
    section_kbd(),
    section_label(),
    section_pagination(),
    section_popover(),
    section_progress(),
    section_radio_group(),
    section_select(),
    section_sidebar(),
    section_skeleton(),
    section_slider(),
    section_spinner(),
    section_switch(),
    section_table(),
    section_tabs(),
    section_theme_switcher(),
    section_theme(),
    section_textarea(),
    section_toast(),
    section_tooltip(),
  ]
}

fn toc_nav(
  items: List(#(String, String, String)),
) -> lustre_element.Element(msg) {
  let links =
    items
    |> list.map(fn(item) {
      let #(label, id, _href) = item
      html.li([], [html.a([attribute.href("#" <> id)], [html.text(label)])])
    })

  html.nav(
    [
      attribute.class(
        "sticky top-22 space-y-2 [&_ul]:m-0 [&_ul]:list-none [&_li]:mt-0 [&_li]:pt-2 [&_a]:inline-block [&_a]:no-underline [&_a]:transition-colors [&_a]:hover:text-foreground [&_a]:text-muted-foreground",
      ),
    ],
    [
      html.h4([attribute.class("font-medium")], [html.text("On This Page")]),
      html.ul([], links),
    ],
  )
}

fn sink_section(
  id: String,
  label: String,
  href: String,
  scroll_mt_class: String,
  body: List(lustre_element.Element(msg)),
) -> lustre_element.Element(msg) {
  let doc_link =
    html.a(
      [
        attribute.href(href),
        attribute.class("text-muted-foreground hover:text-foreground"),
        attribute.data("tooltip", "See documentation"),
        attribute.data("side", "left"),
      ],
      [icon.icon("book-open", [attribute.class("size-4")])],
    )

  html.section(
    [
      attribute.id(id),
      attribute.class("w-full rounded-lg border " <> scroll_mt_class),
    ],
    [
      html.header(
        [
          attribute.class(
            "border-b px-4 py-3 flex items-center justify-between",
          ),
        ],
        [
          html.h2([attribute.class("text-sm font-medium")], [html.text(label)]),
          doc_link,
        ],
      ),
      html.div([attribute.class("p-4")], body),
    ],
  )
}

fn sink_section_simple(
  id: String,
  label: String,
  href: String,
  body: List(lustre_element.Element(msg)),
) -> lustre_element.Element(msg) {
  sink_section(id, label, href, "scroll-mt-14", body)
}

fn section_accordion() -> lustre_element.Element(msg) {
  sink_section_simple(
    "accordion",
    "Accordion",
    "https://basecoatui.com/components/accordion",
    [
      html.div([attribute.class("group grid w-full max-w-xl gap-4")], [
        accordion.accordion([], [
          accordion.item("Is it accessible?", [], [
            html.p([attribute.class("text-sm")], [
              html.text("Yes. It adheres to the WAI-ARIA design pattern."),
            ]),
          ]),
          accordion.item("Is it styled?", [], [
            html.p([attribute.class("text-sm")], [
              html.text(
                "Yes. It comes with default styles that matches the other components' aesthetic.",
              ),
            ]),
          ]),
          accordion.item("Is it animated?", [], [
            html.p([attribute.class("text-sm")], [
              html.text(
                "Yes. It's animated by default, but you can disable it if you prefer.",
              ),
            ]),
          ]),
        ]),
        accordion.accordion([], [
          accordion.item(
            "What are the key considerations when implementing a comprehensive enterprise-level authentication system?",
            [],
            [
              html.p([attribute.class("text-sm")], [
                html.text(
                  "Implementing a robust enterprise authentication system requires careful consideration of multiple factors. This includes secure password hashing and storage, multi-factor authentication (MFA) implementation, session management, OAuth2 and SSO integration, regular security audits, rate limiting to prevent brute force attacks, and maintaining detailed audit logs. Additionally, you'll need to consider scalability, performance impact, and compliance with relevant data protection regulations such as GDPR or HIPAA.",
                ),
              ]),
            ],
          ),
          accordion.item(
            "How does modern distributed system architecture handle eventual consistency and data synchronization across multiple regions?",
            [],
            [
              html.p([attribute.class("text-sm")], [
                html.text(
                  "Modern distributed systems employ various strategies to maintain data consistency across regions. This often involves using techniques like CRDT (Conflict-Free Replicated Data Types), vector clocks, and gossip protocols. Systems might implement event sourcing patterns, utilize message queues for asynchronous updates, and employ sophisticated conflict resolution strategies. Popular solutions like Amazon's DynamoDB and Google's Spanner demonstrate different approaches to solving these challenges, balancing between consistency, availability, and partition tolerance as described in the CAP theorem.",
                ),
              ]),
            ],
          ),
        ]),
        html.script(
          [],
          "(() => { const accordions = document.querySelectorAll('.accordion'); accordions.forEach(accordion => { accordion.addEventListener('click', (event) => { const summary = event.target.closest('summary'); if (!summary) return; const details = summary.closest('details'); if (!details) return; accordion.querySelectorAll('details').forEach(detailsEl => { if (detailsEl !== details) detailsEl.removeAttribute('open'); }); }); }); })();",
        ),
      ]),
    ],
  )
}

fn section_alert() -> lustre_element.Element(msg) {
  sink_section_simple(
    "alert",
    "Alert",
    "https://basecoatui.com/components/alert",
    [
      html.div([attribute.class("grid max-w-xl items-start gap-4")], [
        alert.alert([], [
          icon.icon("circle-check", []),
          alert.title([], [html.text("Success! Your changes have been saved")]),
          alert.description([], [
            html.text("This is an alert with icon, title and description."),
          ]),
        ]),
        alert.alert([], [
          icon.icon("bookmark-check", []),
          alert.description([], [
            html.text("This is an alert with icon, description and no title."),
          ]),
        ]),
        alert.alert([], [
          alert.description([], [
            html.text("This one has a description only. No title. No icon."),
          ]),
        ]),
        alert.alert([], [
          icon.icon("popcorn", []),
          alert.title([], [html.text("Let's try one with icon and title.")]),
        ]),
        alert.alert([], [
          icon.icon("shield-alert", []),
          alert.title([], [
            html.text(
              "This is a very long alert title that demonstrates how the component handles extended text content and potentially wraps across multiple lines",
            ),
          ]),
        ]),
        alert.alert([], [
          icon.icon("gift", []),
          alert.description([], [
            html.text(
              "This is a very long alert description that demonstrates how the component handles extended text content and potentially wraps across multiple lines",
            ),
          ]),
        ]),
        alert.alert([], [
          icon.icon("circle-alert", []),
          alert.title([], [
            html.text(
              "This is an extremely long alert title that spans multiple lines to demonstrate how the component handles very lengthy headings while maintaining readability and proper text wrapping behavior",
            ),
          ]),
          alert.description([], [
            html.text(
              "This is an equally long description that contains detailed information about the alert. It shows how the component can accommodate extensive content while preserving proper spacing, alignment, and readability across different screen sizes and viewport widths. This helps ensure the user experience remains consistent regardless of the content length.",
            ),
          ]),
        ]),
        alert.destructive([], [
          icon.icon("circle-alert", []),
          alert.title([], [html.text("Something went wrong!")]),
          alert.description([], [
            html.text("Your session has expired. Please log in again."),
          ]),
        ]),
        alert.destructive([], [
          icon.icon("circle-alert", []),
          alert.title([], [html.text("Something went wrong!")]),
          alert.description([], [
            html.p([], [
              html.text("Please verify your billing information and try again."),
            ]),
            html.ul([], [
              html.li([], [html.text("Check your card details")]),
              html.li([], [html.text("Ensure sufficient funds")]),
              html.li([], [html.text("Verify billing address")]),
            ]),
          ]),
        ]),
        alert.alert(
          [
            attribute.class(
              "border-amber-50 bg-amber-50 text-amber-900 dark:border-amber-950 dark:bg-amber-950 dark:text-amber-100",
            ),
          ],
          [
            icon.icon("circle-check", []),
            alert.title([], [
              html.text("Plot Twist: This Alert is Actually Amber!"),
            ]),
            alert.description([], [
              html.text("This one has custom colors for light and dark mode."),
            ]),
          ],
        ),
      ]),
    ],
  )
}

fn section_alert_dialog() -> lustre_element.Element(msg) {
  let dialog_id = "alert-dialog-demo"

  sink_section_simple(
    "alert-dialog",
    "Alert Dialog",
    "https://basecoatui.com/components/alert-dialog",
    [
      alert_dialog.trigger_button(dialog_id, [attribute.class("btn-outline")], [
        html.text("Open dialog"),
      ]),
      alert_dialog.alert_dialog_with_text(
        dialog_id,
        "Are you absolutely sure?",
        "This action cannot be undone. This will permanently delete your account and remove your data from our servers.",
        [dialog.close_on_backdrop()],
        [
          alert_dialog.footer([], [
            alert_dialog.cancel([], [html.text("Cancel")]),
            html.button(
              [
                attribute.type_("button"),
                attribute.class("btn"),
                attribute("onclick", alert_dialog.close_script(dialog_id)),
              ],
              [html.text("Continue")],
            ),
          ]),
        ],
      ),
    ],
  )
}

fn section_avatar() -> lustre_element.Element(msg) {
  sink_section_simple(
    "avatar",
    "Avatar",
    "https://basecoatui.com/components/avatar",
    [
      html.div([attribute.class("flex flex-row flex-wrap items-center gap-4")], [
        avatar.avatar([
          attribute.src("https://github.com/hunvreus.png"),
          attribute.alt("@hunvreus"),
        ]),
        avatar.initials("CN", []),
        avatar.avatar([
          avatar.large(),
          attribute.src("https://github.com/hunvreus.png"),
          attribute.alt("@hunvreus"),
        ]),
        avatar.rounded([
          attribute.src("https://github.com/hunvreus.png"),
          attribute.alt("@hunvreus"),
        ]),
        avatar.group([], [
          avatar.avatar([
            attribute.src("https://github.com/hunvreus.png"),
            attribute.alt("@hunvreus"),
            attribute.class("grayscale"),
          ]),
          avatar.avatar([
            attribute.src("https://github.com/shadcn.png"),
            attribute.alt("@shadcn"),
            attribute.class("grayscale"),
          ]),
          avatar.avatar([
            attribute.src("https://github.com/adamwathan.png"),
            attribute.alt("@adamwathan"),
            attribute.class("grayscale"),
          ]),
        ]),
        avatar.group([attribute.class("[&_img]:size-12")], [
          avatar.avatar([
            attribute.src("https://github.com/hunvreus.png"),
            attribute.alt("@hunvreus"),
            attribute.class("grayscale size-12"),
          ]),
          avatar.avatar([
            attribute.src("https://github.com/shadcn.png"),
            attribute.alt("@shadcn"),
            attribute.class("grayscale size-12"),
          ]),
          avatar.avatar([
            attribute.src("https://github.com/adamwathan.png"),
            attribute.alt("@adamwathan"),
            attribute.class("grayscale size-12"),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_badge() -> lustre_element.Element(msg) {
  sink_section_simple(
    "badge",
    "Badge",
    "https://basecoatui.com/components/badge",
    [
      html.div([attribute.class("flex flex-col gap-2")], [
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            badge.badge([], [html.text("Primary")]),
            badge.secondary([], [html.text("Secondary")]),
            badge.outline([], [html.text("Outline")]),
            badge.destructive([], [html.text("Destructive")]),
            badge.outline([], [icon.check([]), html.text("Badge")]),
            badge.destructive([], [
              icon.icon("circle-alert", []),
              html.text("Alert"),
            ]),
            badge.badge([attribute.class("rounded-full min-w-5 px-1")], [
              html.text("8"),
            ]),
            badge.destructive([attribute.class("rounded-full min-w-5 px-1")], [
              html.text("99"),
            ]),
            badge.outline(
              [
                attribute.class(
                  "rounded-full min-w-5 px-1 font-mono tabular-nums",
                ),
              ],
              [html.text("20+")],
            ),
          ],
        ),
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            badge.link([attribute.href("#")], [
              html.text("Link"),
              icon.arrow_right([]),
            ]),
            badge.link_secondary([attribute.href("#")], [
              html.text("Link"),
              icon.arrow_right([]),
            ]),
            badge.link_destructive([attribute.href("#")], [
              html.text("Link"),
              icon.arrow_right([]),
            ]),
            badge.link_outline([attribute.href("#")], [
              html.text("Link"),
              icon.arrow_right([]),
            ]),
          ],
        ),
      ]),
    ],
  )
}

fn section_breadcrumb() -> lustre_element.Element(msg) {
  let dd_id = "demo-breadcrumb-menu"
  let trigger_id = dd_id <> "-trigger"
  let menu_id = dd_id <> "-menu"
  let popover_id = dd_id <> "-popover"

  sink_section_simple(
    "breadcrumb",
    "Breadcrumb",
    "https://basecoatui.com/components/breadcrumb",
    [
      html.ol(
        [
          attribute.class(
            "text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5",
          ),
        ],
        [
          html.li([attribute.class("inline-flex items-center gap-1.5")], [
            html.a(
              [
                attribute.href("#"),
                attribute.class("hover:text-foreground transition-colors"),
              ],
              [html.text("Home")],
            ),
          ]),
          html.li([], [
            icon.icon("chevron-right", [attribute.class("size-3.5")]),
          ]),
          html.li([attribute.class("inline-flex items-center gap-1.5")], [
            dropdown_menu.dropdown(dd_id, [
              dropdown_menu.trigger_with_ids(
                trigger_id,
                menu_id,
                popover_id,
                [
                  attribute.class(
                    "flex size-9 items-center justify-center h-4 w-4 hover:text-foreground cursor-pointer",
                  ),
                ],
                [icon.icon("ellipsis", [])],
              ),
              dropdown_menu.content_with_ids(
                popover_id,
                menu_id,
                trigger_id,
                [attribute.class("p-1")],
                [
                  dropdown_menu.item([], [html.text("Documentation")]),
                  dropdown_menu.item([], [html.text("Themes")]),
                  dropdown_menu.item([], [html.text("GitHub")]),
                ],
              ),
            ]),
          ]),
          html.li([], [
            icon.icon("chevron-right", [attribute.class("size-3.5")]),
          ]),
          html.li([attribute.class("inline-flex items-center gap-1.5")], [
            html.a(
              [
                attribute.href("#"),
                attribute.class("hover:text-foreground transition-colors"),
              ],
              [html.text("Components")],
            ),
          ]),
          html.li([], [
            icon.icon("chevron-right", [attribute.class("size-3.5")]),
          ]),
          html.li([attribute.class("inline-flex items-center gap-1.5")], [
            html.span([attribute.class("text-foreground font-normal")], [
              html.text("Breadcrumb"),
            ]),
          ]),
        ],
      ),
    ],
  )
}

fn section_button() -> lustre_element.Element(msg) {
  sink_section_simple(
    "button",
    "Button",
    "https://basecoatui.com/components/button",
    [
      html.div([attribute.class("flex flex-col gap-6")], [
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            button.button([], [html.text("Primary")]),
            button.outline([], [html.text("Outline")]),
            button.ghost([], [html.text("Ghost")]),
            button.destructive([], [icon.icon("send", []), html.text("Danger")]),
            button.secondary([], [html.text("Secondary")]),
            button.link_style([], [html.text("Link")]),
            button.outline([], [icon.icon("send", []), html.text("Send")]),
            button.outline([], [html.text("Learn more"), icon.arrow_right([])]),
            button.outline([button.disabled()], [
              icon.loader([]),
              html.text("Loading"),
            ]),
          ],
        ),
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            button.button([button.small()], [html.text("Primary")]),
            button.outline([button.small()], [html.text("Outline")]),
            button.ghost([button.small()], [html.text("Ghost")]),
            button.destructive([button.small()], [html.text("Danger")]),
            button.secondary([button.small()], [html.text("Secondary")]),
            button.link_style([button.small()], [html.text("Link")]),
            button.outline([button.small()], [
              icon.icon("send", []),
              html.text("Send"),
            ]),
            button.outline([button.small()], [
              html.text("Learn more"),
              icon.arrow_right([]),
            ]),
            button.outline([button.small(), button.disabled()], [
              icon.loader([]),
              html.text("Loading"),
            ]),
          ],
        ),
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            button.button([button.large()], [html.text("Primary")]),
            button.outline([button.large()], [html.text("Outline")]),
            button.ghost([button.large()], [html.text("Ghost")]),
            button.destructive([button.large()], [
              icon.icon("send", []),
              html.text("Danger"),
            ]),
            button.secondary([button.large()], [html.text("Secondary")]),
            button.link_style([button.large()], [html.text("Link")]),
            button.outline([button.large()], [
              icon.icon("send", []),
              html.text("Send"),
            ]),
            button.outline([button.large()], [
              html.text("Learn more"),
              icon.arrow_right([]),
            ]),
            button.outline([button.large(), button.disabled()], [
              icon.loader([]),
              html.text("Loading"),
            ]),
          ],
        ),
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            button.icon([attribute.class("btn-icon-primary")], [
              icon.download([]),
            ]),
            button.icon([attribute.class("btn-icon-secondary")], [
              icon.upload([]),
            ]),
            button.icon_outline([], [icon.arrow_right([])]),
            button.icon([attribute.class("btn-icon-ghost")], [
              icon.icon("ellipsis", []),
            ]),
            button.icon_destructive([], [icon.trash([])]),
            button.icon_outline([button.disabled()], [icon.loader([])]),
          ],
        ),
      ]),
    ],
  )
}

fn section_card() -> lustre_element.Element(msg) {
  sink_section_simple("card", "Card", "https://basecoatui.com/components/card", [
    html.div([attribute.class("flex flex-col items-start gap-4")], [
      card.card([attribute.class("w-full max-w-sm")], [
        card.header([], [
          html.h2([], [html.text("Login to your account")]),
          html.p([], [
            html.text("Enter your details below to login to your account"),
          ]),
        ]),
        card.content([], [
          form.form([attribute.class("grid gap-6")], [
            html.div([attribute.class("grid gap-2")], [
              html.label([attribute.for("demo-card-form-email")], [
                html.text("Email"),
              ]),
              html.input([
                attribute.type_("email"),
                attribute.id("demo-card-form-email"),
              ]),
            ]),
            html.div([attribute.class("grid gap-2")], [
              html.div([attribute.class("flex items-center gap-2")], [
                html.label([attribute.for("demo-card-form-password")], [
                  html.text("Password"),
                ]),
                html.a(
                  [
                    attribute.href("#"),
                    attribute.class(
                      "ml-auto inline-block text-sm underline-offset-4 hover:underline",
                    ),
                  ],
                  [html.text("Forgot your password?")],
                ),
              ]),
              html.input([
                attribute.type_("password"),
                attribute.id("demo-card-form-password"),
              ]),
            ]),
          ]),
        ]),
        card.footer([attribute.class("flex flex-col items-center gap-2")], [
          button.button([button.full_width()], [html.text("Login")]),
          button.outline([button.full_width()], [html.text("Login with Google")]),
          html.p([attribute.class("mt-4 text-center text-sm")], [
            html.text("Don't have an account? "),
            html.a(
              [
                attribute.href("#"),
                attribute.class("underline-offset-4 hover:underline"),
              ],
              [html.text("Sign up")],
            ),
          ]),
        ]),
      ]),
      card.card([], [
        card.header([], [
          html.h2([], [html.text("Meeting Notes")]),
          html.p([], [html.text("Transcript from the meeting with the client.")]),
        ]),
        card.content([attribute.class("text-sm")], [
          html.p([], [
            html.text(
              "Client requested dashboard redesign with focus on mobile responsiveness.",
            ),
          ]),
          html.ol(
            [attribute.class("mt-4 flex list-decimal flex-col gap-2 pl-6")],
            [
              html.li([], [
                html.text("New analytics widgets for daily/weekly metrics"),
              ]),
              html.li([], [html.text("Simplified navigation menu")]),
              html.li([], [html.text("Dark mode support")]),
              html.li([], [html.text("Timeline: 6 weeks")]),
              html.li([], [
                html.text("Follow-up meeting scheduled for next Tuesday"),
              ]),
            ],
          ),
        ]),
        card.footer([], [
          avatar.group([attribute.class("[&_img]:grayscale")], [
            avatar.avatar([
              attribute.src("https://github.com/hunvreus.png"),
              attribute.alt("@hunvreus"),
            ]),
            avatar.avatar([
              attribute.src("https://github.com/shadcn.png"),
              attribute.alt("@shadcn"),
            ]),
            avatar.avatar([
              attribute.src("https://github.com/adamwathan.png"),
              attribute.alt("@adamwathan"),
            ]),
          ]),
        ]),
      ]),
      card.card([], [
        card.header([], [
          html.h2([], [html.text("Is this an image?")]),
          html.p([], [html.text("This is a card with an image.")]),
        ]),
        card.content([card.no_padding()], [
          html.img([
            attribute.alt("Photo by Drew Beamer"),
            attribute.loading("lazy"),
            attribute("width", "500"),
            attribute("height", "500"),
            attribute.class("aspect-video object-cover"),
            attribute.src(
              "https://images.unsplash.com/photo-1588345921523-c2dcdb7f1dcd?w=800&dpr=2&q=80&w=1080&q=75",
            ),
          ]),
        ]),
        card.footer([attribute.class("flex items-center gap-2")], [
          badge.outline([], [icon.icon("bed", []), html.text("1")]),
          badge.outline([], [icon.icon("bath", []), html.text("2")]),
          badge.outline([], [icon.icon("land-plot", []), html.text("350m2")]),
          html.span([attribute.class("ml-auto font-medium tabular-nums")], [
            html.text("$135,000"),
          ]),
        ]),
      ]),
      html.div(
        [
          attribute.class(
            "flex w-full flex-wrap items-start gap-8 md:*:[.card]:basis-1/4",
          ),
        ],
        [
          card.card([], [
            card.content([], [html.text("Content Only")]),
          ]),
          card.card([], [
            card.header([], [
              html.h2([], [html.text("Header Only")]),
              html.p([], [
                html.text("This is a card with a header and a description."),
              ]),
            ]),
          ]),
          card.card([], [
            card.header([], [
              html.h2([], [html.text("Header and Content")]),
              html.p([], [
                html.text("This is a card with a header and a content."),
              ]),
            ]),
            card.content([], [html.text("Content only.")]),
          ]),
          card.card([], [
            card.footer([], [html.text("Footer Only")]),
          ]),
          card.card([], [
            card.header([], [
              html.h2([], [html.text("Header + Footer")]),
              html.p([], [
                html.text("This is a card with a header and a footer."),
              ]),
            ]),
            card.footer([], [html.text("Footer")]),
          ]),
          card.card([], [
            card.content([], [html.text("Content")]),
            card.footer([], [html.text("Footer")]),
          ]),
          card.card([], [
            card.header([], [
              html.h2([], [html.text("Header + Content + Footer")]),
              html.p([], [
                html.text("This is a card with a header, content and footer."),
              ]),
            ]),
            card.content([], [html.text("Content")]),
            card.footer([], [html.text("Footer")]),
          ]),
        ],
      ),
    ]),
  ])
}

fn section_checkbox() -> lustre_element.Element(msg) {
  sink_section_simple(
    "checkbox",
    "Checkbox",
    "https://basecoatui.com/components/checkbox",
    [
      html.div([attribute.class("flex flex-col gap-6 max-w-lg")], [
        checkbox.with_label(
          "demo-checkbox-1",
          "Accept terms and conditions",
          [],
        ),
        checkbox.with_description(
          "demo-checkbox-label-and-description",
          "Accept terms and conditions",
          "By clicking this checkbox, you agree to the terms and conditions.",
          [],
        ),
        checkbox.with_label("demo-checkbox-disabled", "Enable notifications", [
          checkbox.disabled(),
        ]),
        html.label(
          [
            attribute.class(
              "flex items-start gap-3 border p-3 hover:bg-accent/50 rounded-lg has-[input[type='checkbox']:checked]:border-blue-600 has-[input[type='checkbox']:checked]:bg-blue-50 dark:has-[input[type='checkbox']:checked]:border-blue-900 dark:has-[input[type='checkbox']:checked]:bg-blue-950",
            ),
          ],
          [
            html.input([
              attribute.type_("checkbox"),
              attribute.class(
                "input checked:bg-blue-600 checked:border-blue-600 dark:checked:bg-blue-700 dark:checked:border-blue-700 checked:after:bg-white",
              ),
              attribute.checked(True),
            ]),
            html.div([attribute.class("grid gap-2")], [
              html.h2([attribute.class("text-sm leading-none font-medium")], [
                html.text("Enable notifications"),
              ]),
              html.p([attribute.class("text-muted-foreground text-sm")], [
                html.text(
                  "You can enable or disable notifications at any time.",
                ),
              ]),
            ]),
          ],
        ),
      ]),
    ],
  )
}

fn section_command() -> lustre_element.Element(msg) {
  let cmd_id = "demo-command"
  let search_id = cmd_id <> "-search"
  let menu_id = cmd_id <> "-menu"

  let dialog_id = "demo-command-dialog"
  let dialog_cmd_id = "demo-command-dialog-cmd"
  let dialog_search_id = dialog_cmd_id <> "-search"
  let dialog_menu_id = dialog_cmd_id <> "-menu"

  sink_section_simple(
    "command",
    "Command",
    "https://basecoatui.com/components/command",
    [
      html.div([attribute.class("grid gap-6")], [
        command.command_styled(cmd_id, [attribute.class("max-w-xl")], [
          command.header([], [
            icon.search([attribute.class("size-4")]),
            command.search_input(
              search_id,
              "Type a command or search...",
              menu_id,
              [],
            ),
          ]),
          command.menu_with_empty(
            menu_id,
            "No results found.",
            [attribute.class("max-h-64 overflow-y-auto")],
            [
              command.group("Suggestions", [
                command.item_with_shortcut("↵", [], [
                  icon.calendar([]),
                  html.text("Calendar"),
                ]),
                command.item_with_shortcut("⌘K", [], [
                  icon.search([]),
                  html.text("Search"),
                ]),
                command.item_with_shortcut("⌘P", [], [
                  icon.settings([]),
                  html.text("Settings"),
                ]),
              ]),
              command.separator(),
              command.group("Actions", [
                command.item([], [icon.mail([]), html.text("Send email")]),
                command.item_disabled([], [
                  icon.icon("sparkles", []),
                  html.text("Generate report"),
                ]),
              ]),
            ],
          ),
        ]),
        html.div([attribute.class("flex flex-wrap items-center gap-2")], [
          html.button(
            [
              attribute.type_("button"),
              attribute.class("btn-outline"),
              attribute("onclick", command.open_script(dialog_id)),
            ],
            [html.text("Open command dialog")],
          ),
          command.dialog(dialog_id, [], [
            command.command_styled(dialog_cmd_id, [attribute.class("w-full")], [
              command.header([], [
                icon.search([attribute.class("size-4")]),
                command.search_input(
                  dialog_search_id,
                  "Search commands...",
                  dialog_menu_id,
                  [],
                ),
              ]),
              command.menu(
                dialog_menu_id,
                [attribute.class("max-h-64 overflow-y-auto")],
                [
                  command.group("Quick", [
                    command.item_with_shortcut("G", [], [
                      icon.github([]),
                      html.text("Open GitHub"),
                    ]),
                    command.item_with_shortcut("T", [], [
                      icon.icon("table", []),
                      html.text("Jump to Table"),
                    ]),
                  ]),
                ],
              ),
              html.footer([attribute.class("p-2 flex justify-end")], [
                html.button(
                  [
                    attribute.type_("button"),
                    attribute.class("btn-outline"),
                    attribute("onclick", command.close_script(dialog_id)),
                  ],
                  [html.text("Close")],
                ),
              ]),
            ]),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_empty() -> lustre_element.Element(msg) {
  sink_section_simple(
    "empty",
    "Empty",
    "https://basecoatui.com/components/empty",
    [
      html.div([attribute.class("grid gap-6")], [
        empty.empty([], [
          empty.icon([], [icon.folder([])]),
          empty.title([], [html.text("No Projects Yet")]),
          empty.description([], [
            html.text("Create your first project to get started."),
          ]),
          empty.actions([], [
            button.button([], [html.text("Create project")]),
            button.outline([], [html.text("Import")]),
          ]),
        ]),
        empty.outlined([], [
          empty.icon([], [icon.icon("inbox", [])]),
          empty.title([], [html.text("Nothing to review")]),
          empty.description([], [
            html.text("You're all caught up. Check back later."),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_field() -> lustre_element.Element(msg) {
  sink_section_simple(
    "field",
    "Field",
    "https://basecoatui.com/components/field",
    [
      html.div([attribute.class("grid gap-6 max-w-xl")], [
        field.field([], [
          field.label([attribute.for("demo-field-email")], [html.text("Email")]),
          field.description([], [html.text("We'll never share it.")]),
          input.email([
            attribute.id("demo-field-email"),
            input.placeholder("you@example.com"),
          ]),
        ]),
        field.field([], [
          field.label([attribute.for("demo-field-username")], [
            html.text("Username"),
          ]),
          input.input([
            attribute.id("demo-field-username"),
            input.placeholder("hunvreus"),
          ]),
          field.error([], [html.text("That username is already taken.")]),
        ]),
        field.with_description(
          "demo-field-bio",
          "Bio",
          "Write a short bio.",
          textarea.textarea(
            [
              textarea.id("demo-field-bio"),
              textarea.placeholder("I like to..."),
            ],
            "",
          ),
          [],
        ),
      ]),
    ],
  )
}

fn section_icon() -> lustre_element.Element(msg) {
  let icons = [
    #("Search", "search"),
    #("Settings", "settings"),
    #("Plus", "plus"),
    #("Mail", "mail"),
    #("Calendar", "calendar"),
    #("GitHub", "github"),
    #("Alert", "circle-alert"),
    #("Check", "check"),
    #("X", "x"),
    #("Arrow", "arrow-right"),
    #("Star", "star"),
    #("Heart", "heart"),
  ]

  let tiles =
    icons
    |> list.map(fn(i) {
      let #(label, name) = i
      html.div(
        [attribute.class("flex items-center gap-3 rounded-md border p-3")],
        [
          icon.icon(name, [attribute.class("size-5")]),
          html.div([attribute.class("grid")], [
            html.span([attribute.class("text-sm font-medium")], [
              html.text(label),
            ]),
            html.span([attribute.class("text-muted-foreground text-xs")], [
              html.text(name),
            ]),
          ]),
        ],
      )
    })

  sink_section_simple("icon", "Icon", "https://basecoatui.com", [
    html.div([attribute.class("grid gap-4")], [
      html.p([attribute.class("text-muted-foreground text-sm")], [
        html.text("Lucide icons rendered via `glaze_basecoat/icon`."),
      ]),
      html.div(
        [
          attribute.class(
            "grid grid-cols-1 gap-3 sm:grid-cols-2 lg:grid-cols-3",
          ),
        ],
        tiles,
      ),
    ]),
  ])
}

fn section_item() -> lustre_element.Element(msg) {
  sink_section_simple("item", "Item", "https://basecoatui.com/components/item", [
    item.group([attribute.class("gap-3")], [
      item.item([], [
        item.icon([], [icon.mail([])]),
        item.content([], [
          item.title([], [html.text("Inbox")]),
          item.description([], [
            html.text("All notifications and messages in one place."),
          ]),
        ]),
        item.actions([], [
          button.icon_outline([], [icon.external_link([])]),
          button.icon_outline([], [icon.more_horizontal([])]),
        ]),
      ]),
      item.item([], [
        item.avatar("https://github.com/hunvreus.png", "@hunvreus", []),
        item.content([], [
          item.title([], [html.text("Ronan Berder")]),
          item.description([], [html.text("hunvreus@example.com")]),
        ]),
        item.actions([], [
          button.outline([], [html.text("Invite")]),
        ]),
      ]),
      item.item_link("#", [], [
        item.image(
          "https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=200&dpr=2&q=80",
          "Photo",
          [],
        ),
        item.content([], [
          item.title([], [html.text("Design system")]),
          item.description([], [
            html.text("A link item with an image and a trailing action."),
          ]),
        ]),
        item.actions([], [button.icon_outline([], [icon.arrow_right([])])]),
      ]),
    ]),
  ])
}

fn section_kbd() -> lustre_element.Element(msg) {
  sink_section_simple("kbd", "Kbd", "https://basecoatui.com/components/kbd", [
    html.div([attribute.class("grid gap-4")], [
      html.p([], [
        html.text("Press "),
        kbd.kbd([], [html.text("Ctrl")]),
        html.text(" + "),
        kbd.kbd([], [html.text("K")]),
        html.text(" to open search."),
      ]),
      html.div([attribute.class("flex flex-wrap items-center gap-4")], [
        html.div([attribute.class("grid gap-1")], [
          html.span([attribute.class("text-sm font-medium")], [
            html.text("Shortcut"),
          ]),
          kbd.shortcut(["Ctrl", "K"], []),
        ]),
        html.div([attribute.class("grid gap-1")], [
          html.span([attribute.class("text-sm font-medium")], [
            html.text("Sequence"),
          ]),
          kbd.shortcut(["Shift", "Ctrl", "P"], []),
        ]),
      ]),
    ]),
  ])
}

fn basecoat_select_base(
  id: String,
  name: String,
  selected_label: String,
  selected_value: String,
  trigger_attrs: List(Attribute(msg)),
  popover_attrs: List(Attribute(msg)),
  listbox_attrs: List(Attribute(msg)),
  children: List(lustre_element.Element(msg)),
) -> lustre_element.Element(msg) {
  let trigger_id = id <> "-trigger"
  let listbox_id = id <> "-listbox"
  let popover_id = id <> "-popover"

  html.div([attribute.id(id), attribute.class("select")], [
    html.button(
      [
        attribute.type_("button"),
        attribute.id(trigger_id),
        attribute.aria_haspopup("listbox"),
        attribute.aria_expanded(False),
        attribute.aria_controls(listbox_id),
        ..trigger_attrs
      ],
      [
        html.span([attribute.class("truncate")], [html.text(selected_label)]),
        icon.icon("chevron-down", [
          attribute.class("text-muted-foreground opacity-50 shrink-0"),
        ]),
      ],
    ),
    html.div(
      [
        attribute.id(popover_id),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
        ..popover_attrs
      ],
      [
        html.div(
          [
            attribute.role("listbox"),
            attribute.id(listbox_id),
            attribute.aria_orientation("vertical"),
            attribute.aria_labelledby(trigger_id),
            ..listbox_attrs
          ],
          children,
        ),
      ],
    ),
    html.input([
      attribute.type_("hidden"),
      attribute.name(name),
      attribute.value(selected_value),
    ]),
  ])
}

fn basecoat_combobox(
  id: String,
  name: String,
  trigger_attrs: List(Attribute(msg)),
  popover_attrs: List(Attribute(msg)),
  empty_message: String,
  children: List(lustre_element.Element(msg)),
) -> lustre_element.Element(msg) {
  let trigger_id = id <> "-trigger"
  let listbox_id = id <> "-listbox"
  let popover_id = id <> "-popover"

  html.div([attribute.id(id), attribute.class("select")], [
    html.button(
      [
        attribute.type_("button"),
        attribute.id(trigger_id),
        attribute.aria_haspopup("listbox"),
        attribute.aria_expanded(False),
        attribute.aria_controls(listbox_id),
        ..trigger_attrs
      ],
      [
        html.span([attribute.class("truncate")], []),
        icon.icon("chevrons-up-down", [
          attribute.class("text-muted-foreground opacity-50 shrink-0"),
        ]),
      ],
    ),
    html.div(
      [
        attribute.id(popover_id),
        attribute.data("popover", ""),
        attribute.aria_hidden(True),
        ..popover_attrs
      ],
      [
        html.header([], [
          icon.search([]),
          html.input([
            attribute.type_("text"),
            attribute.value(""),
            attribute.placeholder("Search entries..."),
            attribute.autocomplete("off"),
            attribute.autocorrect(False),
            attribute.spellcheck(False),
            attribute.aria_autocomplete("list"),
            attribute.role("combobox"),
            attribute.aria_expanded(False),
            attribute.aria_controls(listbox_id),
            attribute.aria_labelledby(trigger_id),
          ]),
        ]),
        html.div(
          [
            attribute.role("listbox"),
            attribute.id(listbox_id),
            attribute.aria_orientation("vertical"),
            attribute.aria_labelledby(trigger_id),
            attribute.data("empty", empty_message),
          ],
          children,
        ),
      ],
    ),
    html.input([
      attribute.type_("hidden"),
      attribute.name(name),
      attribute.value(""),
    ]),
  ])
}

fn section_combobox() -> lustre_element.Element(msg) {
  sink_section_simple(
    "combobox",
    "Combobox",
    "https://basecoatui.com/components/combobox",
    [
      html.div([attribute.class("flex flex-wrap items-start gap-4")], [
        basecoat_combobox(
          "demo-combobox-frameworks",
          "demo-combobox-frameworks-value",
          [attribute.class("btn-outline w-48")],
          [attribute.class("w-48")],
          "No framework found.",
          [
            html.div(
              [attribute.role("option"), attribute.data("value", "Next.js")],
              [
                html.text("Next.js"),
              ],
            ),
            html.div(
              [attribute.role("option"), attribute.data("value", "SvelteKit")],
              [
                html.text("SvelteKit"),
              ],
            ),
            html.div(
              [attribute.role("option"), attribute.data("value", "Nuxt.js")],
              [
                html.text("Nuxt.js"),
              ],
            ),
            html.div(
              [attribute.role("option"), attribute.data("value", "Remix")],
              [
                html.text("Remix"),
              ],
            ),
            html.div(
              [attribute.role("option"), attribute.data("value", "Astro")],
              [
                html.text("Astro"),
              ],
            ),
          ],
        ),
        basecoat_combobox(
          "demo-combobox-timezones",
          "demo-combobox-timezones-value",
          [attribute.class("btn-outline w-72")],
          [attribute.class("w-72")],
          "No timezone found.",
          [
            html.div([attribute.class("max-h-64 overflow-y-auto scrollbar")], [
              html.div(
                [
                  attribute.role("group"),
                  attribute.aria_labelledby("demo-combobox-timezones-group-0"),
                ],
                [
                  html.span(
                    [
                      attribute.id("demo-combobox-timezones-group-0"),
                      attribute.role("heading"),
                    ],
                    [html.text("Americas")],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "America/New_York"),
                    ],
                    [
                      html.text("(GMT-5) New York"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "America/Los_Angeles"),
                    ],
                    [
                      html.text("(GMT-8) Los Angeles"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "America/Chicago"),
                    ],
                    [
                      html.text("(GMT-6) Chicago"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "America/Toronto"),
                    ],
                    [
                      html.text("(GMT-5) Toronto"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "America/Vancouver"),
                    ],
                    [
                      html.text("(GMT-8) Vancouver"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "America/Sao_Paulo"),
                    ],
                    [
                      html.text("(GMT-3) Sao Paulo"),
                    ],
                  ),
                ],
              ),
              html.div(
                [
                  attribute.role("group"),
                  attribute.aria_labelledby("demo-combobox-timezones-group-1"),
                ],
                [
                  html.span(
                    [
                      attribute.id("demo-combobox-timezones-group-1"),
                      attribute.role("heading"),
                    ],
                    [html.text("Europe")],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Europe/London"),
                    ],
                    [
                      html.text("(GMT+0) London"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Europe/Paris"),
                    ],
                    [
                      html.text("(GMT+1) Paris"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Europe/Berlin"),
                    ],
                    [
                      html.text("(GMT+1) Berlin"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Europe/Rome"),
                    ],
                    [
                      html.text("(GMT+1) Rome"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Europe/Madrid"),
                    ],
                    [
                      html.text("(GMT+1) Madrid"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Europe/Amsterdam"),
                    ],
                    [
                      html.text("(GMT+1) Amsterdam"),
                    ],
                  ),
                ],
              ),
              html.div(
                [
                  attribute.role("group"),
                  attribute.aria_labelledby("demo-combobox-timezones-group-2"),
                ],
                [
                  html.span(
                    [
                      attribute.id("demo-combobox-timezones-group-2"),
                      attribute.role("heading"),
                    ],
                    [html.text("Asia/Pacific")],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Asia/Tokyo"),
                    ],
                    [
                      html.text("(GMT+9) Tokyo"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Asia/Shanghai"),
                    ],
                    [
                      html.text("(GMT+8) Shanghai"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Asia/Singapore"),
                    ],
                    [
                      html.text("(GMT+8) Singapore"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Asia/Dubai"),
                    ],
                    [
                      html.text("(GMT+4) Dubai"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Australia/Sydney"),
                    ],
                    [
                      html.text("(GMT+11) Sydney"),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "Asia/Seoul"),
                    ],
                    [
                      html.text("(GMT+9) Seoul"),
                    ],
                  ),
                ],
              ),
            ]),
            html.hr([attribute.role("separator")]),
            html.div([attribute.role("option")], [
              icon.icon("circle-plus", []),
              html.text("Create timezone"),
            ]),
          ],
        ),
      ]),
    ],
  )
}

fn section_dialog() -> lustre_element.Element(msg) {
  let edit_id = "demo-dialog-edit-profile"
  let scroll_id = "dialog-example"

  sink_section_simple(
    "dialog",
    "Dialog",
    "https://basecoatui.com/components/dialog",
    [
      html.div([attribute.class("flex flex-wrap items-center gap-4")], [
        dialog.trigger_button(edit_id, [attribute.class("btn-outline")], [
          html.text("Edit Profile"),
        ]),
        dialog.dialog_with_description(
          edit_id,
          "Edit profile",
          "Make changes to your profile here. Click save when you're done.",
          [
            attribute.class("w-full sm:max-w-[425px] max-h-[612px]"),
            dialog.close_on_backdrop(),
          ],
          [
            dialog.content([], [
              form.form([attribute.class("grid gap-4")], [
                html.div([attribute.class("grid gap-3")], [
                  html.label([attribute.for(edit_id <> "-name")], [
                    html.text("Name"),
                  ]),
                  html.input([
                    attribute.type_("text"),
                    attribute.id(edit_id <> "-name"),
                    attribute.value("Pedro Duarte"),
                  ]),
                ]),
                html.div([attribute.class("grid gap-3")], [
                  html.label([attribute.for(edit_id <> "-username")], [
                    html.text("Username"),
                  ]),
                  html.input([
                    attribute.type_("text"),
                    attribute.id(edit_id <> "-username"),
                    attribute.value("@peduarte"),
                  ]),
                ]),
              ]),
            ]),
            dialog.footer([], [
              button.outline(
                [attribute("onclick", dialog.close_script(edit_id))],
                [html.text("Cancel")],
              ),
              button.button(
                [attribute("onclick", dialog.close_script(edit_id))],
                [html.text("Save changes")],
              ),
            ]),
            dialog.close_button([]),
          ],
        ),
        dialog.trigger_button(scroll_id, [attribute.class("btn-outline")], [
          html.text("Scrollable Content"),
        ]),
        dialog.dialog_with_description(
          scroll_id,
          "Scrollable Content",
          "This is a dialog with scrollable content.",
          [
            attribute.class("w-full sm:max-w-[425px] max-h-[612px]"),
            dialog.close_on_backdrop(),
          ],
          [
            dialog.scrollable_content([], [
              html.div([attribute.class("space-y-4 text-sm")], [
                html.p([], [
                  html.text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                  ),
                ]),
                html.p([], [
                  html.text(
                    "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                  ),
                ]),
              ]),
            ]),
            dialog.footer([], [
              button.outline(
                [attribute("onclick", dialog.close_script(scroll_id))],
                [html.text("Close")],
              ),
            ]),
            dialog.close_button([]),
          ],
        ),
      ]),
    ],
  )
}

fn section_dropdown_menu() -> lustre_element.Element(msg) {
  let dd1 = "dropdown-menu-default"
  let dd1_trigger = dd1 <> "-trigger"
  let dd1_menu = dd1 <> "-menu"
  let dd1_popover = dd1 <> "-popover"

  let dd2 = "dropdown-menu-checkboxes"
  let dd2_trigger = dd2 <> "-trigger"
  let dd2_menu = dd2 <> "-menu"
  let dd2_popover = dd2 <> "-popover"

  let dd3 = "dropdown-menu-radio-group"
  let dd3_trigger = dd3 <> "-trigger"
  let dd3_menu = dd3 <> "-menu"
  let dd3_popover = dd3 <> "-popover"

  let dd_profile = "dropdown-menu-profile"
  let dd_profile_trigger = dd_profile <> "-trigger"
  let dd_profile_menu = dd_profile <> "-menu"
  let dd_profile_popover = dd_profile <> "-popover"

  sink_section_simple(
    "dropdown-menu",
    "Dropdown Menu",
    "https://basecoatui.com/components/dropdown-menu",
    [
      html.div([attribute.class("flex flex-wrap items-start gap-4")], [
        dropdown_menu.dropdown(dd1, [
          dropdown_menu.trigger_with_ids(
            dd1_trigger,
            dd1_menu,
            dd1_popover,
            [attribute.class("btn-outline")],
            [html.text("Open")],
          ),
          dropdown_menu.content_with_ids(
            dd1_popover,
            dd1_menu,
            dd1_trigger,
            [attribute.class("min-w-56")],
            [
              dropdown_menu.group("My Account", [
                dropdown_menu.item_with_shortcut("⇧⌘P", [], [
                  html.text("Profile"),
                ]),
                dropdown_menu.item_with_shortcut("⌘B", [], [
                  html.text("Billing"),
                ]),
                dropdown_menu.item_with_shortcut("⌘S", [], [
                  html.text("Settings"),
                ]),
                dropdown_menu.item_with_shortcut("⌘K", [], [
                  html.text("Keyboard shortcuts"),
                ]),
              ]),
              dropdown_menu.separator(),
              dropdown_menu.item([], [html.text("GitHub")]),
              dropdown_menu.item([], [html.text("Support")]),
              dropdown_menu.item([dropdown_menu.disabled()], [html.text("API")]),
              dropdown_menu.separator(),
              dropdown_menu.item_with_shortcut("⇧⌘P", [], [html.text("Logout")]),
            ],
          ),
        ]),
        dropdown_menu.dropdown(dd2, [
          dropdown_menu.trigger_with_ids(
            dd2_trigger,
            dd2_menu,
            dd2_popover,
            [attribute.class("btn-outline")],
            [html.text("Checkboxes")],
          ),
          dropdown_menu.content_with_ids(
            dd2_popover,
            dd2_menu,
            dd2_trigger,
            [attribute.class("min-w-56")],
            [
              dropdown_menu.group("Account Options", [
                dropdown_menu.item([], [icon.user([]), html.text("Profile")]),
                dropdown_menu.item([], [
                  icon.icon("credit-card", []),
                  html.text("Billing"),
                ]),
                dropdown_menu.item([], [
                  icon.settings([]),
                  html.text("Settings"),
                ]),
              ]),
              dropdown_menu.separator(),
              dropdown_menu.group("Appearance", [
                dropdown_menu.checkbox_item(True, [attribute.class("group")], [
                  icon.check([
                    attribute.class("invisible group-aria-checked:visible"),
                    attribute.aria_hidden(True),
                  ]),
                  html.text("Status Bar"),
                ]),
                dropdown_menu.checkbox_item(
                  False,
                  [attribute.class("group"), dropdown_menu.disabled()],
                  [
                    icon.check([
                      attribute.class("invisible group-aria-checked:visible"),
                      attribute.aria_hidden(True),
                    ]),
                    html.text("Activity Bar"),
                  ],
                ),
                dropdown_menu.checkbox_item(False, [attribute.class("group")], [
                  icon.check([
                    attribute.class("invisible group-aria-checked:visible"),
                    attribute.aria_hidden(True),
                  ]),
                  html.text("Panel"),
                ]),
              ]),
              dropdown_menu.separator(),
              dropdown_menu.item([], [
                icon.icon("log-out", []),
                html.text("Logout"),
              ]),
            ],
          ),
        ]),
        html.script(
          [],
          "(() => { const dropdownMenu = document.querySelector('#dropdown-menu-checkboxes'); if (!dropdownMenu) return; const checkboxes = dropdownMenu.querySelectorAll('div[role=\"menuitemcheckbox\"]'); checkboxes.forEach(checkbox => { checkbox.addEventListener('click', () => { const isChecked = checkbox.getAttribute('aria-checked') === 'true'; checkbox.setAttribute('aria-checked', (!isChecked).toString()); }); }); })();",
        ),
        dropdown_menu.dropdown(dd3, [
          dropdown_menu.trigger_with_ids(
            dd3_trigger,
            dd3_menu,
            dd3_popover,
            [attribute.class("btn-outline")],
            [html.text("Radio Group")],
          ),
          dropdown_menu.content_with_ids(
            dd3_popover,
            dd3_menu,
            dd3_trigger,
            [attribute.class("min-w-56")],
            [
              dropdown_menu.heading("position-options", [], [
                html.text("Panel Position"),
              ]),
              dropdown_menu.separator(),
              dropdown_menu.radio_item(False, [attribute.class("group")], [
                html.div(
                  [attribute.class("size-4 flex items-center justify-center")],
                  [
                    html.div(
                      [
                        attribute.class(
                          "size-2 rounded-full bg-foreground invisible group-aria-checked:visible",
                        ),
                        attribute.aria_hidden(True),
                      ],
                      [],
                    ),
                  ],
                ),
                html.text("Status Bar"),
              ]),
              dropdown_menu.radio_item(True, [attribute.class("group")], [
                html.div(
                  [attribute.class("size-4 flex items-center justify-center")],
                  [
                    html.div(
                      [
                        attribute.class(
                          "size-2 rounded-full bg-foreground invisible group-aria-checked:visible",
                        ),
                        attribute.aria_hidden(True),
                      ],
                      [],
                    ),
                  ],
                ),
                html.text("Activity Bar"),
              ]),
              dropdown_menu.radio_item(False, [attribute.class("group")], [
                html.div(
                  [attribute.class("size-4 flex items-center justify-center")],
                  [
                    html.div(
                      [
                        attribute.class(
                          "size-2 rounded-full bg-foreground invisible group-aria-checked:visible",
                        ),
                        attribute.aria_hidden(True),
                      ],
                      [],
                    ),
                  ],
                ),
                html.text("Panel"),
              ]),
            ],
          ),
        ]),
        html.script(
          [],
          "(() => { const dropdownMenu = document.querySelector('#dropdown-menu-radio-group'); if (!dropdownMenu) return; const radios = dropdownMenu.querySelectorAll('div[role=\"menuitemradio\"]'); radios.forEach(r => { r.addEventListener('click', () => { radios.forEach(x => x.setAttribute('aria-checked', 'false')); r.setAttribute('aria-checked', 'true'); }); }); })();",
        ),
        dropdown_menu.dropdown(dd_profile, [
          dropdown_menu.trigger_with_ids(
            dd_profile_trigger,
            dd_profile_menu,
            dd_profile_popover,
            [
              attribute.class(
                "btn-outline h-12 justify-start px-2 md:max-w-[200px]",
              ),
            ],
            [
              html.img([
                attribute.src("https://github.com/hunvreus.png"),
                attribute.alt("@hunvreus"),
                attribute.class("size-8 shrink-0 rounded-full"),
              ]),
              html.div(
                [attribute.class("grid flex-1 text-left text-sm leading-tight")],
                [
                  html.span([attribute.class("truncate font-medium")], [
                    html.text("hunvreus"),
                  ]),
                  html.span(
                    [attribute.class("text-muted-foreground truncate text-xs")],
                    [
                      html.text("hunvreus@example.com"),
                    ],
                  ),
                ],
              ),
              icon.icon("chevrons-up-down", [
                attribute.class("text-muted-foreground ml-auto"),
              ]),
            ],
          ),
          dropdown_menu.content_with_ids(
            dd_profile_popover,
            dd_profile_menu,
            dd_profile_trigger,
            [],
            [
              dropdown_menu.item([], [
                icon.star([]),
                html.text("Upgrade to Pro"),
              ]),
              dropdown_menu.separator(),
              dropdown_menu.item([], [icon.user([]), html.text("Account")]),
              dropdown_menu.item([], [
                icon.icon("credit-card", []),
                html.text("Billing"),
              ]),
              dropdown_menu.item([], [
                icon.icon("bell", []),
                html.text("Notifications"),
              ]),
              dropdown_menu.separator(),
              dropdown_menu.item([], [
                icon.icon("log-out", []),
                html.text("Signout"),
              ]),
            ],
          ),
        ]),
      ]),
    ],
  )
}

fn section_form() -> lustre_element.Element(msg) {
  sink_section(
    "form",
    "Form",
    "https://basecoatui.com/components/form",
    "scroll-mt-16",
    [
      html.form([attribute.class("form grid w-full max-w-sm gap-6")], [
        html.div([attribute.class("grid gap-2")], [
          html.label([attribute.for("demo-form-text")], [html.text("Username")]),
          html.input([
            attribute.type_("text"),
            attribute.id("demo-form-text"),
            attribute.placeholder("hunvreus"),
          ]),
          html.p([attribute.class("text-muted-foreground text-sm")], [
            html.text("This is your public display name."),
          ]),
        ]),
        html.div([attribute.class("grid gap-2")], [
          html.label([attribute.for("demo-form-select")], [html.text("Email")]),
          html.select([attribute.id("demo-form-select")], [
            html.option([attribute.value("bob@example.com")], "m@example.com"),
            html.option([attribute.value("alice@example.com")], "m@google.com"),
            html.option([attribute.value("john@example.com")], "m@support.com"),
          ]),
          html.p([attribute.class("text-muted-foreground text-sm")], [
            html.text("You can manage email addresses in your email settings."),
          ]),
        ]),
        html.div([attribute.class("grid gap-2")], [
          html.label([attribute.for("demo-form-textarea")], [html.text("Bio")]),
          html.textarea(
            [
              attribute.id("demo-form-textarea"),
              attribute.placeholder("I like to..."),
              attribute.rows(3),
            ],
            "",
          ),
          html.p([attribute.class("text-muted-foreground text-sm")], [
            html.text("You can @mention other users and organizations."),
          ]),
        ]),
        html.div([attribute.class("flex flex-col gap-3")], [
          html.label([attribute.for("demo-form-radio")], [
            html.text("Notify me about..."),
          ]),
          html.fieldset(
            [attribute.id("demo-form-radio"), attribute.class("grid gap-3")],
            [
              html.label([attribute.class("font-normal")], [
                html.input([
                  attribute.type_("radio"),
                  attribute.name("demo-form-radio"),
                  attribute.value("1"),
                ]),
                html.text("All new messages"),
              ]),
              html.label([attribute.class("font-normal")], [
                html.input([
                  attribute.type_("radio"),
                  attribute.name("demo-form-radio"),
                  attribute.value("2"),
                ]),
                html.text("Direct messages and mentions"),
              ]),
              html.label([attribute.class("font-normal")], [
                html.input([
                  attribute.type_("radio"),
                  attribute.name("demo-form-radio"),
                  attribute.value("3"),
                ]),
                html.text("Nothing"),
              ]),
            ],
          ),
        ]),
        html.div(
          [
            attribute.class(
              "flex flex-row items-start gap-3 rounded-md border p-4 shadow-xs",
            ),
          ],
          [
            html.input([
              attribute.type_("checkbox"),
              attribute.id("demo-form-checkbox"),
            ]),
            html.div([attribute.class("flex flex-col gap-1")], [
              html.label(
                [
                  attribute.for("demo-form-checkbox"),
                  attribute.class("leading-snug"),
                ],
                [
                  html.text("Use different settings for my mobile devices"),
                ],
              ),
              html.p(
                [attribute.class("text-muted-foreground text-sm leading-snug")],
                [
                  html.text(
                    "You can manage your mobile notifications in the mobile settings page.",
                  ),
                ],
              ),
            ]),
          ],
        ),
        html.div([attribute.class("flex flex-col gap-4")], [
          html.header([], [
            html.label(
              [
                attribute.for("demo-form-checkboxes"),
                attribute.class("text-base leading-normal"),
              ],
              [html.text("Sidebar")],
            ),
            html.p([attribute.class("text-muted-foreground text-sm")], [
              html.text("Select the items you want to display in the sidebar."),
            ]),
          ]),
          html.fieldset(
            [
              attribute.id("demo-form-checkboxes"),
              attribute.class("flex flex-col gap-2"),
            ],
            [
              html.label([attribute.class("font-normal leading-tight")], [
                html.input([
                  attribute.type_("checkbox"),
                  attribute.name("demo-form-checkboxes"),
                  attribute.value("1"),
                  attribute.checked(True),
                ]),
                html.text("Recents"),
              ]),
              html.label([attribute.class("font-normal leading-tight")], [
                html.input([
                  attribute.type_("checkbox"),
                  attribute.name("demo-form-checkboxes"),
                  attribute.value("2"),
                  attribute.checked(True),
                ]),
                html.text("Home"),
              ]),
              html.label([attribute.class("font-normal leading-tight")], [
                html.input([
                  attribute.type_("checkbox"),
                  attribute.name("demo-form-checkboxes"),
                  attribute.value("3"),
                ]),
                html.text("Applications"),
              ]),
              html.label([attribute.class("font-normal leading-tight")], [
                html.input([
                  attribute.type_("checkbox"),
                  attribute.name("demo-form-checkboxes"),
                  attribute.value("4"),
                ]),
                html.text("Desktop"),
              ]),
              html.label([attribute.class("font-normal leading-tight")], [
                html.input([
                  attribute.type_("checkbox"),
                  attribute.name("demo-form-checkboxes"),
                  attribute.value("5"),
                ]),
                html.text("Download"),
              ]),
              html.label([attribute.class("font-normal leading-tight")], [
                html.input([
                  attribute.type_("checkbox"),
                  attribute.name("demo-form-checkboxes"),
                  attribute.value("6"),
                ]),
                html.text("Documents"),
              ]),
            ],
          ),
        ]),
        html.div([attribute.class("grid gap-2")], [
          html.label([attribute.for("demo-form-date")], [
            html.text("Date of birth"),
          ]),
          html.input([
            attribute.type_("date"),
            attribute.id("demo-form-date"),
          ]),
          html.p([attribute.class("text-muted-foreground text-sm")], [
            html.text("Your date of birth is used to calculate your age."),
          ]),
        ]),
        html.section([attribute.class("grid gap-4")], [
          html.h3([attribute.class("text-lg font-medium")], [
            html.text("Email Notifications"),
          ]),
          html.div(
            [
              attribute.class(
                "gap-2 flex flex-row items-start justify-between rounded-lg border p-4 shadow-xs",
              ),
            ],
            [
              html.div([attribute.class("flex flex-col gap-0.5")], [
                html.label(
                  [
                    attribute.for("demo-form-switch"),
                    attribute.class("leading-normal"),
                  ],
                  [
                    html.text("Marketing emails"),
                  ],
                ),
                html.p([attribute.class("text-muted-foreground text-sm")], [
                  html.text(
                    "Receive emails about new products, features, and more.",
                  ),
                ]),
              ]),
              html.input([
                attribute.type_("checkbox"),
                attribute.id("demo-form-switch"),
                attribute.role("switch"),
              ]),
            ],
          ),
          html.div(
            [
              attribute.class(
                "gap-2 flex flex-row items-start justify-between rounded-lg border p-4 shadow-xs",
              ),
            ],
            [
              html.div([attribute.class("flex flex-col gap-0.5 opacity-60")], [
                html.label(
                  [
                    attribute.for("demo-form-switch-disabled"),
                    attribute.class("leading-normal"),
                  ],
                  [
                    html.text("Marketing emails"),
                  ],
                ),
                html.p([attribute.class("text-muted-foreground text-sm")], [
                  html.text(
                    "Receive emails about new products, features, and more.",
                  ),
                ]),
              ]),
              html.input([
                attribute.type_("checkbox"),
                attribute.id("demo-form-switch-disabled"),
                attribute.role("switch"),
                attribute.disabled(True),
              ]),
            ],
          ),
        ]),
        html.button([attribute.type_("submit"), attribute.class("btn")], [
          html.text("Submit"),
        ]),
      ]),
    ],
  )
}

fn section_input() -> lustre_element.Element(msg) {
  sink_section_simple(
    "input",
    "Input",
    "https://basecoatui.com/components/input",
    [
      html.div([attribute.class("flex flex-col gap-y-4")], [
        html.input([
          attribute.type_("text"),
          attribute.class("input"),
          attribute.placeholder("Text"),
        ]),
        html.input([
          attribute.type_("text"),
          attribute.class("input"),
          attribute.disabled(True),
          attribute.placeholder("Disabled"),
        ]),
        html.input([
          attribute.type_("text"),
          attribute.class("input"),
          attribute.aria_invalid("true"),
          attribute.placeholder("Error"),
        ]),
        html.input([
          attribute.type_("email"),
          attribute.class("input"),
          attribute.placeholder("Email"),
        ]),
        html.input([
          attribute.type_("password"),
          attribute.class("input"),
          attribute.placeholder("Password"),
        ]),
        html.input([
          attribute.type_("number"),
          attribute.class("input"),
          attribute.placeholder("Number"),
        ]),
        html.input([attribute.type_("file"), attribute.class("input")]),
        html.input([
          attribute.type_("tel"),
          attribute.class("input"),
          attribute.placeholder("Tel"),
        ]),
        html.input([
          attribute.type_("url"),
          attribute.class("input"),
          attribute.placeholder("URL"),
        ]),
        html.input([
          attribute.type_("search"),
          attribute.class("input"),
          attribute.placeholder("Search"),
        ]),
        html.input([attribute.type_("date"), attribute.class("input")]),
        html.input([attribute.type_("datetime-local"), attribute.class("input")]),
        html.input([attribute.type_("month"), attribute.class("input")]),
        html.input([attribute.type_("week"), attribute.class("input")]),
        html.input([attribute.type_("time"), attribute.class("input")]),
      ]),
    ],
  )
}

fn section_label() -> lustre_element.Element(msg) {
  sink_section_simple(
    "label",
    "Label",
    "https://basecoatui.com/components/label",
    [
      html.div([attribute.class("grid w-full max-w-sm gap-6")], [
        html.div([attribute.class("flex items-center gap-3")], [
          html.input([
            attribute.type_("checkbox"),
            attribute.id("label-demo-terms"),
            attribute.class("input"),
          ]),
          label.label([attribute.for("label-demo-terms")], [
            html.text("Accept terms and conditions"),
          ]),
        ]),
        html.div([attribute.class("grid gap-3")], [
          label.label([attribute.for("label-demo-text")], [
            html.text("Username"),
          ]),
          input.input([
            attribute.id("label-demo-text"),
            input.placeholder("Username"),
          ]),
        ]),
        html.div([attribute.class("grid gap-3")], [
          label.label([attribute.for("label-demo-disabled")], [
            html.text("Disabled"),
          ]),
          input.input([
            attribute.id("label-demo-disabled"),
            input.placeholder("Disabled"),
            input.disabled(),
          ]),
        ]),
        html.div([attribute.class("grid gap-3")], [
          label.label([attribute.for("label-demo-textarea")], [
            html.text("Message"),
          ]),
          textarea.textarea(
            [
              attribute.id("label-demo-textarea"),
              attribute.placeholder("Message"),
            ],
            "",
          ),
        ]),
      ]),
    ],
  )
}

fn section_pagination() -> lustre_element.Element(msg) {
  sink_section_simple(
    "pagination",
    "Pagination",
    "https://basecoatui.com/components/pagination",
    [
      html.div([attribute.class("inline-flex")], [
        html.nav(
          [
            attribute.role("navigation"),
            attribute.aria_label("pagination"),
            attribute.class("mx-auto flex w-full justify-center"),
          ],
          [
            html.ul([attribute.class("flex flex-row items-center gap-1")], [
              html.li([], [
                html.a([attribute.href("#"), attribute.class("btn-ghost")], [
                  icon.icon("chevron-left", []),
                  html.text(" Previous"),
                ]),
              ]),
              html.li([], [
                html.a(
                  [attribute.href("#"), attribute.class("btn-ghost size-9")],
                  [
                    html.text("1"),
                  ],
                ),
              ]),
              html.li([], [
                html.a(
                  [attribute.href("#"), attribute.class("btn-outline size-9")],
                  [
                    html.text("2"),
                  ],
                ),
              ]),
              html.li([], [
                html.a(
                  [attribute.href("#"), attribute.class("btn-ghost size-9")],
                  [
                    html.text("3"),
                  ],
                ),
              ]),
              html.li([], [
                html.a(
                  [attribute.href("#"), attribute.class("btn-icon-ghost")],
                  [
                    icon.icon("ellipsis", []),
                  ],
                ),
              ]),
              html.li([], [
                html.a([attribute.href("#"), attribute.class("btn-ghost")], [
                  html.text("Next "),
                  icon.icon("chevron-right", []),
                ]),
              ]),
            ]),
          ],
        ),
      ]),
    ],
  )
}

fn section_popover() -> lustre_element.Element(msg) {
  let id = "demo-popover"
  let popover_id = id <> "-popover"

  sink_section_simple(
    "popover",
    "Popover",
    "https://basecoatui.com/components/popover",
    [
      popover.popover(id, [
        popover.trigger_with_id(popover_id, [attribute.class("btn-outline")], [
          html.text("Open popover"),
        ]),
        popover.content_with_id(popover_id, [attribute.class("w-80")], [
          html.div([attribute.class("grid gap-4")], [
            html.header([attribute.class("grid gap-1.5")], [
              html.h4([attribute.class("leading-none font-medium")], [
                html.text("Dimensions"),
              ]),
              html.p([attribute.class("text-muted-foreground text-sm")], [
                html.text("Set the dimensions for the layer."),
              ]),
            ]),
            html.form([attribute.class("form grid gap-2")], [
              html.div(
                [attribute.class("grid grid-cols-3 items-center gap-4")],
                [
                  html.label([attribute.for("demo-popover-width")], [
                    html.text("Width"),
                  ]),
                  html.input([
                    attribute.type_("text"),
                    attribute.id("demo-popover-width"),
                    attribute.value("100%"),
                    attribute.class("col-span-2 h-8"),
                  ]),
                ],
              ),
              html.div(
                [attribute.class("grid grid-cols-3 items-center gap-4")],
                [
                  html.label([attribute.for("demo-popover-max-width")], [
                    html.text("Max. width"),
                  ]),
                  html.input([
                    attribute.type_("text"),
                    attribute.id("demo-popover-max-width"),
                    attribute.value("300px"),
                    attribute.class("col-span-2 h-8"),
                  ]),
                ],
              ),
              html.div(
                [attribute.class("grid grid-cols-3 items-center gap-4")],
                [
                  html.label([attribute.for("demo-popover-height")], [
                    html.text("Height"),
                  ]),
                  html.input([
                    attribute.type_("text"),
                    attribute.id("demo-popover-height"),
                    attribute.value("25px"),
                    attribute.class("col-span-2 h-8"),
                  ]),
                ],
              ),
              html.div(
                [attribute.class("grid grid-cols-3 items-center gap-4")],
                [
                  html.label([attribute.for("demo-popover-max-height")], [
                    html.text("Max. height"),
                  ]),
                  html.input([
                    attribute.type_("text"),
                    attribute.id("demo-popover-max-height"),
                    attribute.value("none"),
                    attribute.class("col-span-2 h-8"),
                  ]),
                ],
              ),
            ]),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_progress() -> lustre_element.Element(msg) {
  sink_section_simple(
    "progress",
    "Progress",
    "https://basecoatui.com/components/progress",
    [
      html.div([attribute.class("max-w-xl")], [
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
    ],
  )
}

fn section_radio_group() -> lustre_element.Element(msg) {
  sink_section_simple(
    "radio-group",
    "Radio Group",
    "https://basecoatui.com/components/radio-group",
    [
      html.div([attribute.class("flex flex-col gap-y-6")], [
        html.fieldset([attribute.class("grid gap-3")], [
          html.label([attribute.class("label")], [
            html.input([
              attribute.type_("radio"),
              attribute.name("demo-radio-group"),
              attribute.value("default"),
              attribute.class("input"),
            ]),
            html.text("Default"),
          ]),
          html.label([attribute.class("label")], [
            html.input([
              attribute.type_("radio"),
              attribute.name("demo-radio-group"),
              attribute.value("comfortable"),
              attribute.class("input"),
            ]),
            html.text("Comfortable"),
          ]),
          html.label([attribute.class("label")], [
            html.input([
              attribute.type_("radio"),
              attribute.name("demo-radio-group"),
              attribute.value("compact"),
              attribute.class("input"),
            ]),
            html.text("Compact"),
          ]),
        ]),
        html.fieldset([attribute.class("grid gap-3 max-w-sm")], [
          html.label(
            [
              attribute.class(
                "label gap-3 items-start hover:bg-accent/50 rounded-lg border p-4 has-[input[type='radio']:checked]:border-green-600 has-[input[type='radio']:checked]:bg-green-50 dark:has-[input[type='radio']:checked]:border-green-900 dark:has-[input[type='radio']:checked]:bg-green-950",
              ),
            ],
            [
              html.input([
                attribute.type_("radio"),
                attribute.name("demo-radio-group-styled"),
                attribute.value("starter"),
                attribute.class(
                  "input checked:bg-green-600 checked:border-green-600 dark:checked:bg-input/30 checked:before:bg-background dark:checked:before:bg-primary",
                ),
              ]),
              html.div([attribute.class("grid gap-1 font-normal")], [
                html.h2([attribute.class("font-medium")], [
                  html.text("Starter Plan"),
                ]),
                html.p([attribute.class("text-muted-foreground leading-snug")], [
                  html.text(
                    "Perfect for small businesses getting started with our platform",
                  ),
                ]),
              ]),
            ],
          ),
          html.label(
            [
              attribute.class(
                "label gap-3 items-start hover:bg-accent/50 rounded-lg border p-4 has-[input[type='radio']:checked]:border-green-600 has-[input[type='radio']:checked]:bg-green-50 dark:has-[input[type='radio']:checked]:border-green-900 dark:has-[input[type='radio']:checked]:bg-green-950",
              ),
            ],
            [
              html.input([
                attribute.type_("radio"),
                attribute.name("demo-radio-group-styled"),
                attribute.value("pro"),
                attribute.class(
                  "input checked:bg-green-600 checked:border-green-600 dark:checked:bg-input/30 checked:before:bg-background dark:checked:before:bg-primary",
                ),
              ]),
              html.div([attribute.class("grid gap-1 font-normal")], [
                html.h2([attribute.class("font-medium")], [
                  html.text("Pro Plan"),
                ]),
                html.p([attribute.class("text-muted-foreground leading-snug")], [
                  html.text(
                    "Advanced features for growing businesses with higher demands",
                  ),
                ]),
              ]),
            ],
          ),
        ]),
      ]),
    ],
  )
}

fn section_select() -> lustre_element.Element(msg) {
  sink_section_simple(
    "select",
    "Select",
    "https://basecoatui.com/components/select",
    [
      html.div([attribute.class("flex flex-col gap-4")], [
        html.div(
          [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
          [
            html.select([attribute.class("select w-[180px]")], [
              html.optgroup([attribute("label", "Fruits")], [
                html.option([], "Apple"),
                html.option([], "Banana"),
                html.option([], "Blueberry"),
              ]),
              html.optgroup([attribute("label", "Grapes")], [
                html.option([], "Pineapple"),
              ]),
            ]),
            html.select(
              [attribute.class("select w-[180px]"), attribute.disabled(True)],
              [
                html.option([], "Disabled"),
              ],
            ),
          ],
        ),
        html.div([attribute.class("flex flex-wrap items-center gap-4")], [
          html.div(
            [attribute.class("flex flex-wrap items-center gap-2 md:flex-row")],
            [
              basecoat_select_base(
                "select-default",
                "select-default-value",
                "Blueberry",
                "blueberry",
                [attribute.class("btn-outline w-[180px]")],
                [],
                [],
                [
                  html.div(
                    [
                      attribute.role("group"),
                      attribute.aria_labelledby(
                        "group-label-select-default-items-1",
                      ),
                    ],
                    [
                      html.div(
                        [
                          attribute.role("heading"),
                          attribute.id("group-label-select-default-items-1"),
                        ],
                        [
                          html.text("Fruits"),
                        ],
                      ),
                      html.div(
                        [
                          attribute.role("option"),
                          attribute.data("value", "apple"),
                        ],
                        [
                          html.text("Apple"),
                        ],
                      ),
                      html.div(
                        [
                          attribute.role("option"),
                          attribute.data("value", "banana"),
                        ],
                        [
                          html.text("Banana"),
                        ],
                      ),
                      html.div(
                        [
                          attribute.role("option"),
                          attribute.data("value", "blueberry"),
                          attribute.aria_selected(True),
                        ],
                        [html.text("Blueberry")],
                      ),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("group"),
                      attribute.aria_labelledby(
                        "group-label-select-default-items-2",
                      ),
                    ],
                    [
                      html.div(
                        [
                          attribute.role("heading"),
                          attribute.id("group-label-select-default-items-2"),
                        ],
                        [
                          html.text("Grapes"),
                        ],
                      ),
                      html.div(
                        [
                          attribute.role("option"),
                          attribute.data("value", "pineapple"),
                        ],
                        [
                          html.text("Pineapple"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              basecoat_select_base(
                "select-scrollbar",
                "select-scrollbar-value",
                "",
                "",
                [attribute.class("btn-outline w-[180px]")],
                [],
                [attribute.class("scrollbar overflow-y-auto max-h-64")],
                int.range(from: 0, to: 100, with: [], run: fn(acc, i) {
                  [i, ..acc]
                })
                  |> list.reverse
                  |> list.map(fn(i) {
                    html.div(
                      [
                        attribute.role("option"),
                        attribute.data("value", "item-" <> int.to_string(i)),
                      ],
                      [html.text("Item " <> int.to_string(i))],
                    )
                  }),
              ),
              basecoat_select_base(
                "select-disabled",
                "select-disabled-value",
                "",
                "",
                [
                  attribute.class("btn-outline w-[180px]"),
                  attribute.disabled(True),
                ],
                [],
                [],
                [
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "disabled"),
                    ],
                    [
                      html.text("Disabled"),
                    ],
                  ),
                ],
              ),
              basecoat_select_base(
                "select-with-icon",
                "chart-type",
                "",
                "",
                [attribute.class("btn-outline w-[180px]")],
                [],
                [],
                [
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "bar"),
                      attribute("type", "button"),
                    ],
                    [
                      html.span([attribute.class("flex items-center gap-2")], [
                        icon.icon("chart-bar", [
                          attribute.class("text-muted-foreground"),
                        ]),
                        html.text("Bar"),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "line"),
                      attribute("type", "button"),
                    ],
                    [
                      html.span([attribute.class("flex items-center gap-2")], [
                        icon.icon("chart-line", [
                          attribute.class("text-muted-foreground"),
                        ]),
                        html.text("Line"),
                      ]),
                    ],
                  ),
                  html.div(
                    [
                      attribute.role("option"),
                      attribute.data("value", "pie"),
                      attribute("type", "button"),
                    ],
                    [
                      html.span([attribute.class("flex items-center gap-2")], [
                        icon.icon("chart-pie", [
                          attribute.class("text-muted-foreground"),
                        ]),
                        html.text("Pie"),
                      ]),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ]),
      ]),
    ],
  )
}

fn section_sidebar() -> lustre_element.Element(msg) {
  let sidebar_id = "demo-sidebar"

  sink_section_simple(
    "sidebar",
    "Sidebar",
    "https://basecoatui.com/components/sidebar",
    [
      html.div([attribute.class("grid gap-4")], [
        html.div([attribute.class("flex flex-wrap items-center gap-2")], [
          button.outline(
            [attribute("onclick", sidebar.open_script(sidebar_id))],
            [html.text("Open")],
          ),
          button.outline(
            [attribute("onclick", sidebar.close_script(sidebar_id))],
            [html.text("Close")],
          ),
          button.outline(
            [attribute("onclick", sidebar.toggle_script(sidebar_id))],
            [html.text("Toggle")],
          ),
        ]),
        html.div([attribute.class("rounded-lg border overflow-hidden")], [
          sidebar.sidebar(
            sidebar_id,
            [
              sidebar.left(),
              attribute(
                "style",
                "position: static; width: 280px; height: 360px;",
              ),
            ],
            [
              sidebar.nav_with_label("Demo sidebar", [], [
                sidebar.header([], [
                  html.a(
                    [
                      attribute.href("#"),
                      attribute.class("btn-ghost p-2 h-12 w-full justify-start"),
                    ],
                    [
                      html.div(
                        [
                          attribute.class(
                            "bg-sidebar-primary text-sidebar-primary-foreground flex aspect-square size-8 items-center justify-center rounded-lg",
                          ),
                        ],
                        [icon.icon("layout-grid", [attribute.class("size-4")])],
                      ),
                      html.div(
                        [
                          attribute.class(
                            "grid flex-1 text-left text-sm leading-tight",
                          ),
                        ],
                        [
                          html.span([attribute.class("truncate font-medium")], [
                            html.text("Glaze Basecoat"),
                          ]),
                          html.span([attribute.class("truncate text-xs")], [
                            html.text("v" <> basecoat.version),
                          ]),
                        ],
                      ),
                    ],
                  ),
                ]),
                sidebar.section([], [
                  sidebar.group("Getting started", [
                    sidebar.link("#", True, [], [
                      icon.home([attribute.class("size-4")]),
                      html.span([], [html.text("Home")]),
                    ]),
                    sidebar.link("#", False, [], [
                      icon.icon("square-terminal", [attribute.class("size-4")]),
                      html.span([], [html.text("Playground")]),
                    ]),
                    sidebar.link("#", False, [], [
                      icon.icon("settings", [attribute.class("size-4")]),
                      html.span([], [html.text("Settings")]),
                    ]),
                  ]),
                  sidebar.group("Resources", [
                    sidebar.link("#", False, [], [
                      icon.github([attribute.class("size-4")]),
                      html.span([], [html.text("GitHub")]),
                    ]),
                    sidebar.link("#", False, [], [
                      icon.icon("book-open", [attribute.class("size-4")]),
                      html.span([], [html.text("Docs")]),
                    ]),
                  ]),
                ]),
                sidebar.footer([attribute.class("p-2 border-t")], [
                  html.div([attribute.class("flex items-center gap-2")], [
                    html.img([
                      attribute.src("https://github.com/hunvreus.png"),
                      attribute.alt("User"),
                      attribute.class("size-8 rounded-lg"),
                    ]),
                    html.div(
                      [attribute.class("grid flex-1 text-left text-sm")],
                      [
                        html.span([attribute.class("truncate font-medium")], [
                          html.text("hunvreus"),
                        ]),
                        html.span(
                          [
                            attribute.class(
                              "truncate text-xs text-muted-foreground",
                            ),
                          ],
                          [
                            html.text("hunvreus@example.com"),
                          ],
                        ),
                      ],
                    ),
                    button.icon_outline([], [icon.more_vertical([])]),
                  ]),
                ]),
              ]),
            ],
          ),
        ]),
      ]),
    ],
  )
}

fn section_skeleton() -> lustre_element.Element(msg) {
  sink_section_simple(
    "skeleton",
    "Skeleton",
    "https://basecoatui.com/components/skeleton",
    [
      html.div([attribute.class("flex flex-col gap-4")], [
        html.div([attribute.class("flex items-center gap-4")], [
          skeleton.circle([]),
          html.div([attribute.class("grid gap-2")], [
            skeleton.text([attribute.class("w-[150px]")]),
            skeleton.text([attribute.class("w-[100px]")]),
          ]),
        ]),
        html.div([attribute.class("flex max-sm:flex-col gap-4 w-full")], [
          card.card([attribute.class("w-full @md:w-auto @md:min-w-sm")], [
            card.header([], [
              skeleton.text([attribute.class("w-2/3")]),
              skeleton.text([attribute.class("w-1/2")]),
            ]),
            card.content([], [skeleton.image([])]),
          ]),
          card.card([attribute.class("w-full @md:w-auto @md:min-w-sm")], [
            card.header([], [
              skeleton.text([attribute.class("w-2/3")]),
              skeleton.text([attribute.class("w-1/2")]),
            ]),
            card.content([], [skeleton.image([])]),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_slider() -> lustre_element.Element(msg) {
  sink_section_simple(
    "slider",
    "Slider",
    "https://basecoatui.com/components/slider",
    [
      html.div([attribute.class("max-w-sm")], [
        html.input([
          attribute.type_("range"),
          attribute.class("input w-full"),
          attribute.min("0"),
          attribute.max("27"),
          attribute.value("12"),
        ]),
      ]),
      html.script(
        [],
        "(() => { const sliders = document.querySelectorAll('input[type=\"range\"].input'); if (!sliders) return; const update = (el) => { const min = parseFloat(el.min || 0); const max = parseFloat(el.max || 100); const value = parseFloat(el.value); const percent = (max === min) ? 0 : ((value - min) / (max - min)) * 100; el.style.setProperty('--slider-value', `${percent}%`); }; sliders.forEach(slider => { update(slider); slider.addEventListener('input', (event) => update(event.target)); }); })();",
      ),
    ],
  )
}

fn section_spinner() -> lustre_element.Element(msg) {
  sink_section_simple(
    "spinner",
    "Spinner",
    "https://basecoatui.com/components/spinner",
    [
      html.div([attribute.class("grid gap-6")], [
        html.div([attribute.class("flex flex-wrap items-center gap-6")], [
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
        spinner.overlay([attribute.class("w-full max-w-xl")], [
          card.card([], [
            card.header([], [
              html.h2([], [html.text("Loading state")]),
              html.p([], [
                html.text("This card is dimmed and blocked while loading."),
              ]),
            ]),
            card.content([], [
              html.div([attribute.class("grid gap-2 text-sm")], [
                html.p([], [html.text("Fetching data...")]),
                html.p([attribute.class("text-muted-foreground")], [
                  html.text("Please wait."),
                ]),
              ]),
            ]),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_switch() -> lustre_element.Element(msg) {
  sink_section_simple(
    "switch",
    "Switch",
    "https://basecoatui.com/components/switch",
    [
      html.div([attribute.class("inline-flex flex-col gap-y-6")], [
        html.label([attribute.class("label")], [
          html.input([
            attribute.type_("checkbox"),
            attribute.name("switch"),
            attribute.role("switch"),
            attribute.class("input"),
          ]),
          html.text("Airplane Mode"),
        ]),
        html.label([attribute.class("label")], [
          html.input([
            attribute.type_("checkbox"),
            attribute.name("switch"),
            attribute.role("switch"),
            attribute.class(
              "input checked:bg-blue-500 dark:checked:bg-blue-600",
            ),
            attribute.checked(True),
          ]),
          html.text("Bluetooth"),
        ]),
        html.label(
          [
            attribute.class(
              "label gap-6 leading-none border rounded-lg p-4 has-[input[type='checkbox']:checked]:border-blue-600",
            ),
          ],
          [
            html.div([attribute.class("grid gap-1")], [
              html.h2([attribute.class("font-medium text-sm")], [
                html.text("Share across devices"),
              ]),
              html.p([attribute.class("text-muted-foreground text-sm")], [
                html.text(
                  "Focus is shared across devices, and turns off when you leave the app.",
                ),
              ]),
            ]),
            html.input([
              attribute.type_("checkbox"),
              attribute.name("switch"),
              attribute.role("switch"),
              attribute.class(
                "input checked:bg-blue-500 dark:checked:bg-blue-600",
              ),
            ]),
          ],
        ),
      ]),
    ],
  )
}

fn section_table() -> lustre_element.Element(msg) {
  sink_section_simple(
    "table",
    "Table",
    "https://basecoatui.com/components/table",
    [
      html.div([attribute.class("relative w-full overflow-x-auto")], [
        table.table([], [
          table.caption([], [html.text("A list of your recent invoices.")]),
          table.thead([], [
            table.tr([], [
              table.th([], [html.text("Invoice")]),
              table.th([], [html.text("Status")]),
              table.th([], [html.text("Method")]),
              table.th([], [html.text("Amount")]),
            ]),
          ]),
          table.tbody([], [
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV001")]),
              table.td([], [html.text("Paid")]),
              table.td([], [html.text("Credit Card")]),
              table.td([table.align_right()], [html.text("$250.00")]),
            ]),
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV002")]),
              table.td([], [html.text("Pending")]),
              table.td([], [html.text("PayPal")]),
              table.td([table.align_right()], [html.text("$150.00")]),
            ]),
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV003")]),
              table.td([], [html.text("Unpaid")]),
              table.td([], [html.text("Bank Transfer")]),
              table.td([table.align_right()], [html.text("$350.00")]),
            ]),
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV004")]),
              table.td([], [html.text("Paid")]),
              table.td([], [html.text("Paypal")]),
              table.td([table.align_right()], [html.text("$450.00")]),
            ]),
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV005")]),
              table.td([], [html.text("Paid")]),
              table.td([], [html.text("Credit Card")]),
              table.td([table.align_right()], [html.text("$550.00")]),
            ]),
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV006")]),
              table.td([], [html.text("Pending")]),
              table.td([], [html.text("Bank Transfer")]),
              table.td([table.align_right()], [html.text("$200.00")]),
            ]),
            table.tr([], [
              table.td([table.font_medium()], [html.text("INV007")]),
              table.td([], [html.text("Unpaid")]),
              table.td([], [html.text("Credit Card")]),
              table.td([table.align_right()], [html.text("$300.00")]),
            ]),
          ]),
          table.tfoot([], [
            table.tr([], [
              html.td([attribute.colspan(3)], [html.text("Total")]),
              table.td([table.align_right()], [html.text("$2,500.00")]),
            ]),
          ]),
        ]),
      ]),
    ],
  )
}

fn section_tabs() -> lustre_element.Element(msg) {
  sink_section_simple("tabs", "Tabs", "https://basecoatui.com/components/tabs", [
    html.div([attribute.class("flex flex-col gap-6")], [
      tabs.tab_set(
        "demo-tabs-with-panels",
        [
          #(
            "account",
            "Account",
            True,
            card.card([], [
              card.header([], [
                html.h2([], [html.text("Account")]),
                html.p([], [
                  html.text(
                    "Make changes to your account here. Click save when you're done.",
                  ),
                ]),
              ]),
              card.content([], [
                form.form([attribute.class("grid gap-6")], [
                  html.div([attribute.class("grid gap-3")], [
                    html.label([attribute.for("demo-tabs-account-name")], [
                      html.text("Name"),
                    ]),
                    html.input([
                      attribute.type_("text"),
                      attribute.id("demo-tabs-account-name"),
                      attribute.value("Pedro Duarte"),
                    ]),
                  ]),
                  html.div([attribute.class("grid gap-3")], [
                    html.label([attribute.for("demo-tabs-account-username")], [
                      html.text("Username"),
                    ]),
                    html.input([
                      attribute.type_("text"),
                      attribute.id("demo-tabs-account-username"),
                      attribute.value("@peduarte"),
                    ]),
                  ]),
                ]),
              ]),
              card.footer([], [button.button([], [html.text("Save changes")])]),
            ]),
          ),
          #(
            "password",
            "Password",
            False,
            card.card([], [
              card.header([], [
                html.h2([], [html.text("Password")]),
                html.p([], [
                  html.text(
                    "Change your password here. After saving, you'll be logged out.",
                  ),
                ]),
              ]),
              card.content([], [
                form.form([attribute.class("grid gap-6")], [
                  html.div([attribute.class("grid gap-3")], [
                    html.label([attribute.for("demo-tabs-password-current")], [
                      html.text("Current password"),
                    ]),
                    html.input([
                      attribute.type_("password"),
                      attribute.id("demo-tabs-password-current"),
                    ]),
                  ]),
                  html.div([attribute.class("grid gap-3")], [
                    html.label([attribute.for("demo-tabs-password-new")], [
                      html.text("New password"),
                    ]),
                    html.input([
                      attribute.type_("password"),
                      attribute.id("demo-tabs-password-new"),
                    ]),
                  ]),
                ]),
              ]),
              card.footer([], [button.button([], [html.text("Save Password")])]),
            ]),
          ),
        ],
        [attribute.class("max-w-[300px]")],
      ),
      tabs.tab_set(
        "demo-tabs-without-panels",
        [
          #("home", "Home", True, html.div([], [])),
          #("settings", "Settings", False, html.div([], [])),
        ],
        [],
      ),
      tabs.tab_set(
        "demo-tabs-disabled",
        [
          #("home", "Home", True, html.div([], [])),
          #("disabled", "Disabled", False, html.div([], [])),
        ],
        [],
      ),
      tabs.tabs("demo-tabs-with-icons", [], [
        tabs.tab_list([], [
          tabs.tab_trigger(
            "demo-tabs-with-icons-tab-1",
            "demo-tabs-with-icons-panel-1",
            True,
            [],
            [icon.icon("app-window", []), html.text("Preview")],
          ),
          tabs.tab_trigger(
            "demo-tabs-with-icons-tab-2",
            "demo-tabs-with-icons-panel-2",
            False,
            [],
            [icon.icon("code", []), html.text("Code")],
          ),
        ]),
        tabs.tab_panel(
          "demo-tabs-with-icons-panel-1",
          "demo-tabs-with-icons-tab-1",
          True,
          [],
          [html.div([], [html.text("Preview")])],
        ),
        tabs.tab_panel(
          "demo-tabs-with-icons-panel-2",
          "demo-tabs-with-icons-tab-2",
          False,
          [],
          [html.div([], [html.text("Code")])],
        ),
      ]),
    ]),
  ])
}

fn section_theme_switcher() -> lustre_element.Element(msg) {
  sink_section_simple(
    "theme-switcher",
    "Theme Switcher",
    "https://basecoatui.com/components/theme-switcher",
    [
      html.div([attribute.class("grid gap-4")], [
        html.div([attribute.class("flex flex-wrap items-center gap-2")], [
          theme_switcher.button([]),
          theme_switcher.button_with_tooltip("bottom", []),
        ]),
        html.div([attribute.class("flex flex-wrap items-center gap-2")], [
          button.outline(
            [attribute("onclick", theme_switcher.set_light_script())],
            [html.text("Set light")],
          ),
          button.outline(
            [attribute("onclick", theme_switcher.set_dark_script())],
            [html.text("Set dark")],
          ),
          button.outline(
            [attribute("onclick", theme_switcher.toggle_script())],
            [html.text("Toggle")],
          ),
        ]),
      ]),
    ],
  )
}

fn theme_swatch(label: String, css_var: String) -> lustre_element.Element(msg) {
  html.div([attribute.class("grid gap-2")], [
    html.div(
      [
        attribute.class("h-10 w-full rounded-md border"),
        attribute("style", "background: var(" <> css_var <> ");"),
      ],
      [],
    ),
    html.div([attribute.class("grid")], [
      html.span([attribute.class("text-sm font-medium")], [html.text(label)]),
      html.span([attribute.class("text-muted-foreground text-xs font-mono")], [
        html.text(css_var),
      ]),
    ]),
  ])
}

fn section_theme() -> lustre_element.Element(msg) {
  sink_section_simple("theme", "Theme", "https://basecoatui.com/themes", [
    html.div([attribute.class("grid gap-4")], [
      html.p([attribute.class("text-muted-foreground text-sm")], [
        html.text(
          "Swatches are rendered from Basecoat CSS variables (e.g. --primary).",
        ),
      ]),
      html.div(
        [
          attribute.class(
            "grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3",
          ),
        ],
        [
          theme_swatch("Background", "--background"),
          theme_swatch("Foreground", "--foreground"),
          theme_swatch("Primary", "--primary"),
          theme_swatch("Secondary", "--secondary"),
          theme_swatch("Accent", "--accent"),
          theme_swatch("Destructive", "--destructive"),
          theme_swatch("Border", "--border"),
          theme_swatch("Ring", "--ring"),
          theme_swatch("Card", "--card"),
        ],
      ),
    ]),
  ])
}

fn section_textarea() -> lustre_element.Element(msg) {
  sink_section_simple(
    "textarea",
    "Textarea",
    "https://basecoatui.com/components/textarea",
    [
      html.div([attribute.class("flex flex-col gap-y-10")], [
        textarea.textarea([textarea.placeholder("Type your message here")], ""),
        textarea.textarea(
          [textarea.placeholder("Type your message here"), textarea.invalid()],
          "",
        ),
        html.div([attribute.class("grid gap-3")], [
          label.label([attribute.for("textarea-demo-label")], [
            html.text("Label"),
          ]),
          textarea.textarea(
            [
              textarea.id("textarea-demo-label"),
              textarea.placeholder("Type your message here"),
            ],
            "",
          ),
        ]),
        html.div([attribute.class("grid gap-3")], [
          label.label([attribute.for("textarea-demo-label-and-description")], [
            html.text("With label and description"),
          ]),
          textarea.textarea(
            [
              textarea.id("textarea-demo-label-and-description"),
              textarea.placeholder("Type your message here"),
            ],
            "",
          ),
          html.p([attribute.class("text-muted-foreground text-sm")], [
            html.text("Type your message and press enter to send."),
          ]),
        ]),
        html.div([attribute.class("grid gap-3")], [
          label.label([attribute.for("textarea-demo-disabled")], [
            html.text("Disabled"),
          ]),
          textarea.textarea(
            [
              textarea.id("textarea-demo-disabled"),
              textarea.placeholder("Type your message here"),
              textarea.disabled(),
            ],
            "",
          ),
        ]),
      ]),
    ],
  )
}

fn section_toast() -> lustre_element.Element(msg) {
  sink_section_simple(
    "toast",
    "Toast",
    "https://basecoatui.com/components/toast",
    [
      html.div([attribute.class("flex flex-wrap items-center gap-2")], [
        button.outline(
          [attribute("onclick", toast.success_toast("Success", "Saved!"))],
          [html.text("Success")],
        ),
        button.outline(
          [
            attribute(
              "onclick",
              toast.error_toast("Error", "Something went wrong."),
            ),
          ],
          [html.text("Error")],
        ),
        button.outline(
          [
            attribute(
              "onclick",
              toast.show(toast.Config(toast.Info, "Info", "FYI", None, None)),
            ),
          ],
          [html.text("Info")],
        ),
        button.outline(
          [
            attribute(
              "onclick",
              toast.show(toast.Config(
                toast.Warning,
                "Warning",
                "Be careful",
                None,
                None,
              )),
            ),
          ],
          [html.text("Warning")],
        ),
      ]),
    ],
  )
}

fn section_tooltip() -> lustre_element.Element(msg) {
  sink_section_simple(
    "tooltip",
    "Tooltip",
    "https://basecoatui.com/components/tooltip",
    [
      html.div([attribute.class("flex flex-wrap items-center gap-4")], [
        html.button(
          [
            attribute.type_("button"),
            attribute.class("btn-outline"),
            attribute.data("tooltip", "Top tooltip"),
          ],
          [html.text("Top")],
        ),
        html.button(
          [
            attribute.type_("button"),
            attribute.class("btn-outline"),
            attribute.data("tooltip", "Right tooltip"),
            attribute.data("side", "right"),
          ],
          [html.text("Right")],
        ),
        html.button(
          [
            attribute.type_("button"),
            attribute.class("btn-outline"),
            attribute.data("tooltip", "Bottom tooltip"),
            attribute.data("side", "bottom"),
          ],
          [html.text("Bottom")],
        ),
        html.button(
          [
            attribute.type_("button"),
            attribute.class("btn-outline"),
            attribute.data("tooltip", "Left tooltip"),
            attribute.data("side", "left"),
          ],
          [html.text("Left")],
        ),
      ]),
    ],
  )
}
