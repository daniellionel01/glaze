# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2026-03-22

- The getting started instructions in `README.md` have been greatly improved.
- The repo gains example applications for a Lustre SPA and Wisp server.

- The `glaze/basecoat/icon` module has been removed. Basecoat recommends lucide icons, but never actually uses them in the components directly.

- In the `glaze/basecoat` module:
  - `register_js` has been renamed to `cdn_script`.
  - `register_css` has been renamed to `cdn_stylesheet`.

- In the `glaze/basecoat/theme` module:
  * The `tailwind_v4_bridge_style_tag` function has been renamed to `tailwind_bridge_style_tag`.
  * The `tailwind_v4_bridge_css` function has been removed and merged with `tailwind_bridge_style_tag`.

- The `glaze/basecoat/toast` API has been almost completely revised.
  * There is no utility function to construct javascript strings for the server. This logic should be implemented by the user of this library.

## [2.1.0] - 2026-03-07

- Fixed the svg elements, that did not use the proper `svg.svg` utility.

## [2.0.0] - 2026-03-03

- Remove `glaze/basecoat/register_component` functionality.

## [1.0.0] - 2026-03-01

- 🍩 Initial Release!
