# 🍩 Glaze

[Lustre](https://github.com/lustre-labs/lustre) bindings to framework-agnostic UI Component Libraries:
- **glaze_oat:** [hexdocs](https://hexdocs.pm/glaze_oat/) | [github](https://github.com/daniellionel01/glaze/tree/main/glaze_oat) | [demo](https://daniellionel01.github.io/glaze/glaze_oat/)

<br />

**Oat:** [GitHub](https://github.com/knadh/oat), [Website](https://oat.ink/)

## About this Project

There are a lot of framework-agnostic UI Libraries out there. [DaisyUI](https://daisyui.com/), [Oat](https://oat.ink/), [Basecoat](https://basecoatui.com/), [Bootstrap](https://getbootstrap.com/), ...

Framework-agnostic in this case means that they are not tied to a particular JavaScript Framework ([React](https://react.dev/), [Vue](https://vuejs.org/), [Svelte](https://svelte.dev/), ...), such as [shadcn/ui](https://ui.shadcn.com/), [Vuetify](https://vuetifyjs.com/en/) or [Skeleton](https://www.skeleton.dev/). Instead, they are purely CSS and vanilla JavaScript.

These framework-agnostic UI Libraries are already relatively low friction to get started with. Meaning that they are mostly just css classes and some custom data attributes. However I think providing dedicated APIs in Gleam for things like theming and constructing the elements with best practices has a lot of benefits as you build more complex interfaces.

## Development

In each package, there is a `dev` module that constructs a demo with all available elements and writes it to a static `.html` file that you can open in your browser and (optionally) publish via GitHub Pages.

```sh
cd glaze_oat
gleam run -m glaze_oat_dev
open ../docs/glaze_oat/index.html
```

To update the GitHub Pages demo artifact from the repository root:

```sh
./scripts/update-glaze-oat-demo.sh
```

## Future Work

I think [Basecoat](https://basecoatui.com/) and [DaisyUI](https://daisyui.com/) are great candidates for this repo!

[Oat](https://oak.ink/) also has [extensions](https://oat.ink/extensions/), which could be interesting to include in this library.

## Inspiration

Most of this API was inspired by [Lustre UI](https://github.com/lustre-labs/ui) and [shadcn/ui](https://ui.shadcn.com/).
