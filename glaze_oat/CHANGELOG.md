# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.0.0] - 2026-11-04

- **Breaking:** Requires Oat v1.1.0 (previously v0.4.1).
- Badge variants use `data-variant` instead of classes.
- `form.field_error` is deprecated. Instead, use `form.field()` on the container and `form.invalid()` on the input.
- Tooltips now require Oat's JavaScript. Added `tooltip.bottom`, `tooltip.left` and `tooltip.right`.
- New modules: `avatar`, `taginput` and `upload`.

## [3.0.0] - 2026-03-22

- The repo gains example applications for a Lustre SPA and Wisp server.

- The `glaze/basecoat/toast` API has been almost completely revised:
  - `dispatch` is used to trigger a toast notification in the browser.
  - There is no utility function to construct javascript strings for the server. This logic should be implemented by the user of this library.

## [2.0.0] - 2026-03-02

- **Breaking Change:** moved gleam modules from `glaze_oat/...` -> `glaze/oat/...`.

- Order theme css variables alphabetically. This was causing issues in the GitHub Workflow to check if the glaze_oat demo HTML file is stale.

## [1.0.1] - 2026-03-01

- Clean up hexdocs related issues (tag prefix, monorepo path)

## [1.0.0] - 2026-03-01

- 🍩 Initial Release!
