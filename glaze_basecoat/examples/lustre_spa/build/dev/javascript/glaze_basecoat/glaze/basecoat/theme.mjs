import * as $dict from "../../../gleam_stdlib/gleam/dict.mjs";
import * as $list from "../../../gleam_stdlib/gleam/list.mjs";
import * as $string from "../../../gleam_stdlib/gleam/string.mjs";
import * as $attribute from "../../../lustre/lustre/attribute.mjs";
import { attribute } from "../../../lustre/lustre/attribute.mjs";
import * as $element from "../../../lustre/lustre/element.mjs";
import * as $html from "../../../lustre/lustre/element/html.mjs";
import { Ok, toList, CustomType as $CustomType } from "../../gleam.mjs";

export class Background extends $CustomType {}
export const Token$Background = () => new Background();
export const Token$isBackground = (value) => value instanceof Background;

export class Foreground extends $CustomType {}
export const Token$Foreground = () => new Foreground();
export const Token$isForeground = (value) => value instanceof Foreground;

export class Card extends $CustomType {}
export const Token$Card = () => new Card();
export const Token$isCard = (value) => value instanceof Card;

export class CardForeground extends $CustomType {}
export const Token$CardForeground = () => new CardForeground();
export const Token$isCardForeground = (value) =>
  value instanceof CardForeground;

export class Popover extends $CustomType {}
export const Token$Popover = () => new Popover();
export const Token$isPopover = (value) => value instanceof Popover;

export class PopoverForeground extends $CustomType {}
export const Token$PopoverForeground = () => new PopoverForeground();
export const Token$isPopoverForeground = (value) =>
  value instanceof PopoverForeground;

export class Primary extends $CustomType {}
export const Token$Primary = () => new Primary();
export const Token$isPrimary = (value) => value instanceof Primary;

export class PrimaryForeground extends $CustomType {}
export const Token$PrimaryForeground = () => new PrimaryForeground();
export const Token$isPrimaryForeground = (value) =>
  value instanceof PrimaryForeground;

export class Secondary extends $CustomType {}
export const Token$Secondary = () => new Secondary();
export const Token$isSecondary = (value) => value instanceof Secondary;

export class SecondaryForeground extends $CustomType {}
export const Token$SecondaryForeground = () => new SecondaryForeground();
export const Token$isSecondaryForeground = (value) =>
  value instanceof SecondaryForeground;

export class Muted extends $CustomType {}
export const Token$Muted = () => new Muted();
export const Token$isMuted = (value) => value instanceof Muted;

export class MutedForeground extends $CustomType {}
export const Token$MutedForeground = () => new MutedForeground();
export const Token$isMutedForeground = (value) =>
  value instanceof MutedForeground;

export class Accent extends $CustomType {}
export const Token$Accent = () => new Accent();
export const Token$isAccent = (value) => value instanceof Accent;

export class AccentForeground extends $CustomType {}
export const Token$AccentForeground = () => new AccentForeground();
export const Token$isAccentForeground = (value) =>
  value instanceof AccentForeground;

export class Destructive extends $CustomType {}
export const Token$Destructive = () => new Destructive();
export const Token$isDestructive = (value) => value instanceof Destructive;

export class DestructiveForeground extends $CustomType {}
export const Token$DestructiveForeground = () => new DestructiveForeground();
export const Token$isDestructiveForeground = (value) =>
  value instanceof DestructiveForeground;

export class Border extends $CustomType {}
export const Token$Border = () => new Border();
export const Token$isBorder = (value) => value instanceof Border;

export class Input extends $CustomType {}
export const Token$Input = () => new Input();
export const Token$isInput = (value) => value instanceof Input;

export class Ring extends $CustomType {}
export const Token$Ring = () => new Ring();
export const Token$isRing = (value) => value instanceof Ring;

export class Radius extends $CustomType {}
export const Token$Radius = () => new Radius();
export const Token$isRadius = (value) => value instanceof Radius;

export class Chart1 extends $CustomType {}
export const Token$Chart1 = () => new Chart1();
export const Token$isChart1 = (value) => value instanceof Chart1;

export class Chart2 extends $CustomType {}
export const Token$Chart2 = () => new Chart2();
export const Token$isChart2 = (value) => value instanceof Chart2;

export class Chart3 extends $CustomType {}
export const Token$Chart3 = () => new Chart3();
export const Token$isChart3 = (value) => value instanceof Chart3;

export class Chart4 extends $CustomType {}
export const Token$Chart4 = () => new Chart4();
export const Token$isChart4 = (value) => value instanceof Chart4;

export class Chart5 extends $CustomType {}
export const Token$Chart5 = () => new Chart5();
export const Token$isChart5 = (value) => value instanceof Chart5;

export class Sidebar extends $CustomType {}
export const Token$Sidebar = () => new Sidebar();
export const Token$isSidebar = (value) => value instanceof Sidebar;

export class SidebarForeground extends $CustomType {}
export const Token$SidebarForeground = () => new SidebarForeground();
export const Token$isSidebarForeground = (value) =>
  value instanceof SidebarForeground;

export class SidebarPrimary extends $CustomType {}
export const Token$SidebarPrimary = () => new SidebarPrimary();
export const Token$isSidebarPrimary = (value) =>
  value instanceof SidebarPrimary;

export class SidebarPrimaryForeground extends $CustomType {}
export const Token$SidebarPrimaryForeground = () =>
  new SidebarPrimaryForeground();
export const Token$isSidebarPrimaryForeground = (value) =>
  value instanceof SidebarPrimaryForeground;

export class SidebarAccent extends $CustomType {}
export const Token$SidebarAccent = () => new SidebarAccent();
export const Token$isSidebarAccent = (value) => value instanceof SidebarAccent;

export class SidebarAccentForeground extends $CustomType {}
export const Token$SidebarAccentForeground = () =>
  new SidebarAccentForeground();
export const Token$isSidebarAccentForeground = (value) =>
  value instanceof SidebarAccentForeground;

export class SidebarBorder extends $CustomType {}
export const Token$SidebarBorder = () => new SidebarBorder();
export const Token$isSidebarBorder = (value) => value instanceof SidebarBorder;

export class SidebarRing extends $CustomType {}
export const Token$SidebarRing = () => new SidebarRing();
export const Token$isSidebarRing = (value) => value instanceof SidebarRing;

class Theme extends $CustomType {
  constructor(values) {
    super();
    this.values = values;
  }
}

/**
 * Construct a `Theme` from a list of token-value pairs.
 *
 * If the same token appears multiple times, the last value overrides previous ones.
 *
 * ### Example
 *
 * ```gleam
 * let t = theme.from_list([
 *   #(theme.Primary, "oklch(0.205 0 0)"),
 *   #(theme.PrimaryForeground, "oklch(0.985 0 0)"),
 * ])
 * ```
 */
export function from_list(tokens) {
  let values = $list.fold(
    tokens,
    $dict.new$(),
    (acc, cur) => {
      let token;
      let value;
      token = cur[0];
      value = cur[1];
      return $dict.insert(acc, token, value);
    },
  );
  return new Theme(values);
}

/**
 * Returns Basecoat's default theme (shadcn/ui default theme).
 *
 * This includes the default color palette and border radius.
 * Start with this and customize as needed.
 */
export function default_theme() {
  let _pipe = toList([
    [new Background(), "oklch(1 0 0)"],
    [new Foreground(), "oklch(0.145 0 0)"],
    [new Card(), "oklch(1 0 0)"],
    [new CardForeground(), "oklch(0.145 0 0)"],
    [new Popover(), "oklch(1 0 0)"],
    [new PopoverForeground(), "oklch(0.145 0 0)"],
    [new Primary(), "oklch(0.205 0 0)"],
    [new PrimaryForeground(), "oklch(0.985 0 0)"],
    [new Secondary(), "oklch(0.97 0 0)"],
    [new SecondaryForeground(), "oklch(0.205 0 0)"],
    [new Muted(), "oklch(0.97 0 0)"],
    [new MutedForeground(), "oklch(0.556 0 0)"],
    [new Accent(), "oklch(0.97 0 0)"],
    [new AccentForeground(), "oklch(0.205 0 0)"],
    [new Destructive(), "oklch(0.577 0.245 27.325)"],
    [new DestructiveForeground(), "oklch(0.985 0 0)"],
    [new Border(), "oklch(0.922 0 0)"],
    [new Input(), "oklch(0.922 0 0)"],
    [new Ring(), "oklch(0.708 0 0)"],
    [new Radius(), "0.5rem"],
    [new Chart1(), "oklch(0.646 0.222 41.116)"],
    [new Chart2(), "oklch(0.6 0.118 184.704)"],
    [new Chart3(), "oklch(0.398 0.07 227.392)"],
    [new Chart4(), "oklch(0.828 0.189 84.429)"],
    [new Chart5(), "oklch(0.769 0.188 70.08)"],
    [new Sidebar(), "oklch(0.985 0 0)"],
    [new SidebarForeground(), "oklch(0.145 0 0)"],
    [new SidebarPrimary(), "oklch(0.205 0 0)"],
    [new SidebarPrimaryForeground(), "oklch(0.985 0 0)"],
    [new SidebarAccent(), "oklch(0.97 0 0)"],
    [new SidebarAccentForeground(), "oklch(0.205 0 0)"],
    [new SidebarBorder(), "oklch(0.922 0 0)"],
    [new SidebarRing(), "oklch(0.708 0 0)"],
  ]);
  return from_list(_pipe);
}

/**
 * Returns the dark theme variant.
 *
 * Use this for dark mode or combine with `default_theme()` using `light-dark()`.
 */
export function dark_theme() {
  let _pipe = toList([
    [new Background(), "oklch(0.145 0 0)"],
    [new Foreground(), "oklch(0.985 0 0)"],
    [new Card(), "oklch(0.205 0 0)"],
    [new CardForeground(), "oklch(0.985 0 0)"],
    [new Popover(), "oklch(0.269 0 0)"],
    [new PopoverForeground(), "oklch(0.985 0 0)"],
    [new Primary(), "oklch(0.922 0 0)"],
    [new PrimaryForeground(), "oklch(0.205 0 0)"],
    [new Secondary(), "oklch(0.269 0 0)"],
    [new SecondaryForeground(), "oklch(0.985 0 0)"],
    [new Muted(), "oklch(0.269 0 0)"],
    [new MutedForeground(), "oklch(0.708 0 0)"],
    [new Accent(), "oklch(0.371 0 0)"],
    [new AccentForeground(), "oklch(0.985 0 0)"],
    [new Destructive(), "oklch(0.704 0.191 22.216)"],
    [new DestructiveForeground(), "oklch(0.985 0 0)"],
    [new Border(), "oklch(1 0 0 / 10%)"],
    [new Input(), "oklch(1 0 0 / 15%)"],
    [new Ring(), "oklch(0.556 0 0)"],
    [new Radius(), "0.5rem"],
    [new Chart1(), "oklch(0.488 0.243 264.376)"],
    [new Chart2(), "oklch(0.696 0.17 162.48)"],
    [new Chart3(), "oklch(0.769 0.188 70.08)"],
    [new Chart4(), "oklch(0.627 0.265 303.9)"],
    [new Chart5(), "oklch(0.645 0.246 16.439)"],
    [new Sidebar(), "oklch(0.205 0 0)"],
    [new SidebarForeground(), "oklch(0.985 0 0)"],
    [new SidebarPrimary(), "oklch(0.488 0.243 264.376)"],
    [new SidebarPrimaryForeground(), "oklch(0.985 0 0)"],
    [new SidebarAccent(), "oklch(0.269 0 0)"],
    [new SidebarAccentForeground(), "oklch(0.985 0 0)"],
    [new SidebarBorder(), "oklch(1 0 0 / 10%)"],
    [new SidebarRing(), "oklch(0.439 0 0)"],
  ]);
  return from_list(_pipe);
}

/**
 * Convert a `Theme` into token-value pairs.
 */
export function to_list(theme) {
  let values;
  values = theme.values;
  return $dict.to_list(values);
}

/**
 * Get a token value from a theme.
 */
export function get(theme, token) {
  let values;
  values = theme.values;
  let $ = $dict.get(values, token);
  if ($ instanceof Ok) {
    let value = $[0];
    return value;
  } else {
    return "";
  }
}

/**
 * Set a token value in a theme.
 */
export function set(theme, token, value) {
  let values;
  values = theme.values;
  return new Theme($dict.insert(values, token, value));
}

/**
 * Set multiple token values in a theme.
 */
export function set_many(theme, updates) {
  return $list.fold(
    updates,
    theme,
    (acc, cur) => {
      let token;
      let value;
      token = cur[0];
      value = cur[1];
      return set(acc, token, value);
    },
  );
}

/**
 * The Tailwind v4 `@theme` mapping used by Basecoat.
 *
 * This matches the `@theme` block in Basecoat's `src/css/basecoat.css`.
 */
export function tailwind_v4_bridge_css() {
  return ((((((((((((((((((((((((((((((("@theme {\n" + "  --color-background: var(--background);\n") + "  --color-foreground: var(--foreground);\n") + "  --color-card: var(--card);\n") + "  --color-card-foreground: var(--card-foreground);\n") + "  --color-popover: var(--popover);\n") + "  --color-popover-foreground: var(--popover-foreground);\n") + "  --color-primary: var(--primary);\n") + "  --color-primary-foreground: var(--primary-foreground);\n") + "  --color-secondary: var(--secondary);\n") + "  --color-secondary-foreground: var(--secondary-foreground);\n") + "  --color-muted: var(--muted);\n") + "  --color-muted-foreground: var(--muted-foreground);\n") + "  --color-accent: var(--accent);\n") + "  --color-accent-foreground: var(--accent-foreground);\n") + "  --color-destructive: var(--destructive);\n") + "  --color-border: var(--border);\n") + "  --color-input: var(--input);\n") + "  --color-ring: var(--ring);\n") + "  --color-chart-1: var(--chart-1);\n") + "  --color-chart-2: var(--chart-2);\n") + "  --color-chart-3: var(--chart-3);\n") + "  --color-chart-4: var(--chart-4);\n") + "  --color-chart-5: var(--chart-5);\n") + "  --color-sidebar: var(--sidebar);\n") + "  --color-sidebar-foreground: var(--sidebar-foreground);\n") + "  --color-sidebar-primary: var(--sidebar-primary);\n") + "  --color-sidebar-primary-foreground: var(--sidebar-primary-foreground);\n") + "  --color-sidebar-accent: var(--sidebar-accent);\n") + "  --color-sidebar-accent-foreground: var(--sidebar-accent-foreground);\n") + "  --color-sidebar-border: var(--sidebar-border);\n") + "  --color-sidebar-ring: var(--sidebar-ring);\n") + "}\n";
}

/**
 * Render a `<style type="text/tailwindcss">` tag containing Basecoat's
 * Tailwind v4 `@theme` mapping.
 *
 * This is only needed when using Tailwind's CDN (`@tailwindcss/browser`).
 * With build-time Tailwind setups (Tailwind CLI / Vite), this mapping
 * comes from `@import "basecoat-css";`.
 *
 * Basecoat defines design tokens like `--accent` and Tailwind generates utility
 * classes like `bg-accent` from theme variables like `--color-accent`. This
 * mapping bridges the two.
 */
export function tailwind_v4_bridge_style_tag() {
  return $html.style(
    toList([attribute("type", "text/tailwindcss")]),
    tailwind_v4_bridge_css(),
  );
}

function token_css_var(token) {
  if (token instanceof Background) {
    return "--background";
  } else if (token instanceof Foreground) {
    return "--foreground";
  } else if (token instanceof Card) {
    return "--card";
  } else if (token instanceof CardForeground) {
    return "--card-foreground";
  } else if (token instanceof Popover) {
    return "--popover";
  } else if (token instanceof PopoverForeground) {
    return "--popover-foreground";
  } else if (token instanceof Primary) {
    return "--primary";
  } else if (token instanceof PrimaryForeground) {
    return "--primary-foreground";
  } else if (token instanceof Secondary) {
    return "--secondary";
  } else if (token instanceof SecondaryForeground) {
    return "--secondary-foreground";
  } else if (token instanceof Muted) {
    return "--muted";
  } else if (token instanceof MutedForeground) {
    return "--muted-foreground";
  } else if (token instanceof Accent) {
    return "--accent";
  } else if (token instanceof AccentForeground) {
    return "--accent-foreground";
  } else if (token instanceof Destructive) {
    return "--destructive";
  } else if (token instanceof DestructiveForeground) {
    return "--destructive-foreground";
  } else if (token instanceof Border) {
    return "--border";
  } else if (token instanceof Input) {
    return "--input";
  } else if (token instanceof Ring) {
    return "--ring";
  } else if (token instanceof Radius) {
    return "--radius";
  } else if (token instanceof Chart1) {
    return "--chart-1";
  } else if (token instanceof Chart2) {
    return "--chart-2";
  } else if (token instanceof Chart3) {
    return "--chart-3";
  } else if (token instanceof Chart4) {
    return "--chart-4";
  } else if (token instanceof Chart5) {
    return "--chart-5";
  } else if (token instanceof Sidebar) {
    return "--sidebar";
  } else if (token instanceof SidebarForeground) {
    return "--sidebar-foreground";
  } else if (token instanceof SidebarPrimary) {
    return "--sidebar-primary";
  } else if (token instanceof SidebarPrimaryForeground) {
    return "--sidebar-primary-foreground";
  } else if (token instanceof SidebarAccent) {
    return "--sidebar-accent";
  } else if (token instanceof SidebarAccentForeground) {
    return "--sidebar-accent-foreground";
  } else if (token instanceof SidebarBorder) {
    return "--sidebar-border";
  } else {
    return "--sidebar-ring";
  }
}

function theme_to_css_variables(theme) {
  let values;
  values = theme.values;
  let _pipe = values;
  let _pipe$1 = $dict.to_list(_pipe);
  let _pipe$2 = $list.sort(
    _pipe$1,
    (a, b) => {
      let token_a;
      token_a = a[0];
      let token_b;
      token_b = b[0];
      return $string.compare(token_css_var(token_a), token_css_var(token_b));
    },
  );
  return $list.fold(
    _pipe$2,
    "",
    (acc, cur) => {
      let token;
      let value;
      token = cur[0];
      value = cur[1];
      if (value === "") {
        return acc;
      } else {
        return ((((acc + "  ") + token_css_var(token)) + ": ") + value) + ";\n";
      }
    },
  );
}

/**
 * Render a `<style>` tag that sets all CSS variables from the theme.
 */
export function style_tag(theme) {
  return $html.style(
    toList([]),
    (":root {\n" + theme_to_css_variables(theme)) + "}",
  );
}

/**
 * Render a `<style>` tag with both light and dark theme variants.
 *
 * This generates CSS that automatically switches between themes
 * based on the `color-scheme` or `prefers-color-scheme` media query.
 */
export function style_tag_light_dark(light, dark) {
  return $html.style(
    toList([]),
    ((((":root {\n" + theme_to_css_variables(light)) + "}\n\n") + ".dark {\n") + theme_to_css_variables(
      dark,
    )) + "}",
  );
}
