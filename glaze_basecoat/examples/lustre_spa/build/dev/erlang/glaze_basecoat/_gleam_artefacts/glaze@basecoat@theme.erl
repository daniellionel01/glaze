-module(glaze@basecoat@theme).
-compile([no_auto_import, nowarn_unused_vars, nowarn_unused_function, nowarn_nomatch, inline]).
-define(FILEPATH, "src/glaze/basecoat/theme.gleam").
-export([from_list/1, default_theme/0, dark_theme/0, to_list/1, get/2, set/3, set_many/2, tailwind_v4_bridge_css/0, tailwind_v4_bridge_style_tag/0, style_tag/1, style_tag_light_dark/2]).
-export_type([token/0, theme/0]).

-if(?OTP_RELEASE >= 27).
-define(MODULEDOC(Str), -moduledoc(Str)).
-define(DOC(Str), -doc(Str)).
-else.
-define(MODULEDOC(Str), -compile([])).
-define(DOC(Str), -compile([])).
-endif.

?MODULEDOC(
    " Theme tokens and \\<style\\> generation for Basecoat UI.\n"
    "\n"
    " Basecoat uses shadcn/ui compatible CSS variables for theming.\n"
    " This module provides typed tokens and helpers to generate theme styles.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " import glaze/basecoat\n"
    " import glaze/basecoat/theme\n"
    "\n"
    " let my_theme =\n"
    "   theme.default_theme()\n"
    "   |> theme.set(theme.Primary, \"oklch(0.205 0 0)\")\n"
    "   |> theme.set(theme.Radius, \"0.5rem\")\n"
    "\n"
    " html.head([], [\n"
    "   basecoat.register(basecoat.version),\n"
    "   theme.style_tag(my_theme),\n"
    " ])\n"
    " ```\n"
    "\n"
    " ## Theming\n"
    "\n"
    " You can use any shadcn/ui theme. Visit [ui.shadcn.com/themes](https://ui.shadcn.com/themes)\n"
    " to browse available themes and copy their CSS variables.\n"
    "\n"
).

-type token() :: background |
    foreground |
    card |
    card_foreground |
    popover |
    popover_foreground |
    primary |
    primary_foreground |
    secondary |
    secondary_foreground |
    muted |
    muted_foreground |
    accent |
    accent_foreground |
    destructive |
    destructive_foreground |
    border |
    input |
    ring |
    radius |
    chart1 |
    chart2 |
    chart3 |
    chart4 |
    chart5 |
    sidebar |
    sidebar_foreground |
    sidebar_primary |
    sidebar_primary_foreground |
    sidebar_accent |
    sidebar_accent_foreground |
    sidebar_border |
    sidebar_ring.

-opaque theme() :: {theme, gleam@dict:dict(token(), binary())}.

-file("src/glaze/basecoat/theme.gleam", 183).
?DOC(
    " Construct a `Theme` from a list of token-value pairs.\n"
    "\n"
    " If the same token appears multiple times, the last value overrides previous ones.\n"
    "\n"
    " ### Example\n"
    "\n"
    " ```gleam\n"
    " let t = theme.from_list([\n"
    "   #(theme.Primary, \"oklch(0.205 0 0)\"),\n"
    "   #(theme.PrimaryForeground, \"oklch(0.985 0 0)\"),\n"
    " ])\n"
    " ```\n"
).
-spec from_list(list({token(), binary()})) -> theme().
from_list(Tokens) ->
    Values = gleam@list:fold(
        Tokens,
        maps:new(),
        fun(Acc, Cur) ->
            {Token, Value} = Cur,
            gleam@dict:insert(Acc, Token, Value)
        end
    ),
    {theme, Values}.

-file("src/glaze/basecoat/theme.gleam", 88).
?DOC(
    " Returns Basecoat's default theme (shadcn/ui default theme).\n"
    "\n"
    " This includes the default color palette and border radius.\n"
    " Start with this and customize as needed.\n"
).
-spec default_theme() -> theme().
default_theme() ->
    _pipe = [{background, <<"oklch(1 0 0)"/utf8>>},
        {foreground, <<"oklch(0.145 0 0)"/utf8>>},
        {card, <<"oklch(1 0 0)"/utf8>>},
        {card_foreground, <<"oklch(0.145 0 0)"/utf8>>},
        {popover, <<"oklch(1 0 0)"/utf8>>},
        {popover_foreground, <<"oklch(0.145 0 0)"/utf8>>},
        {primary, <<"oklch(0.205 0 0)"/utf8>>},
        {primary_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {secondary, <<"oklch(0.97 0 0)"/utf8>>},
        {secondary_foreground, <<"oklch(0.205 0 0)"/utf8>>},
        {muted, <<"oklch(0.97 0 0)"/utf8>>},
        {muted_foreground, <<"oklch(0.556 0 0)"/utf8>>},
        {accent, <<"oklch(0.97 0 0)"/utf8>>},
        {accent_foreground, <<"oklch(0.205 0 0)"/utf8>>},
        {destructive, <<"oklch(0.577 0.245 27.325)"/utf8>>},
        {destructive_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {border, <<"oklch(0.922 0 0)"/utf8>>},
        {input, <<"oklch(0.922 0 0)"/utf8>>},
        {ring, <<"oklch(0.708 0 0)"/utf8>>},
        {radius, <<"0.5rem"/utf8>>},
        {chart1, <<"oklch(0.646 0.222 41.116)"/utf8>>},
        {chart2, <<"oklch(0.6 0.118 184.704)"/utf8>>},
        {chart3, <<"oklch(0.398 0.07 227.392)"/utf8>>},
        {chart4, <<"oklch(0.828 0.189 84.429)"/utf8>>},
        {chart5, <<"oklch(0.769 0.188 70.08)"/utf8>>},
        {sidebar, <<"oklch(0.985 0 0)"/utf8>>},
        {sidebar_foreground, <<"oklch(0.145 0 0)"/utf8>>},
        {sidebar_primary, <<"oklch(0.205 0 0)"/utf8>>},
        {sidebar_primary_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {sidebar_accent, <<"oklch(0.97 0 0)"/utf8>>},
        {sidebar_accent_foreground, <<"oklch(0.205 0 0)"/utf8>>},
        {sidebar_border, <<"oklch(0.922 0 0)"/utf8>>},
        {sidebar_ring, <<"oklch(0.708 0 0)"/utf8>>}],
    from_list(_pipe).

-file("src/glaze/basecoat/theme.gleam", 131).
?DOC(
    " Returns the dark theme variant.\n"
    "\n"
    " Use this for dark mode or combine with `default_theme()` using `light-dark()`.\n"
).
-spec dark_theme() -> theme().
dark_theme() ->
    _pipe = [{background, <<"oklch(0.145 0 0)"/utf8>>},
        {foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {card, <<"oklch(0.205 0 0)"/utf8>>},
        {card_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {popover, <<"oklch(0.269 0 0)"/utf8>>},
        {popover_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {primary, <<"oklch(0.922 0 0)"/utf8>>},
        {primary_foreground, <<"oklch(0.205 0 0)"/utf8>>},
        {secondary, <<"oklch(0.269 0 0)"/utf8>>},
        {secondary_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {muted, <<"oklch(0.269 0 0)"/utf8>>},
        {muted_foreground, <<"oklch(0.708 0 0)"/utf8>>},
        {accent, <<"oklch(0.371 0 0)"/utf8>>},
        {accent_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {destructive, <<"oklch(0.704 0.191 22.216)"/utf8>>},
        {destructive_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {border, <<"oklch(1 0 0 / 10%)"/utf8>>},
        {input, <<"oklch(1 0 0 / 15%)"/utf8>>},
        {ring, <<"oklch(0.556 0 0)"/utf8>>},
        {radius, <<"0.5rem"/utf8>>},
        {chart1, <<"oklch(0.488 0.243 264.376)"/utf8>>},
        {chart2, <<"oklch(0.696 0.17 162.48)"/utf8>>},
        {chart3, <<"oklch(0.769 0.188 70.08)"/utf8>>},
        {chart4, <<"oklch(0.627 0.265 303.9)"/utf8>>},
        {chart5, <<"oklch(0.645 0.246 16.439)"/utf8>>},
        {sidebar, <<"oklch(0.205 0 0)"/utf8>>},
        {sidebar_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {sidebar_primary, <<"oklch(0.488 0.243 264.376)"/utf8>>},
        {sidebar_primary_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {sidebar_accent, <<"oklch(0.269 0 0)"/utf8>>},
        {sidebar_accent_foreground, <<"oklch(0.985 0 0)"/utf8>>},
        {sidebar_border, <<"oklch(1 0 0 / 10%)"/utf8>>},
        {sidebar_ring, <<"oklch(0.439 0 0)"/utf8>>}],
    from_list(_pipe).

-file("src/glaze/basecoat/theme.gleam", 194).
?DOC(" Convert a `Theme` into token-value pairs.\n").
-spec to_list(theme()) -> list({token(), binary()}).
to_list(Theme) ->
    {theme, Values} = Theme,
    maps:to_list(Values).

-file("src/glaze/basecoat/theme.gleam", 201).
?DOC(" Get a token value from a theme.\n").
-spec get(theme(), token()) -> binary().
get(Theme, Token) ->
    {theme, Values} = Theme,
    case gleam_stdlib:map_get(Values, Token) of
        {ok, Value} ->
            Value;

        {error, _} ->
            <<""/utf8>>
    end.

-file("src/glaze/basecoat/theme.gleam", 211).
?DOC(" Set a token value in a theme.\n").
-spec set(theme(), token(), binary()) -> theme().
set(Theme, Token, Value) ->
    {theme, Values} = Theme,
    {theme, gleam@dict:insert(Values, Token, Value)}.

-file("src/glaze/basecoat/theme.gleam", 218).
?DOC(" Set multiple token values in a theme.\n").
-spec set_many(theme(), list({token(), binary()})) -> theme().
set_many(Theme, Updates) ->
    gleam@list:fold(
        Updates,
        Theme,
        fun(Acc, Cur) ->
            {Token, Value} = Cur,
            set(Acc, Token, Value)
        end
    ).

-file("src/glaze/basecoat/theme.gleam", 267).
?DOC(
    " The Tailwind v4 `@theme` mapping used by Basecoat.\n"
    "\n"
    " This matches the `@theme` block in Basecoat's `src/css/basecoat.css`.\n"
).
-spec tailwind_v4_bridge_css() -> binary().
tailwind_v4_bridge_css() ->
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"@theme {\n"/utf8,
                                                                                                                                    "  --color-background: var(--background);\n"/utf8>>/binary,
                                                                                                                                "  --color-foreground: var(--foreground);\n"/utf8>>/binary,
                                                                                                                            "  --color-card: var(--card);\n"/utf8>>/binary,
                                                                                                                        "  --color-card-foreground: var(--card-foreground);\n"/utf8>>/binary,
                                                                                                                    "  --color-popover: var(--popover);\n"/utf8>>/binary,
                                                                                                                "  --color-popover-foreground: var(--popover-foreground);\n"/utf8>>/binary,
                                                                                                            "  --color-primary: var(--primary);\n"/utf8>>/binary,
                                                                                                        "  --color-primary-foreground: var(--primary-foreground);\n"/utf8>>/binary,
                                                                                                    "  --color-secondary: var(--secondary);\n"/utf8>>/binary,
                                                                                                "  --color-secondary-foreground: var(--secondary-foreground);\n"/utf8>>/binary,
                                                                                            "  --color-muted: var(--muted);\n"/utf8>>/binary,
                                                                                        "  --color-muted-foreground: var(--muted-foreground);\n"/utf8>>/binary,
                                                                                    "  --color-accent: var(--accent);\n"/utf8>>/binary,
                                                                                "  --color-accent-foreground: var(--accent-foreground);\n"/utf8>>/binary,
                                                                            "  --color-destructive: var(--destructive);\n"/utf8>>/binary,
                                                                        "  --color-border: var(--border);\n"/utf8>>/binary,
                                                                    "  --color-input: var(--input);\n"/utf8>>/binary,
                                                                "  --color-ring: var(--ring);\n"/utf8>>/binary,
                                                            "  --color-chart-1: var(--chart-1);\n"/utf8>>/binary,
                                                        "  --color-chart-2: var(--chart-2);\n"/utf8>>/binary,
                                                    "  --color-chart-3: var(--chart-3);\n"/utf8>>/binary,
                                                "  --color-chart-4: var(--chart-4);\n"/utf8>>/binary,
                                            "  --color-chart-5: var(--chart-5);\n"/utf8>>/binary,
                                        "  --color-sidebar: var(--sidebar);\n"/utf8>>/binary,
                                    "  --color-sidebar-foreground: var(--sidebar-foreground);\n"/utf8>>/binary,
                                "  --color-sidebar-primary: var(--sidebar-primary);\n"/utf8>>/binary,
                            "  --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);\n"/utf8>>/binary,
                        "  --color-sidebar-accent: var(--sidebar-accent);\n"/utf8>>/binary,
                    "  --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);\n"/utf8>>/binary,
                "  --color-sidebar-border: var(--sidebar-border);\n"/utf8>>/binary,
            "  --color-sidebar-ring: var(--sidebar-ring);\n"/utf8>>/binary,
        "}\n"/utf8>>.

-file("src/glaze/basecoat/theme.gleam", 259).
?DOC(
    " Render a `<style type=\"text/tailwindcss\">` tag containing Basecoat's\n"
    " Tailwind v4 `@theme` mapping.\n"
    "\n"
    " This is only needed when using Tailwind's CDN (`@tailwindcss/browser`).\n"
    " With build-time Tailwind setups (Tailwind CLI / Vite), this mapping\n"
    " comes from `@import \"basecoat-css\";`.\n"
    "\n"
    " Basecoat defines design tokens like `--accent` and Tailwind generates utility\n"
    " classes like `bg-accent` from theme variables like `--color-accent`. This\n"
    " mapping bridges the two.\n"
).
-spec tailwind_v4_bridge_style_tag() -> lustre@vdom@vnode:element(any()).
tailwind_v4_bridge_style_tag() ->
    lustre@element@html:style(
        [lustre@attribute:attribute(
                <<"type"/utf8>>,
                <<"text/tailwindcss"/utf8>>
            )],
        tailwind_v4_bridge_css()
    ).

-file("src/glaze/basecoat/theme.gleam", 321).
-spec token_css_var(token()) -> binary().
token_css_var(Token) ->
    case Token of
        background ->
            <<"--background"/utf8>>;

        foreground ->
            <<"--foreground"/utf8>>;

        card ->
            <<"--card"/utf8>>;

        card_foreground ->
            <<"--card-foreground"/utf8>>;

        popover ->
            <<"--popover"/utf8>>;

        popover_foreground ->
            <<"--popover-foreground"/utf8>>;

        primary ->
            <<"--primary"/utf8>>;

        primary_foreground ->
            <<"--primary-foreground"/utf8>>;

        secondary ->
            <<"--secondary"/utf8>>;

        secondary_foreground ->
            <<"--secondary-foreground"/utf8>>;

        muted ->
            <<"--muted"/utf8>>;

        muted_foreground ->
            <<"--muted-foreground"/utf8>>;

        accent ->
            <<"--accent"/utf8>>;

        accent_foreground ->
            <<"--accent-foreground"/utf8>>;

        destructive ->
            <<"--destructive"/utf8>>;

        destructive_foreground ->
            <<"--destructive-foreground"/utf8>>;

        border ->
            <<"--border"/utf8>>;

        input ->
            <<"--input"/utf8>>;

        ring ->
            <<"--ring"/utf8>>;

        radius ->
            <<"--radius"/utf8>>;

        chart1 ->
            <<"--chart-1"/utf8>>;

        chart2 ->
            <<"--chart-2"/utf8>>;

        chart3 ->
            <<"--chart-3"/utf8>>;

        chart4 ->
            <<"--chart-4"/utf8>>;

        chart5 ->
            <<"--chart-5"/utf8>>;

        sidebar ->
            <<"--sidebar"/utf8>>;

        sidebar_foreground ->
            <<"--sidebar-foreground"/utf8>>;

        sidebar_primary ->
            <<"--sidebar-primary"/utf8>>;

        sidebar_primary_foreground ->
            <<"--sidebar-primary-foreground"/utf8>>;

        sidebar_accent ->
            <<"--sidebar-accent"/utf8>>;

        sidebar_accent_foreground ->
            <<"--sidebar-accent-foreground"/utf8>>;

        sidebar_border ->
            <<"--sidebar-border"/utf8>>;

        sidebar_ring ->
            <<"--sidebar-ring"/utf8>>
    end.

-file("src/glaze/basecoat/theme.gleam", 303).
-spec theme_to_css_variables(theme()) -> binary().
theme_to_css_variables(Theme) ->
    {theme, Values} = Theme,
    _pipe = Values,
    _pipe@1 = maps:to_list(_pipe),
    _pipe@2 = gleam@list:sort(
        _pipe@1,
        fun(A, B) ->
            {Token_a, _} = A,
            {Token_b, _} = B,
            gleam@string:compare(token_css_var(Token_a), token_css_var(Token_b))
        end
    ),
    gleam@list:fold(
        _pipe@2,
        <<""/utf8>>,
        fun(Acc, Cur) ->
            {Token, Value} = Cur,
            case Value of
                <<""/utf8>> ->
                    Acc;

                _ ->
                    <<<<<<<<<<Acc/binary, "  "/utf8>>/binary,
                                    (token_css_var(Token))/binary>>/binary,
                                ": "/utf8>>/binary,
                            Value/binary>>/binary,
                        ";\n"/utf8>>
            end
        end
    ).

-file("src/glaze/basecoat/theme.gleam", 227).
?DOC(" Render a `<style>` tag that sets all CSS variables from the theme.\n").
-spec style_tag(theme()) -> lustre@vdom@vnode:element(any()).
style_tag(Theme) ->
    lustre@element@html:style(
        [],
        <<<<":root {\n"/utf8, (theme_to_css_variables(Theme))/binary>>/binary,
            "}"/utf8>>
    ).

-file("src/glaze/basecoat/theme.gleam", 236).
?DOC(
    " Render a `<style>` tag with both light and dark theme variants.\n"
    "\n"
    " This generates CSS that automatically switches between themes\n"
    " based on the `color-scheme` or `prefers-color-scheme` media query.\n"
).
-spec style_tag_light_dark(theme(), theme()) -> lustre@vdom@vnode:element(any()).
style_tag_light_dark(Light, Dark) ->
    lustre@element@html:style(
        [],
        <<<<<<<<<<":root {\n"/utf8, (theme_to_css_variables(Light))/binary>>/binary,
                        "}\n\n"/utf8>>/binary,
                    ".dark {\n"/utf8>>/binary,
                (theme_to_css_variables(Dark))/binary>>/binary,
            "}"/utf8>>
    ).
