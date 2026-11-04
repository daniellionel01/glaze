# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [5.0.0] - 2026-11-04

- **Breaking:** Requires Basecoat v1.1.0 (previously v0.3.11). If you vendor the CSS, use `dist/basecoat.bundle.css`.
- **Breaking:** `form.form` no longer styles plain inputs inside it, as Basecoat v1 removed `.form`. Use the `input`, `textarea` and `native_select` modules, or place controls directly inside a `field`.
- **Breaking:** The `select` module is renamed to `native_select` (and `select.select` to `native_select.native_select`), matching Basecoat's naming. `select` is now Basecoat's JavaScript select.
- **Breaking:** Removed `toast.event_name` and the `theme.DestructiveForeground` token, which Basecoat v1 no longer uses.
- Button, badge and alert variants use `data-variant` / `data-size` instead of classes like `btn-sm-outline`. The functions are unchanged.
- `field`, `form.group` and `label.with_input` render Basecoat's `.field`, and `form.fieldset` renders `.fieldset`.
- Sidebar, theme switcher and toast scripts use Basecoat v1's methods instead of document events.
- `accordion` and `alert_dialog_with_text` markup updated for Basecoat v1.
- New modules: `select`, `combobox`, `drawer`, `button_group`, `input_group` and `scroll_area`.
- Added `basecoat.cdn_stylesheet_with_style` to load one of Basecoat's style packs (Vega, Nova, Maia, …).

## [4.0.0] - 2026-11-04

- **Breaking:** `dialog.dialog`, `dialog.dialog_with_description`, `alert_dialog.alert_dialog` and `alert_dialog.alert_dialog_with_text` take a new `panel_attrs` argument after `attrs`, applied to the visible panel. Sizing attributes like `dialog.max_width` previously had no effect.

- Fixed `dialog.responsive_width` and `dialog.full_width`, which relied on Tailwind classes that weren't generated.

## [3.1.0] - 2026-03-25

- Add correct variants for button sizes and styles (for example `button.outline_sm`, because `sm` combined with `outline` results in primary colored button). (https://github.com/daniellionel01/glaze/pull/12)<br />
  Thank you rapind! (https://github.com/rapind)

## [3.0.0] - 2026-03-22

- The getting started instructions in `README.md` have been greatly improved.
- The repo gains example applications for a Lustre SPA and Wisp server.

- The `glaze/basecoat/icon` module has been removed. Basecoat recommends lucide icons, but never actually uses them in the components directly.

- In the `glaze/basecoat` module:
  - `register_js` has been renamed to `cdn_script`.
  - `register_css` has been renamed to `cdn_stylesheet`.

- In the `glaze/basecoat/theme` module:
  - The `tailwind_v4_bridge_style_tag` function has been renamed to `tailwind_bridge_style_tag`.
  - The `tailwind_v4_bridge_css` function has been removed and merged with `tailwind_bridge_style_tag`.

- The `glaze/basecoat/toast` API has been almost completely revised.
  - There is no utility function to construct javascript strings for the server. This logic should be implemented by the user of this library.

## [2.1.0] - 2026-03-07

- Fixed the svg elements, that did not use the proper `svg.svg` utility.

## [2.0.0] - 2026-03-03

- Remove `glaze/basecoat/register_component` functionality.

## [1.0.0] - 2026-03-01

- 🍩 Initial Release!
