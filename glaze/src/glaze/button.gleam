import lustre/attribute
import lustre/element
import lustre/element/html

/// https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/bases/base/ui/button.tsx
const shadcn_button_css = "
  group/button inline-flex shrink-0 items-center justify-center whitespace-nowrap transition-all outline-none select-none
  disabled:pointer-events-none disabled:opacity-50 [&_svg]:pointer-events-none [&_svg]:shrink-0
"

/// https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L145
const cn_button_css = "
  focus-visible:border-ring focus-visible:ring-ring/50 aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40
  aria-invalid:border-destructive dark:aria-invalid:border-destructive/50 rounded-md border bg-clip-padding
  text-sm font-medium focus-visible:ring-3 aria-invalid:ring-3 active:translate-y-px [&_svg:not([class*='size-'])]:size-4
"

pub type Variant {
  DefaultVariant
  Outline
  Secondary
  Ghost
  Destructive
  Link
}

pub fn variant_css(variant: Variant) {
  case variant {
    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L149
    DefaultVariant ->
      "border-transparent bg-primary text-primary-foreground [a]:hover:bg-primary/80"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L153
    Outline ->
      "
        border-border bg-background hover:bg-muted hover:text-foreground dark:bg-input/30 dark:border-input dark:hover:bg-input/50
        aria-expanded:bg-muted aria-expanded:text-foreground shadow-xs
      "

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L157
    Secondary ->
      "border-transparent bg-secondary text-secondary-foreground hover:bg-secondary/80 aria-expanded:bg-secondary aria-expanded:text-secondary-foreground"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L161
    Ghost ->
      "border-transparent hover:bg-muted hover:text-foreground dark:hover:bg-muted/50 aria-expanded:bg-muted aria-expanded:text-foreground"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L165
    Destructive ->
      "
        border-transparent bg-destructive/10 hover:bg-destructive/20 focus-visible:ring-destructive/20 dark:focus-visible:ring-destructive/40
        dark:bg-destructive/20 text-destructive focus-visible:border-destructive/40 dark:hover:bg-destructive/30
      "

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L169
    Link -> "border-transparent text-primary underline-offset-4 hover:underline"
  }
}

pub type Size {
  DefaultSize
  XS
  SM
  LG
  Icon
  IconXS
  IconSM
  IconLG
}

pub fn size_css(size: Size) {
  case size {
    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L181
    DefaultSize ->
      "h-9 gap-1.5 px-2.5 in-data-[slot=button-group]:rounded-md has-data-[icon=inline-end]:pr-2 has-data-[icon=inline-start]:pl-2"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L173
    XS ->
      "
        h-6 gap-1 rounded-[min(var(--radius-md),8px)] px-2 text-xs in-data-[slot=button-group]:rounded-md has-data-[icon=inline-end]:pr-1.5
        has-data-[icon=inline-start]:pl-1.5 [&_svg:not([class*='size-'])]:size-3
      "

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L177
    SM ->
      "h-8 gap-1 rounded-[min(var(--radius-md),10px)] px-2.5 in-data-[slot=button-group]:rounded-md has-data-[icon=inline-end]:pr-1.5 has-data-[icon=inline-start]:pl-1.5"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L185
    LG ->
      "h-10 gap-1.5 px-2.5 has-data-[icon=inline-end]:pr-3 has-data-[icon=inline-start]:pl-3"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L197
    Icon -> "size-9"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L189
    IconXS ->
      "size-6 rounded-[min(var(--radius-md),8px)] in-data-[slot=button-group]:rounded-md [&_svg:not([class*='size-'])]:size-3"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L193
    IconSM ->
      "size-8 rounded-[min(var(--radius-md),10px)] in-data-[slot=button-group]:rounded-md"

    // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L201
    IconLG -> "size-10"
  }
}

pub fn default(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  instance(DefaultVariant, DefaultSize, attrs, children)
}

pub fn secondary(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  instance(Secondary, DefaultSize, attrs, children)
}

pub fn outline(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  instance(Outline, DefaultSize, attrs, children)
}

pub fn ghost(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  instance(Ghost, DefaultSize, attrs, children)
}

pub fn destructive(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  instance(Destructive, DefaultSize, attrs, children)
}

fn instance(
  variant: Variant,
  size: Size,
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  html.button(
    [
      attribute.class(cn_button_css),
      attribute.class(variant_css(variant)),
      attribute.class(size_css(size)),
      attribute.class(shadcn_button_css),
      ..attrs
    ],
    children,
  )
}
