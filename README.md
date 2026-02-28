# 🍩 Glaze

[Lustre](https://github.com/lustre-labs/lustre) bindings to framework-agnostic UI Component Libraries:
- [glaze_basecoat](https://github.com/daniellionel01/glaze/tree/main/glaze_basecoat) | Basecoat: [GitHub](https://github.com/hunvreus/basecoat), [Website](https://basecoatui.com/)
- [glaze_oat](https://github.com/daniellionel01/glaze/tree/main/glaze_oat) | Oat: [GitHub](https://github.com/knadh/oat), [Website](https://oat.ink/)

## About this Project

There are a lot of framework-agnostic UI Libraries out there. [DaisyUI](https://daisyui.com/), [Oat](https://oat.ink/), [Basecoat](https://basecoatui.com/), [Bootstrap](https://getbootstrap.com/), ...

Framework-agnostic in this case means that they are not tied to a particular JavaScript Framework ([React](https://react.dev/), [Vue](https://vuejs.org/), [Svelte](https://svelte.dev/), ...), such as [shadcn/ui](https://ui.shadcn.com/), [Vuetify](https://vuetifyjs.com/en/) or [Skeleton](https://www.skeleton.dev/). Instead, they are purely CSS and vanilla JavaScript.

These framework-agnostic UI Libraries are already relatively low friction to get started with. Meaning that they are mostly just css classes and some custom data attributes. However I think providing dedicated APIs in Gleam for things like theming and constructing the elements with best practices has a lot of benefits as you build more complex interfaces.

I do not have a personal preference for [Oat](https://oat.ink/) or [Basecoat](https://basecoatui.com/). I picked them, because I was familiar with both of them. I am sure there are plenty of other libraries out there. Feel free to fork, contribute or do whatever with this code!

## Development

For both packages, there is a `dev` module, that constructs a Demo with all available elements and writes it to a `.html` file, that you can simply open in your browser and inspect.

```sh
cd glaze_basecoat
gleam dev
open basecoat.html

# or

cd glaze_oat
gleam dev
open oat.html
```

## Future Work

I think [DaisyUI](https://daisyui.com/) is a great candidate for this repo!

## Inspiration

Most of this API was inspired by [Lustre UI](https://github.com/lustre-labs/ui) and [shadcn/ui](https://ui.shadcn.com/).
