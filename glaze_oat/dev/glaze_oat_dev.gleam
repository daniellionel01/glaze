import glaze_oat
import glaze_oat/accordion.{accordion}
import glaze_oat/alert.{alert}
import glaze_oat/badge.{badge}
import glaze_oat/breadcrumb.{breadcrumb}
import glaze_oat/button.{button}
import glaze_oat/card.{card}
import glaze_oat/dialog.{dialog}
import glaze_oat/dropdown.{dropdown}
import glaze_oat/form.{form}
import glaze_oat/meter.{meter}
import glaze_oat/pagination.{pagination}
import glaze_oat/progress.{progress}
import glaze_oat/sidebar
import glaze_oat/skeleton
import glaze_oat/spinner
import glaze_oat/theme
import gleam/list
import lustre/attribute.{attribute}
import lustre/element.{element}
import lustre/element/html
import simplifile

/// Demo page ported from https://oat.ink/demo/
/// Sources:
/// - https://github.com/knadh/oat/blob/master/docs/static/demo.css
/// - https://github.com/knadh/oat/blob/master/docs/templates/demo.html
///
pub fn page() {
  html.html([attribute("lang", "en")], [
    html.head([], [
      html.meta([
        attribute.name("viewport"),
        attribute.content("width=device-width, initial-scale=1"),
      ]),
      html.title([], "glaze_oat_dev"),

      glaze_oat.head(glaze_oat.version, theme.default_theme),

      html.style(
        [],
        "
        body.demo {
          & {
            margin-top: var(--space-8);
            margin-bottom: var(--space-8);
          }
          .section {
            margin-bottom: var(--space-8);
          }

          .container {
            max-width: 1200px;
          }

          .stat-value {
            font-size: var(--text-1);
            font-weight: 700;
            line-height: 1.1;
            letter-spacing: -0.02em;
          }

          .faux-bar-chart {
            display: flex;
            align-items: flex-end;
            gap: var(--space-2);
            height: 120px;
          }

          .faux-bar {
            flex: 1;
            background: var(--primary);
            border-radius: var(--radius-small) var(--radius-small) 0 0;
            min-width: 0;
          }

          .activity-item {
            padding-bottom: var(--space-3);
            border-bottom: 1px solid var(--border);

            &:last-child {
              border-bottom: none;
              padding-bottom: 0;
            }
          }
        }
      ",
      ),

      // source: https://github.com/knadh/oat/blob/835552bece6cde8abaf692ce7412f7d0707e7754/docs/static/main.js#L130
      html.script(
        [],
        "
      function toggleTheme() {
        var cs = document.documentElement.style.colorScheme;
        var isDark = cs === 'dark' || (!cs && matchMedia('(prefers-color-scheme: dark)').matches);
        var theme = isDark ? 'light' : 'dark';
        document.documentElement.style.colorScheme = theme;
        document.documentElement.setAttribute('data-theme', theme);
        localStorage.setItem('theme', theme);
      }
      ",
      ),
    ]),
    html.body([attribute.class("demo")], [
      html.main([attribute.class("container")], [
        html.section([attribute.class("section")], [
          html.div([attribute.class("hstack justify-between mb-6")], [
            html.div([attribute.class("hstack")], [
              html.h2([attribute("style", "margin: 0;")], [html.text("Demo")]),
              badge([badge.success()], [html.text("Live")]),
              badge([badge.secondary()], [html.text("v1.0.0")]),
            ]),
            html.div([attribute.class("hstack")], [
              button(
                list.append(
                  [button.small(), button.outline()],
                  dialog.open_for("dialog"),
                ),
                [html.text("Open Dialog")],
              ),
              dialog([dialog.id("dialog"), dialog.closed_by_any()], [
                dialog.header([], [html.h3([], [html.text("Title")])]),
                html.p([], [html.text("Lorem Ipsum!")]),
                dialog.footer([], [
                  button(dialog.close_for("dialog"), [html.text("close")]),
                ]),
              ]),

              button(
                [
                  button.small(),
                  button.outline(),
                  attribute("onclick", "toggleTheme()"),
                ],
                [html.text("Toggle Theme")],
              ),
              html.label(
                [
                  attribute("style", "margin: 0;"),
                  attribute.class("hstack gap-2"),
                ],
                [
                  html.input([
                    attribute.checked(True),
                    attribute.role("switch"),
                    attribute.type_("checkbox"),
                  ]),
                  html.text(" Auto-refresh "),
                ],
              ),
              dropdown([], [
                button(
                  [
                    button.outline(),
                    button.small(),
                    dropdown.trigger_for("export-menu"),
                  ],
                  [html.text(" Export ▾ ")],
                ),
                dropdown.menu("export-menu", [], [
                  dropdown.item([], [
                    html.text("Export as CSV"),
                  ]),
                  dropdown.item([], [
                    html.text("Export as JSON"),
                  ]),
                  html.hr([]),
                  dropdown.item([], [
                    html.text("Print report"),
                  ]),
                ]),
              ]),
              button(
                [attribute("data-tooltip", "Refresh data now"), button.small()],
                [html.text(" ↻ Refresh ")],
              ),
            ]),
          ]),
        ]),
        breadcrumb([], [
          breadcrumb.link([attribute.href("#")], [html.text("Home")]),
          breadcrumb.slash([]),
          breadcrumb.link([attribute.href("#")], [html.text("Gleam")]),
          breadcrumb.slash([]),
          breadcrumb.link([attribute.href("#")], [
            html.strong([], [html.text("Demo")]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          html.div([attribute.class("row")], [
            html.div([attribute.class("col-3")], [
              card([], [
                card.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Revenue"),
                  ]),
                  html.div([attribute.class("stat-value")], [
                    html.text("$42,128"),
                  ]),
                  html.small([attribute.class("text-light")], [
                    badge([badge.success()], [html.text("+12.5%")]),
                    html.text(" vs last month"),
                  ]),
                ]),
                card.footer([], [
                  progress([
                    progress.max_int(100),
                    progress.value_int(72),
                  ]),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-3")], [
              card([], [
                card.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Active Users"),
                  ]),
                  html.div([attribute.class("stat-value")], [html.text("2,847")]),
                  html.small([attribute.class("text-light")], [
                    badge([badge.warning()], [html.text("-3.2%")]),
                    html.text(" vs last month"),
                  ]),
                ]),
                card.footer([], [
                  progress([
                    progress.max_int(100),
                    progress.value_int(58),
                  ]),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-3")], [
              card([], [
                card.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Retention"),
                  ]),
                  html.div([attribute.class("stat-value")], [html.text("3.24%")]),
                  html.small([attribute.class("text-light")], [
                    badge([badge.success()], [html.text("+0.8%")]),
                    html.text(" vs last month"),
                  ]),
                ]),
                card.footer([], [
                  meter([
                    meter.optimum_int(1),
                    meter.high_float(0.7),
                    meter.low_float(0.3),
                    meter.max_int(1),
                    meter.min_int(0),
                    meter.value_float(0.65),
                  ]),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-3")], [
              card([], [
                card.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Uptime"),
                  ]),
                  html.div([attribute.class("stat-value")], [
                    html.text("99.99%"),
                  ]),
                  html.small([attribute.class("text-light")], [
                    badge([], [
                      html.text("Healthy"),
                    ]),
                  ]),
                ]),
                card.footer([], [
                  meter([
                    meter.optimum_int(1),
                    meter.high_float(0.99),
                    meter.low_float(0.95),
                    meter.max_int(1),
                    meter.min_int(0),
                    meter.value_float(0.9998),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          card([], [
            element("ot-tabs", [], [
              html.div([attribute.role("tablist")], [
                button([attribute.role("tab")], [html.text("Overview")]),
                button([attribute.role("tab")], [html.text("Performance")]),
                button([attribute.role("tab")], [html.text("Reports")]),
              ]),
              html.div([attribute.role("tabpanel")], [
                html.h4([], [html.text("Weekly Traffic")]),
                html.div([attribute.class("faux-bar-chart")], [
                  html.div(
                    [
                      attribute("data-tooltip", "Mon: 1,204"),
                      attribute("style", "height: 45%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                  html.div(
                    [
                      attribute("data-tooltip", "Tue: 1,659"),
                      attribute("style", "height: 62%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                  html.div(
                    [
                      attribute("data-tooltip", "Wed: 2,087"),
                      attribute("style", "height: 78%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                  html.div(
                    [
                      attribute("data-tooltip", "Thu: 1,472"),
                      attribute("style", "height: 55%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                  html.div(
                    [
                      attribute("data-tooltip", "Fri: 2,411"),
                      attribute("style", "height: 90%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                  html.div(
                    [
                      attribute("data-tooltip", "Sat: 1,874"),
                      attribute("style", "height: 70%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                  html.div(
                    [
                      attribute("data-tooltip", "Sun: 1,071"),
                      attribute("style", "height: 40%;"),
                      attribute.class("faux-bar"),
                    ],
                    [],
                  ),
                ]),
                html.blockquote([], [
                  html.text(
                    "This dummy kitchensink dashboard page shows various UI components and layouts built with Oat.",
                  ),
                ]),
              ]),
              html.div([attribute.role("tabpanel")], [
                html.article(
                  [
                    spinner.size_overlay(spinner.Large),
                    spinner.busy(),
                    attribute.class("card"),
                  ],
                  [
                    html.header([], [
                      html.h4([], [html.text("Performance Metrics")]),
                    ]),
                    html.p([], [html.text("Fetching latest benchmark data…")]),
                    html.div([attribute.class("row mt-4")], [
                      html.div([attribute.class("col-6")], [
                        html.strong([], [html.text("Avg Response")]),
                        html.p([], [html.text("142 ms")]),
                        progress([
                          progress.max_int(100),
                          progress.value_int(14),
                        ]),
                      ]),
                      html.div([attribute.class("col-6")], [
                        html.strong([], [html.text("Error Rate")]),
                        html.p([], [html.text("0.03%")]),
                        progress([
                          progress.max_int(100),
                          progress.value_int(3),
                        ]),
                      ]),
                    ]),
                  ],
                ),
              ]),
              html.div([attribute.role("tabpanel")], [
                html.h4([], [html.text("Monthly Summary")]),
                html.div([attribute.class("table")], [
                  html.table([], [
                    html.thead([], [
                      html.tr([], [
                        html.th([], [html.text("Metric")]),
                        html.th([], [html.text("Value")]),
                        html.th([], [html.text("Change")]),
                      ]),
                    ]),
                    html.tbody([], [
                      html.tr([], [
                        html.td([], [html.text("Page views")]),
                        html.td([], [html.text("1,234,567")]),
                        html.td([], [
                          badge([badge.success()], [
                            html.text("+8%"),
                          ]),
                        ]),
                      ]),
                      html.tr([], [
                        html.td([], [html.text("Bounce rate")]),
                        html.td([], [html.text("42.3%")]),
                        html.td([], [
                          badge([badge.danger()], [
                            html.text("+2.1%"),
                          ]),
                        ]),
                      ]),
                      html.tr([], [
                        html.td([], [html.text("Avg session")]),
                        html.td([], [html.text("4m 12s")]),
                        html.td([], [
                          badge([badge.success()], [
                            html.text("+15s"),
                          ]),
                        ]),
                      ]),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          html.div([attribute.class("row")], [
            html.div([attribute.class("col-6")], [
              card([], [
                card.header([], [html.h3([], [html.text("Recent Activity")])]),
                html.div([attribute.class("vstack gap-4")], [
                  html.div([attribute.class("activity-item")], [
                    html.div([attribute.class("hstack")], [
                      badge([badge.success()], [
                        html.text("Deploy"),
                      ]),
                      html.strong([], [html.text("Production deploy #1847")]),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("2 minutes ago by "),
                      html.strong([], [html.text("alice")]),
                    ]),
                  ]),
                  html.div([attribute.class("activity-item")], [
                    html.div([attribute.class("hstack")], [
                      badge([badge.warning()], [
                        html.text("Alert"),
                      ]),
                      html.strong([], [
                        html.text("High memory usage on worker-3"),
                      ]),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("18 minutes ago — "),
                      html.em([], [html.text("auto-resolved")]),
                    ]),
                  ]),
                  html.div([attribute.class("activity-item")], [
                    html.div([attribute.class("hstack")], [
                      badge([], [
                        html.text("Merge"),
                      ]),
                      html.strong([], [
                        html.text("PR #392: Update auth middleware"),
                      ]),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("1 hour ago by "),
                      html.strong([], [html.text("bob")]),
                    ]),
                  ]),
                  html.div([attribute.class("activity-item")], [
                    html.div([attribute.class("hstack")], [
                      badge([badge.danger()], [
                        html.text("Incident"),
                      ]),
                      html.strong([], [
                        html.text("API latency spike (resolved)"),
                      ]),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("3 hours ago — duration: 4m 22s"),
                    ]),
                  ]),
                  html.div([attribute.class("activity-item")], [
                    html.div([attribute.class("hstack")], [
                      badge([badge.secondary()], [
                        html.text("Config"),
                      ]),
                      html.strong([], [html.text("Updated rate limits")]),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("5 hours ago by "),
                      html.strong([], [html.text("carol")]),
                    ]),
                  ]),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-6")], [
              card([], [
                card.header([], [
                  html.h3([], [html.text("Server Status")]),
                  html.small([attribute.class("text-light hstack gap-2")], [
                    html.span(
                      [
                        spinner.size(spinner.Small),
                        spinner.busy(),
                      ],
                      [],
                    ),
                    html.text(" Monitoring "),
                  ]),
                ]),
                html.div([attribute.class("vstack gap-4")], [
                  html.div([], [
                    html.div([attribute.class("hstack justify-between")], [
                      html.strong([], [html.text("CPU Usage")]),
                      badge([badge.success()], [
                        html.text("Normal"),
                      ]),
                    ]),
                    progress([
                      progress.max_int(100),
                      progress.value_int(42),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("42% — 8 cores"),
                    ]),
                  ]),
                  html.div([], [
                    html.div([attribute.class("hstack justify-between")], [
                      html.strong([], [html.text("Memory")]),
                      badge([badge.warning()], [
                        html.text("High"),
                      ]),
                    ]),
                    progress([
                      progress.max_int(100),
                      progress.value_int(78),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("12.5 / 16 GB used"),
                    ]),
                  ]),
                  html.div([], [
                    html.div([attribute.class("hstack justify-between")], [
                      html.strong([], [html.text("Disk I/O")]),
                      badge([badge.success()], [
                        html.text("Normal"),
                      ]),
                    ]),
                    meter([
                      meter.optimum_int(0),
                      meter.high_float(0.7),
                      meter.low_float(0.3),
                      meter.max_int(1),
                      meter.min_int(0),
                      meter.value_float(0.35),
                    ]),
                    html.small([attribute.class("text-lighter")], [
                      html.text("Read: 145 MB/s — Write: 82 MB/s"),
                    ]),
                  ]),
                  html.div([], [
                    html.div([attribute.class("row")], [
                      html.div([attribute.class("col-6")], [
                        html.strong([], [html.text("Network In")]),
                        html.p([attribute("style", "margin:0;")], [
                          html.text("1.2 Gbps"),
                        ]),
                        progress([
                          progress.max_int(100),
                          progress.value_int(60),
                        ]),
                      ]),
                      html.div([attribute.class("col-6")], [
                        html.strong([], [html.text("Network Out")]),
                        html.p([attribute("style", "margin:0;")], [
                          html.text("840 Mbps"),
                        ]),
                        progress([
                          progress.max_int(100),
                          progress.value_int(42),
                        ]),
                      ]),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          card([], [
            card.header([], [html.h3([], [html.text("Recent Orders")])]),
            html.div([attribute.class("hstack justify-between mb-4")], [
              html.fieldset(
                [
                  attribute("style", "margin: 0; max-width: 300px;"),
                  attribute.class("group"),
                ],
                [
                  html.input([
                    attribute("aria-label", "Search orders"),
                    attribute.placeholder("Search orders…"),
                    attribute.type_("search"),
                  ]),
                  button([button.outline()], [
                    html.text("Search"),
                  ]),
                ],
              ),
              button.group([], [
                button([button.ghost(), button.small()], [
                  html.text("All"),
                ]),
                button([button.outline(), button.small()], [
                  html.text("Pending"),
                ]),
                button([button.outline(), button.small()], [
                  html.text("Shipped"),
                ]),
              ]),
            ]),
            html.div([attribute.class("table")], [
              html.table([], [
                html.thead([], [
                  html.tr([], [
                    html.th([], [
                      html.label([], [
                        html.input([
                          attribute("aria-label", "Select all"),
                          attribute.type_("checkbox"),
                        ]),
                      ]),
                    ]),
                    html.th([], [html.text("Order")]),
                    html.th([], [html.text("Customer")]),
                    html.th([], [html.text("Amount")]),
                    html.th([], [html.text("Status")]),
                    html.th([], [html.text("Actions")]),
                  ]),
                ]),
                html.tbody([], [
                  html.tr([], [
                    html.td([], [
                      html.label([], [
                        html.input([
                          attribute("aria-label", "Select order"),
                          attribute.type_("checkbox"),
                        ]),
                      ]),
                    ]),
                    html.td([], [html.code([], [html.text("#ORD-7291")])]),
                    html.td([], [html.text("Alice Johnson")]),
                    html.td([], [html.text("$249.00")]),
                    html.td([], [
                      badge([badge.success()], [
                        html.text("Delivered"),
                      ]),
                    ]),
                    html.td([], [
                      button.group([], [
                        button([button.ghost(), button.small()], [
                          html.text("View"),
                        ]),
                        button([button.ghost(), button.small()], [
                          html.text("Edit"),
                        ]),
                      ]),
                    ]),
                  ]),
                  html.tr([], [
                    html.td([], [
                      html.label([], [
                        html.input([
                          attribute("aria-label", "Select order"),
                          attribute.type_("checkbox"),
                        ]),
                      ]),
                    ]),
                    html.td([], [html.code([], [html.text("#ORD-7292")])]),
                    html.td([], [html.text("Bob Chen")]),
                    html.td([], [html.text("$1,450.00")]),
                    html.td([], [
                      badge([badge.warning()], [
                        html.text("Pending"),
                      ]),
                    ]),
                    html.td([], [
                      button.group([], [
                        button([button.ghost(), button.small()], [
                          html.text("View"),
                        ]),
                        button([button.ghost(), button.small()], [
                          html.text("Edit"),
                        ]),
                      ]),
                    ]),
                  ]),
                  html.tr([], [
                    html.td([], [
                      html.label([], [
                        html.input([
                          attribute("aria-label", "Select order"),
                          attribute.type_("checkbox"),
                        ]),
                      ]),
                    ]),
                    html.td([], [html.code([], [html.text("#ORD-7293")])]),
                    html.td([], [html.text("Carol Davis")]),
                    html.td([], [html.text("$89.50")]),
                    html.td([], [
                      badge([], [
                        html.text("Processing"),
                      ]),
                    ]),
                    html.td([], [
                      button.group([], [
                        button([button.ghost(), button.small()], [
                          html.text("View"),
                        ]),
                        button([button.ghost(), button.small()], [
                          html.text("Edit"),
                        ]),
                      ]),
                    ]),
                  ]),
                  html.tr([], [
                    html.td([], [
                      html.label([], [
                        html.input([
                          attribute("aria-label", "Select order"),
                          attribute.type_("checkbox"),
                        ]),
                      ]),
                    ]),
                    html.td([], [html.code([], [html.text("#ORD-7294")])]),
                    html.td([], [html.text("David Park")]),
                    html.td([], [html.text("$672.00")]),
                    html.td([], [
                      badge([badge.outline()], [
                        html.text("Shipped"),
                      ]),
                    ]),
                    html.td([], [
                      button.group([], [
                        button([button.ghost(), button.small()], [
                          html.text("View"),
                        ]),
                        button([button.ghost(), button.small()], [
                          html.text("Edit"),
                        ]),
                      ]),
                    ]),
                  ]),
                  html.tr([], [
                    html.td([], [
                      html.label([], [
                        html.input([
                          attribute("aria-label", "Select order"),
                          attribute.type_("checkbox"),
                        ]),
                      ]),
                    ]),
                    html.td([], [html.code([], [html.text("#ORD-7295")])]),
                    html.td([], [html.text("Emma Wilson")]),
                    html.td([], [html.text("$34.99")]),
                    html.td([], [
                      badge([badge.danger()], [
                        html.text("Cancelled"),
                      ]),
                    ]),
                    html.td([], [
                      button.group([], [
                        button([button.ghost(), button.small()], [
                          html.text("View"),
                        ]),
                        button(
                          list.append(
                            [button.danger(), button.ghost(), button.small()],
                            dialog.open_for("delete-dialog"),
                          ),
                          [html.text("Delete")],
                        ),
                      ]),
                    ]),
                  ]),
                ]),
              ]),
            ]),
            html.div(
              [
                attribute("style", "justify-content: flex-end;"),
                attribute.class("hstack mt-4"),
              ],
              [
                html.small([attribute.class("text-light")], [
                  html.text("Showing 1–5 of 243"),
                ]),
                pagination([], [
                  pagination.prev(
                    [
                      attribute("aria-disabled", "true"),
                      attribute.href("#orders"),
                    ],
                    [html.text("← Prev")],
                  ),
                  pagination.page_link([attribute.href("#orders")], [
                    html.text("1"),
                  ]),
                  pagination.page_link([attribute.href("#orders")], [
                    html.text("2"),
                  ]),
                  pagination.current_page([attribute.href("#orders")], [
                    html.text("3"),
                  ]),
                  pagination.next([attribute.href("#orders")], [
                    html.text("Next →"),
                  ]),
                ]),
              ],
            ),
          ]),
          html.dialog(
            [attribute("closedby", "any"), attribute.id("delete-dialog")],
            [
              html.form([attribute.method("dialog")], [
                html.header([], [
                  html.h3([], [html.text("Confirm Deletion")]),
                  html.p([], [html.text("This action cannot be undone.")]),
                ]),
                html.div([], [
                  html.p([], [
                    html.text("Are you sure you want to delete order "),
                    html.strong([], [html.text("#ORD-7295")]),
                    html.text(
                      "? This will permanently remove it from the system.",
                    ),
                  ]),
                ]),
                html.footer([], [
                  button(
                    list.append(
                      [button.outline(), attribute.type_("button")],
                      dialog.close_for("delete-dialog"),
                    ),
                    [html.text("Cancel")],
                  ),
                  button([attribute.value("confirm"), button.danger()], [
                    html.text("Delete Order"),
                  ]),
                ]),
              ]),
            ],
          ),
        ]),
        html.section([attribute.class("section")], [
          html.div([attribute.class("row")], [
            html.div([attribute.class("col-6")], [
              card([], [
                card.header([], [
                  html.h3([], [html.text("System Notifications")]),
                ]),
                alert([attribute.class("mb-4")], [
                  alert.title([], [html.text("Info:")]),
                  alert.message([], [
                    html.text(
                      " System maintenance scheduled for Sunday 2:00 AM UTC.",
                    ),
                  ]),
                ]),
                alert([alert.success(), attribute.class("mb-4")], [
                  alert.title([], [html.text("Success:")]),
                  alert.message([], [
                    html.text(" All backups completed successfully. "),
                  ]),
                ]),
                alert([alert.warning(), attribute.class("mb-4")], [
                  alert.title([], [html.text("Warning:")]),
                  alert.message([], [
                    html.text(" SSL certificate expires in 7 days. "),
                  ]),
                ]),
                alert([alert.error(), attribute.class("mb-4")], [
                  alert.title([], [html.text("Error:")]),
                  alert.message([], [
                    html.text(
                      " Payment gateway timeout — 3 transactions affected. ",
                    ),
                  ]),
                ]),
                html.hr([]),
                html.h4([], [html.text("Toast Notifications")]),
                html.div([attribute.class("hstack mt-4")], [
                  button(
                    [
                      button.small(),
                      attribute(
                        "onclick",
                        "ot.toast('Deployment completed.', 'Success', { variant: 'success' })",
                      ),
                    ],
                    [html.text("Success toast")],
                  ),
                  button(
                    [
                      button.small(),
                      button.outline(),
                      attribute(
                        "onclick",
                        "ot.toast('Disk usage at 89%.', 'Warning', { variant: 'warning', placement: 'top-left' })",
                      ),
                    ],
                    [html.text("Warning toast")],
                  ),
                  button(
                    [
                      button.small(),
                      button.danger(),
                      attribute(
                        "onclick",
                        "ot.toast('Connection lost.', 'Error', { variant: 'danger', placement: 'bottom-right' })",
                      ),
                    ],
                    [html.text("Error toast")],
                  ),
                  button(
                    [
                      button.small(),
                      button.secondary(),
                      attribute(
                        "onclick",
                        "ot.toast('Build #1847 started.', 'Info')",
                      ),
                    ],
                    [html.text("Info toast")],
                  ),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-6")], [
              card([], [
                card.header([], [html.h3([], [html.text("FAQ")])]),
                accordion(html.div, [], [
                  accordion.group("faq", [
                    accordion.item(
                      label: html.text("How do I reset my password?"),
                      content: [
                        html.p([], [
                          html.text("Navigate to "),
                          html.strong([], [html.text("Settings → Security")]),
                          html.text(" and click "),
                          html.em([], [html.text("\"Reset password\"")]),
                          html.text(
                            ". You'll receive a confirmation email with a link.",
                          ),
                        ]),
                        html.blockquote([], [
                          html.text("Note: Password reset links expire after "),
                          html.mark([], [html.text("24 hours")]),
                          html.text("."),
                        ]),
                      ],
                    ),
                    accordion.item(
                      label: html.text("What export formats are supported?"),
                      content: [
                        html.p([], [
                          html.text("Navigate to "),
                          html.strong([], [html.text("Settings → Security")]),
                          html.text(" and click "),
                          html.em([], [html.text("\"Reset password\"")]),
                          html.text(
                            ". You'll receive a confirmation email with a link.",
                          ),
                        ]),
                        html.blockquote([], [
                          html.text("Note: Password reset links expire after "),
                          html.mark([], [html.text("24 hours")]),
                          html.text("."),
                        ]),
                      ],
                    ),
                    accordion.item(
                      label: html.text("How is billing calculated?"),
                      content: [
                        html.p([], [
                          html.text("Billing is based on "),
                          html.strong([], [html.text("active users")]),
                          html.text(" per month:"),
                        ]),
                        html.ol([], [
                          html.li([], [
                            html.text("Base plan includes up to "),
                            html.mark([], [html.text("50 users")]),
                          ]),
                          html.li([], [
                            html.text("Each additional user is "),
                            html.code([], [html.text("$2/month")]),
                          ]),
                          html.li([], [
                            html.text("Enterprise pricing available on request"),
                          ]),
                        ]),
                      ],
                    ),
                    accordion.item(
                      label: html.text(
                        "Can I integrate with third-party services?",
                      ),
                      content: [
                        html.p([], [
                          html.text("Yes! We offer integrations via our "),
                          html.strong([], [html.text("REST API")]),
                          html.text(" and "),
                          html.em([], [html.text("webhooks")]),
                          html.text(". See the "),
                          html.a([attribute.href("#")], [
                            html.text("API documentation"),
                          ]),
                          html.text(" for details."),
                        ]),
                        html.pre([], [
                          html.code([], [
                            html.text(
                              "curl -X POST https://api.example.com/webhooks \\
                              -H \"Authorization: Bearer TOKEN\"",
                            ),
                          ]),
                        ]),
                      ],
                    ),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          card([], [
            card.header([], [
              html.h3([], [html.text("Account Settings")]),
              html.p([attribute.class("text-light")], [
                html.text("Manage your profile and preferences."),
              ]),
            ]),
            form(
              [
                attribute(
                  "onsubmit",
                  "event.preventDefault(); ot.toast('Settings saved!', 'Success', { variant: 'success' });",
                ),
              ],
              [
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    form.label([form.field()], [
                      html.text(" Full Name "),
                      form.input([
                        attribute.value("Jane Doe"),
                        attribute.placeholder("Jane Doe"),
                        attribute.type_("text"),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    html.div([form.field_error()], [
                      form.label([attribute.for("settings-email")], [
                        html.text("Email"),
                      ]),
                      form.input([
                        form.described_by("email-err"),
                        form.invalid(),
                        attribute.value("jane@"),
                        attribute.id("settings-email"),
                        attribute.type_("email"),
                      ]),
                      html.div(
                        [
                          attribute.role("status"),
                          form.error(),
                          attribute.id("email-err"),
                        ],
                        [html.text("Please enter a valid email address.")],
                      ),
                    ]),
                  ]),
                ]),
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    form.label([form.field()], [
                      html.text(" Password "),
                      form.input([
                        attribute.placeholder("••••••••"),
                        attribute.type_("password"),
                      ]),
                      html.small([form.hint()], [
                        html.text("Minimum 8 characters with one number."),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    html.div([form.field()], [
                      form.label([attribute.for("settings-role")], [
                        html.text("Role"),
                      ]),
                      form.select(
                        [
                          attribute("aria-label", "Select a role"),
                          attribute.id("settings-role"),
                        ],
                        [
                          form.option([], "Administrator"),
                          form.option([], "Editor"),
                          form.option([], "Viewer"),
                        ],
                      ),
                    ]),
                  ]),
                ]),
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    form.label([form.field()], [
                      html.text(" Start Date "),
                      form.input([
                        attribute.value("2025-01-15"),
                        attribute.type_("date"),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    form.label([form.field()], [
                      html.text(" Next Review "),
                      form.input([
                        attribute.value("2025-06-15T09:00"),
                        attribute.type_("datetime-local"),
                      ]),
                    ]),
                  ]),
                ]),
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    form.label([form.field()], [
                      html.text(" Avatar "),
                      form.input([
                        attribute("accept", "image/*"),
                        attribute.type_("file"),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    form.label([form.field()], [
                      html.text(" Brand Color "),
                      form.input([
                        attribute.value("#6366f1"),
                        attribute.type_("color"),
                      ]),
                    ]),
                  ]),
                ]),
                form.label([form.field()], [
                  html.text(" Notification Volume "),
                  form.input([
                    attribute.value("65"),
                    attribute.max("100"),
                    attribute.min("0"),
                    attribute.type_("range"),
                  ]),
                ]),
                form.label([form.field()], [
                  html.text(" Bio "),
                  form.textarea(
                    [
                      attribute.placeholder("Tell us about yourself…"),
                      attribute.rows(3),
                    ],
                    "This entire dashboard is built with Oat.",
                  ),
                ]),
                form.fieldset(
                  [
                    attribute("style", "max-width: 500px;"),
                    form.group(),
                  ],
                  [
                    form.legend([], [html.text("Website")]),
                    form.input([
                      attribute.value("janedoe.dev"),
                      attribute.placeholder("yoursite.com"),
                      attribute.type_("url"),
                    ]),
                    button([button.outline(), attribute.type_("button")], [
                      html.text("Verify"),
                    ]),
                  ],
                ),
                form.fieldset([attribute.class("mt-4")], [
                  form.legend([], [html.text("Email Preferences")]),
                  form.label([], [
                    form.input([
                      attribute.checked(True),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Product updates"),
                  ]),
                  form.label([], [
                    form.input([attribute.type_("checkbox")]),
                    html.text(" Marketing emails"),
                  ]),
                  form.label([], [
                    form.input([
                      attribute.checked(True),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Security alerts"),
                  ]),
                ]),
                form.fieldset([attribute.class("hstack mt-4")], [
                  form.legend([], [html.text("Theme")]),
                  form.label([], [
                    form.input([
                      attribute.value("light"),
                      attribute.name("theme"),
                      attribute.type_("radio"),
                    ]),
                    html.text(" Light"),
                  ]),
                  form.label([], [
                    form.input([
                      attribute.value("dark"),
                      attribute.name("theme"),
                      attribute.type_("radio"),
                    ]),
                    html.text(" Dark"),
                  ]),
                  form.label([], [
                    form.input([
                      attribute.checked(True),
                      attribute.value("auto"),
                      attribute.name("theme"),
                      attribute.type_("radio"),
                    ]),
                    html.text(" System"),
                  ]),
                ]),
                html.div([attribute.class("mt-4 vstack gap-2")], [
                  form.label([], [
                    form.input([
                      attribute.checked(True),
                      form.as_switch(),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Enable two-factor authentication "),
                  ]),
                  form.label([], [
                    form.input([
                      form.as_switch(),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Enable API access "),
                  ]),
                ]),
                html.footer([attribute.class("hstack mt-6")], [
                  button([attribute.type_("submit")], [
                    html.text("Save Changes"),
                  ]),
                  button([button.outline(), attribute.type_("button")], [
                    html.text("Cancel"),
                  ]),
                  button(
                    [button.danger(), button.ghost(), attribute.type_("button")],
                    [html.text("Delete Account")],
                  ),
                ]),
              ],
            ),
          ]),
        ]),
        card.instance(html.section, [], [
          html.h5([], [html.text("Loading placeholder")]),
          skeleton.line([attribute("style", "width: 100%;")]),
          skeleton.line([attribute("style", "width: 80%;")]),
          skeleton.line([attribute("style", "width: 60%;")]),
          html.div([attribute.class("hstack mt-4")], [
            skeleton.box([]),
            skeleton.box([]),
            skeleton.box([]),
          ]),
        ]),
        html.section([attribute.class("section mt-6")], [
          html.h3([], [html.text("Sidebar")]),
          sidebar.sidebar_always(card, [], [
            sidebar.topnav(
              [
                attribute.class("hstack justify-between"),
                attribute(
                  "style",
                  "padding: var(--space-3); border-bottom: 1px solid var(--border);",
                ),
              ],
              [
                sidebar.toggle([button.outline(), button.small()], [
                  html.text("☰"),
                ]),
                html.strong([], [html.text("Acme Console")]),
              ],
            ),
            sidebar.aside([attribute("style", "padding: var(--space-3);")], [
              html.nav([], [
                html.ul([attribute.class("unstyled vstack gap-2")], [
                  html.li([], [
                    html.a(
                      [
                        attribute.href("#sidebar"),
                        attribute("aria-current", "page"),
                      ],
                      [html.text("Home")],
                    ),
                  ]),
                  html.li([], [
                    html.a([attribute.href("#sidebar")], [
                      html.text("Users"),
                    ]),
                  ]),
                  html.li([], [
                    html.details([attribute.open(True)], [
                      html.summary([], [html.text("Settings")]),
                      html.ul([attribute.class("unstyled")], [
                        html.li([], [
                          html.a([attribute.href("#sidebar")], [
                            html.text("General"),
                          ]),
                        ]),
                        html.li([], [
                          html.a([attribute.href("#sidebar")], [
                            html.text("Security"),
                          ]),
                        ]),
                        html.li([], [
                          html.a([attribute.href("#sidebar")], [
                            html.text("Billing"),
                          ]),
                        ]),
                      ]),
                    ]),
                  ]),
                ]),
              ]),
              html.footer([attribute.class("mt-4")], [
                button(
                  [
                    button.outline(),
                    button.small(),
                    attribute("style", "width: 100%;"),
                  ],
                  [html.text("Logout")],
                ),
              ]),
            ]),
            html.main([attribute("style", "padding: var(--space-4);")], [
              html.p([], [
                html.text(
                  "Main content area. Scrolls with page content while the sidebar remains pinned.",
                ),
              ]),
            ]),
          ]),
        ]),
      ]),
    ]),
  ])
}

pub fn main() {
  let html =
    page()
    |> element.to_document_string
  let assert Ok(_) = simplifile.write(contents: html, to: "./oat.html")
}
