import glaze_oat
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

      glaze_oat.setup(glaze_oat.version, glaze_oat.default_theme),

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
    ]),
    html.body([attribute.class("demo")], [
      html.main([attribute.class("container")], [
        html.section([attribute.class("section")], [
          html.div([attribute.class("hstack justify-between mb-6")], [
            html.div([attribute.class("hstack")], [
              html.h2([attribute("style", "margin: 0;")], [html.text("Demo")]),
              html.span([attribute.class("badge success")], [html.text("Live")]),
              html.span([attribute.class("badge secondary")], [
                html.text("v1.0.0"),
              ]),
            ]),
            html.div([attribute.class("hstack")], [
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
              element("ot-dropdown", [], [
                html.button(
                  [
                    attribute.class("outline small"),
                    attribute("popovertarget", "export-menu"),
                  ],
                  [html.text(" Export ▾ ")],
                ),
                html.menu(
                  [attribute.id("export-menu"), attribute("popover", "")],
                  [
                    html.button([attribute.role("menuitem")], [
                      html.text("Export as CSV"),
                    ]),
                    html.button([attribute.role("menuitem")], [
                      html.text("Export as JSON"),
                    ]),
                    html.hr([]),
                    html.button([attribute.role("menuitem")], [
                      html.text("Print report"),
                    ]),
                  ],
                ),
              ]),
              html.button(
                [
                  attribute("data-tooltip", "Refresh data now"),
                  attribute.class("small"),
                ],
                [html.text(" ↻ Refresh ")],
              ),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          html.div([attribute.class("row")], [
            html.div([attribute.class("col-3")], [
              html.article([attribute.class("card")], [
                html.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Revenue"),
                  ]),
                  html.div([attribute.class("stat-value")], [
                    html.text("$42,128"),
                  ]),
                  html.small([attribute.class("text-light")], [
                    html.span([attribute.class("badge success")], [
                      html.text("+12.5%"),
                    ]),
                    html.text(" vs last month"),
                  ]),
                ]),
                html.footer([], [
                  html.progress(
                    [attribute.max("100"), attribute.value("72")],
                    [],
                  ),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-3")], [
              html.article([attribute.class("card")], [
                html.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Active Users"),
                  ]),
                  html.div([attribute.class("stat-value")], [html.text("2,847")]),
                  html.small([attribute.class("text-light")], [
                    html.span([attribute.class("badge warning")], [
                      html.text("-3.2%"),
                    ]),
                    html.text(" vs last month"),
                  ]),
                ]),
                html.footer([], [
                  html.progress(
                    [attribute.max("100"), attribute.value("58")],
                    [],
                  ),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-3")], [
              html.article([attribute.class("card")], [
                html.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Retention"),
                  ]),
                  html.div([attribute.class("stat-value")], [html.text("3.24%")]),
                  html.small([attribute.class("text-light")], [
                    html.span([attribute.class("badge success")], [
                      html.text("+0.8%"),
                    ]),
                    html.text(" vs last month"),
                  ]),
                ]),
                html.footer([], [
                  html.meter(
                    [
                      attribute("optimum", "1"),
                      attribute("high", "0.7"),
                      attribute("low", "0.3"),
                      attribute.max("1"),
                      attribute.min("0"),
                      attribute.value("0.65"),
                    ],
                    [],
                  ),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-3")], [
              html.article([attribute.class("card")], [
                html.header([], [
                  html.small([attribute.class("text-light")], [
                    html.text("Uptime"),
                  ]),
                  html.div([attribute.class("stat-value")], [
                    html.text("99.99%"),
                  ]),
                  html.small([attribute.class("text-light")], [
                    html.span([attribute.class("badge")], [html.text("Healthy")]),
                  ]),
                ]),
                html.footer([], [
                  html.meter(
                    [
                      attribute("optimum", "1"),
                      attribute("high", "0.99"),
                      attribute("low", "0.95"),
                      attribute.max("1"),
                      attribute.min("0"),
                      attribute.value("0.9998"),
                    ],
                    [],
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          html.article([attribute.class("card")], [
            element("ot-tabs", [], [
              html.div([attribute.role("tablist")], [
                html.button([attribute.role("tab")], [html.text("Overview")]),
                html.button([attribute.role("tab")], [html.text("Performance")]),
                html.button([attribute.role("tab")], [html.text("Reports")]),
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
                    attribute("data-spinner", "large overlay"),
                    attribute("aria-busy", "true"),
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
                        html.progress(
                          [attribute.max("100"), attribute.value("14")],
                          [],
                        ),
                      ]),
                      html.div([attribute.class("col-6")], [
                        html.strong([], [html.text("Error Rate")]),
                        html.p([], [html.text("0.03%")]),
                        html.progress(
                          [attribute.max("100"), attribute.value("3")],
                          [],
                        ),
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
                          html.span([attribute.class("badge success")], [
                            html.text("+8%"),
                          ]),
                        ]),
                      ]),
                      html.tr([], [
                        html.td([], [html.text("Bounce rate")]),
                        html.td([], [html.text("42.3%")]),
                        html.td([], [
                          html.span([attribute.class("badge danger")], [
                            html.text("+2.1%"),
                          ]),
                        ]),
                      ]),
                      html.tr([], [
                        html.td([], [html.text("Avg session")]),
                        html.td([], [html.text("4m 12s")]),
                        html.td([], [
                          html.span([attribute.class("badge success")], [
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
              html.article([attribute.class("card")], [
                html.header([], [html.h3([], [html.text("Recent Activity")])]),
                html.div([attribute.class("vstack gap-4")], [
                  html.div([attribute.class("activity-item")], [
                    html.div([attribute.class("hstack")], [
                      html.span([attribute.class("badge success")], [
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
                      html.span([attribute.class("badge warning")], [
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
                      html.span([attribute.class("badge")], [html.text("Merge")]),
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
                      html.span([attribute.class("badge danger")], [
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
                      html.span([attribute.class("badge secondary")], [
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
              html.article([attribute.class("card")], [
                html.header([], [
                  html.h3([], [html.text("Server Status")]),
                  html.small([attribute.class("text-light hstack gap-2")], [
                    html.span(
                      [
                        attribute("data-spinner", "small"),
                        attribute("aria-busy", "true"),
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
                      html.span([attribute.class("badge success")], [
                        html.text("Normal"),
                      ]),
                    ]),
                    html.progress(
                      [attribute.max("100"), attribute.value("42")],
                      [],
                    ),
                    html.small([attribute.class("text-lighter")], [
                      html.text("42% — 8 cores"),
                    ]),
                  ]),
                  html.div([], [
                    html.div([attribute.class("hstack justify-between")], [
                      html.strong([], [html.text("Memory")]),
                      html.span([attribute.class("badge warning")], [
                        html.text("High"),
                      ]),
                    ]),
                    html.progress(
                      [attribute.max("100"), attribute.value("78")],
                      [],
                    ),
                    html.small([attribute.class("text-lighter")], [
                      html.text("12.5 / 16 GB used"),
                    ]),
                  ]),
                  html.div([], [
                    html.div([attribute.class("hstack justify-between")], [
                      html.strong([], [html.text("Disk I/O")]),
                      html.span([attribute.class("badge success")], [
                        html.text("Normal"),
                      ]),
                    ]),
                    html.meter(
                      [
                        attribute("optimum", "0"),
                        attribute("high", "0.7"),
                        attribute("low", "0.3"),
                        attribute.max("1"),
                        attribute.min("0"),
                        attribute.value("0.35"),
                      ],
                      [],
                    ),
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
                        html.progress(
                          [
                            attribute.max("100"),
                            attribute.value("60"),
                          ],
                          [],
                        ),
                      ]),
                      html.div([attribute.class("col-6")], [
                        html.strong([], [html.text("Network Out")]),
                        html.p([attribute("style", "margin:0;")], [
                          html.text("840 Mbps"),
                        ]),
                        html.progress(
                          [
                            attribute.max("100"),
                            attribute.value("42"),
                          ],
                          [],
                        ),
                      ]),
                    ]),
                  ]),
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          html.article([attribute.class("card")], [
            html.header([], [html.h3([], [html.text("Recent Orders")])]),
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
                  html.button([attribute.class("outline")], [
                    html.text("Search"),
                  ]),
                ],
              ),
              html.menu([attribute.class("buttons")], [
                html.li([], [
                  html.button([attribute.class("ghost small")], [
                    html.text("All"),
                  ]),
                ]),
                html.li([], [
                  html.button([attribute.class("outline small")], [
                    html.text("Pending"),
                  ]),
                ]),
                html.li([], [
                  html.button([attribute.class("outline small")], [
                    html.text("Shipped"),
                  ]),
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
                      html.span([attribute.class("badge success")], [
                        html.text("Delivered"),
                      ]),
                    ]),
                    html.td([], [
                      html.menu([attribute.class("buttons")], [
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("View"),
                          ]),
                        ]),
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("Edit"),
                          ]),
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
                      html.span([attribute.class("badge warning")], [
                        html.text("Pending"),
                      ]),
                    ]),
                    html.td([], [
                      html.menu([attribute.class("buttons")], [
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("View"),
                          ]),
                        ]),
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("Edit"),
                          ]),
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
                      html.span([attribute.class("badge")], [
                        html.text("Processing"),
                      ]),
                    ]),
                    html.td([], [
                      html.menu([attribute.class("buttons")], [
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("View"),
                          ]),
                        ]),
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("Edit"),
                          ]),
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
                      html.span([attribute.class("badge outline")], [
                        html.text("Shipped"),
                      ]),
                    ]),
                    html.td([], [
                      html.menu([attribute.class("buttons")], [
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("View"),
                          ]),
                        ]),
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("Edit"),
                          ]),
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
                      html.span([attribute.class("badge danger")], [
                        html.text("Cancelled"),
                      ]),
                    ]),
                    html.td([], [
                      html.menu([attribute.class("buttons")], [
                        html.li([], [
                          html.button([attribute.class("ghost small")], [
                            html.text("View"),
                          ]),
                        ]),
                        html.li([], [
                          html.button(
                            [
                              attribute("data-variant", "danger"),
                              attribute("command", "show-modal"),
                              attribute("commandfor", "delete-dialog"),
                              attribute.class("ghost small"),
                            ],
                            [html.text("Delete")],
                          ),
                        ]),
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
                html.menu([attribute.class("buttons")], [
                  html.li([], [
                    html.button(
                      [
                        attribute.disabled(True),
                        attribute.class("outline small"),
                      ],
                      [html.text("← Prev")],
                    ),
                  ]),
                  html.li([], [
                    html.button([attribute.class("outline small")], [
                      html.text("1"),
                    ]),
                  ]),
                  html.li([], [
                    html.button([attribute.class("outline small")], [
                      html.text("2"),
                    ]),
                  ]),
                  html.li([], [
                    html.button([attribute.class("outline small")], [
                      html.text("3"),
                    ]),
                  ]),
                  html.li([], [
                    html.button([attribute.class("outline small")], [
                      html.text("Next →"),
                    ]),
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
                  html.button(
                    [
                      attribute.class("outline"),
                      attribute("command", "close"),
                      attribute("commandfor", "delete-dialog"),
                      attribute.type_("button"),
                    ],
                    [html.text("Cancel")],
                  ),
                  html.button(
                    [
                      attribute.value("confirm"),
                      attribute("data-variant", "danger"),
                    ],
                    [html.text("Delete Order")],
                  ),
                ]),
              ]),
            ],
          ),
        ]),
        html.section([attribute.class("section")], [
          html.div([attribute.class("row")], [
            html.div([attribute.class("col-6")], [
              html.article([attribute.class("card")], [
                html.header([], [
                  html.h3([], [html.text("System Notifications")]),
                ]),
                html.div([attribute.class("mb-4"), attribute.role("alert")], [
                  html.strong([], [html.text("Info:")]),
                  html.text(
                    " System maintenance scheduled for Sunday 2:00 AM UTC. ",
                  ),
                ]),
                html.div(
                  [
                    attribute.class("mb-4"),
                    attribute("data-variant", "success"),
                    attribute.role("alert"),
                  ],
                  [
                    html.strong([], [html.text("Success:")]),
                    html.text(" All backups completed successfully. "),
                  ],
                ),
                html.div(
                  [
                    attribute.class("mb-4"),
                    attribute("data-variant", "warning"),
                    attribute.role("alert"),
                  ],
                  [
                    html.strong([], [html.text("Warning:")]),
                    html.text(" SSL certificate expires in 7 days. "),
                  ],
                ),
                html.div(
                  [
                    attribute.class("mb-4"),
                    attribute("data-variant", "error"),
                    attribute.role("alert"),
                  ],
                  [
                    html.strong([], [html.text("Error:")]),
                    html.text(
                      " Payment gateway timeout — 3 transactions affected. ",
                    ),
                  ],
                ),
                html.hr([]),
                html.h4([], [html.text("Toast Notifications")]),
                html.div([attribute.class("hstack mt-4")], [
                  html.button(
                    [
                      attribute(
                        "onclick",
                        "ot.toast('Deployment completed.', 'Success', { variant: 'success' })",
                      ),
                      attribute.class("small"),
                    ],
                    [html.text("Success toast")],
                  ),
                  html.button(
                    [
                      attribute(
                        "onclick",
                        "ot.toast('Disk usage at 89%.', 'Warning', { variant: 'warning', placement: 'top-left' })",
                      ),
                      attribute.class("small outline"),
                    ],
                    [html.text("Warning toast")],
                  ),
                  html.button(
                    [
                      attribute(
                        "onclick",
                        "ot.toast('Connection lost.', 'Error', { variant: 'danger', placement: 'bottom-right' })",
                      ),
                      attribute("data-variant", "danger"),
                      attribute.class("small"),
                    ],
                    [html.text("Error toast")],
                  ),
                  html.button(
                    [
                      attribute(
                        "onclick",
                        "ot.toast('Build #1847 started.', 'Info')",
                      ),
                      attribute("data-variant", "secondary"),
                      attribute.class("small"),
                    ],
                    [html.text("Info toast")],
                  ),
                ]),
              ]),
            ]),
            html.div([attribute.class("col-6")], [
              html.article([attribute.class("card")], [
                html.header([], [html.h3([], [html.text("FAQ")])]),
                html.details([attribute.name("faq")], [
                  html.summary([], [html.text("How do I reset my password?")]),
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
                ]),
                html.details([attribute.name("faq")], [
                  html.summary([], [
                    html.text("What export formats are supported?"),
                  ]),
                  html.p([], [html.text("We support the following formats:")]),
                  html.ul([], [
                    html.li([], [
                      html.code([], [html.text("CSV")]),
                      html.text(" — Comma-separated values"),
                    ]),
                    html.li([], [
                      html.code([], [html.text("JSON")]),
                      html.text(" — JavaScript Object Notation"),
                    ]),
                    html.li([], [
                      html.code([], [html.text("XLSX")]),
                      html.text(" — Microsoft Excel"),
                    ]),
                  ]),
                ]),
                html.details([attribute.name("faq")], [
                  html.summary([], [html.text("How is billing calculated?")]),
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
                ]),
                html.details([attribute.name("faq")], [
                  html.summary([], [
                    html.text("Can I integrate with third-party services?"),
                  ]),
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
                ]),
              ]),
            ]),
          ]),
        ]),
        html.section([attribute.class("section")], [
          html.article([attribute.class("card")], [
            html.header([], [
              html.h3([], [html.text("Account Settings")]),
              html.p([attribute.class("text-light")], [
                html.text("Manage your profile and preferences."),
              ]),
            ]),
            html.form(
              [
                attribute(
                  "onsubmit",
                  "event.preventDefault(); ot.toast('Settings saved!', 'Success', { variant: 'success' });",
                ),
              ],
              [
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    html.label([attribute("data-field", "")], [
                      html.text(" Full Name "),
                      html.input([
                        attribute.value("Jane Doe"),
                        attribute.placeholder("Jane Doe"),
                        attribute.type_("text"),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    html.div([attribute("data-field", "error")], [
                      html.label([attribute.for("settings-email")], [
                        html.text("Email"),
                      ]),
                      html.input([
                        attribute("aria-describedby", "email-err"),
                        attribute("aria-invalid", "true"),
                        attribute.value("jane@"),
                        attribute.id("settings-email"),
                        attribute.type_("email"),
                      ]),
                      html.div(
                        [
                          attribute.role("status"),
                          attribute.class("error"),
                          attribute.id("email-err"),
                        ],
                        [html.text("Please enter a valid email address.")],
                      ),
                    ]),
                  ]),
                ]),
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    html.label([attribute("data-field", "")], [
                      html.text(" Password "),
                      html.input([
                        attribute.placeholder("••••••••"),
                        attribute.type_("password"),
                      ]),
                      html.small([attribute("data-hint", "")], [
                        html.text("Minimum 8 characters with one number."),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    html.div([attribute("data-field", "")], [
                      html.label([attribute.for("settings-role")], [
                        html.text("Role"),
                      ]),
                      html.select(
                        [
                          attribute("aria-label", "Select a role"),
                          attribute.id("settings-role"),
                        ],
                        [
                          html.option([], "Administrator"),
                          html.option([], "Editor"),
                          html.option([], "Viewer"),
                        ],
                      ),
                    ]),
                  ]),
                ]),
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    html.label([attribute("data-field", "")], [
                      html.text(" Start Date "),
                      html.input([
                        attribute.value("2025-01-15"),
                        attribute.type_("date"),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    html.label([attribute("data-field", "")], [
                      html.text(" Next Review "),
                      html.input([
                        attribute.value("2025-06-15T09:00"),
                        attribute.type_("datetime-local"),
                      ]),
                    ]),
                  ]),
                ]),
                html.div([attribute.class("row")], [
                  html.div([attribute.class("col-6")], [
                    html.label([attribute("data-field", "")], [
                      html.text(" Avatar "),
                      html.input([
                        attribute("accept", "image/*"),
                        attribute.type_("file"),
                      ]),
                    ]),
                  ]),
                  html.div([attribute.class("col-6")], [
                    html.label([attribute("data-field", "")], [
                      html.text(" Brand Color "),
                      html.input([
                        attribute.value("#6366f1"),
                        attribute.type_("color"),
                      ]),
                    ]),
                  ]),
                ]),
                html.label([attribute("data-field", "")], [
                  html.text(" Notification Volume "),
                  html.input([
                    attribute.value("65"),
                    attribute.max("100"),
                    attribute.min("0"),
                    attribute.type_("range"),
                  ]),
                ]),
                html.label([attribute("data-field", "")], [
                  html.text(" Bio "),
                  html.textarea(
                    [
                      attribute.placeholder("Tell us about yourself…"),
                      attribute.rows(3),
                    ],
                    "This entire dashboard is built with Oat.",
                  ),
                ]),
                html.fieldset(
                  [
                    attribute("style", "max-width: 500px;"),
                    attribute.class("group"),
                  ],
                  [
                    html.legend([], [html.text("Website")]),
                    html.input([
                      attribute.value("janedoe.dev"),
                      attribute.placeholder("yoursite.com"),
                      attribute.type_("url"),
                    ]),
                    html.button(
                      [attribute.class("outline"), attribute.type_("button")],
                      [html.text("Verify")],
                    ),
                  ],
                ),
                html.fieldset([attribute.class("mt-4")], [
                  html.legend([], [html.text("Email Preferences")]),
                  html.label([], [
                    html.input([
                      attribute.checked(True),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Product updates"),
                  ]),
                  html.label([], [
                    html.input([attribute.type_("checkbox")]),
                    html.text(" Marketing emails"),
                  ]),
                  html.label([], [
                    html.input([
                      attribute.checked(True),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Security alerts"),
                  ]),
                ]),
                html.fieldset([attribute.class("hstack mt-4")], [
                  html.legend([], [html.text("Theme")]),
                  html.label([], [
                    html.input([
                      attribute.value("light"),
                      attribute.name("theme"),
                      attribute.type_("radio"),
                    ]),
                    html.text(" Light"),
                  ]),
                  html.label([], [
                    html.input([
                      attribute.value("dark"),
                      attribute.name("theme"),
                      attribute.type_("radio"),
                    ]),
                    html.text(" Dark"),
                  ]),
                  html.label([], [
                    html.input([
                      attribute.checked(True),
                      attribute.value("auto"),
                      attribute.name("theme"),
                      attribute.type_("radio"),
                    ]),
                    html.text(" System"),
                  ]),
                ]),
                html.div([attribute.class("mt-4 vstack gap-2")], [
                  html.label([], [
                    html.input([
                      attribute.checked(True),
                      attribute.role("switch"),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Enable two-factor authentication "),
                  ]),
                  html.label([], [
                    html.input([
                      attribute.role("switch"),
                      attribute.type_("checkbox"),
                    ]),
                    html.text(" Enable API access "),
                  ]),
                ]),
                html.footer([attribute.class("hstack mt-6")], [
                  html.button([attribute.type_("submit")], [
                    html.text("Save Changes"),
                  ]),
                  html.button(
                    [attribute.class("outline"), attribute.type_("button")],
                    [html.text("Cancel")],
                  ),
                  html.button(
                    [
                      attribute("data-variant", "danger"),
                      attribute.class("ghost"),
                      attribute.type_("button"),
                    ],
                    [html.text("Delete Account")],
                  ),
                ]),
              ],
            ),
          ]),
        ]),
        html.section([attribute.class("card")], [
          html.h5([], [html.text("Loading placeholder")]),
          html.div(
            [
              attribute("style", "width: 100%;"),
              attribute.class("skeleton line"),
              attribute.role("status"),
            ],
            [],
          ),
          html.div(
            [
              attribute("style", "width: 80%;"),
              attribute.class("skeleton line"),
              attribute.role("status"),
            ],
            [],
          ),
          html.div(
            [
              attribute("style", "width: 60%;"),
              attribute.class("skeleton line"),
              attribute.role("status"),
            ],
            [],
          ),
          html.div([attribute.class("hstack mt-4")], [
            html.div(
              [attribute.class("skeleton box"), attribute.role("status")],
              [],
            ),
            html.div(
              [attribute.class("skeleton box"), attribute.role("status")],
              [],
            ),
            html.div(
              [attribute.class("skeleton box"), attribute.role("status")],
              [],
            ),
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
