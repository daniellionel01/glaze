import glaze/icons
import lustre/attribute
import lustre/element
import lustre/element/html

/// https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L3
const cn_accordion_item_css = "not-last:border-b"

/// https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L7
const cn_accordion_trigger = "
  @apply focus-visible:ring-ring/50 focus-visible:border-ring focus-visible:after:border-ring
  **:data-[slot=accordion-trigger-icon]:text-muted-foreground rounded-md py-4 text-left text-sm font-medium
  hover:underline focus-visible:ring-3 **:data-[slot=accordion-trigger-icon]:ml-auto **:data-[slot=accordion-trigger-icon]:size-4
"

/// https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/bases/base/ui/accordion.tsx
pub fn accordion(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  html.section(
    [
      attribute.data("slot", "accordion"),
      attribute.class("flex w-full flex-col"),
      ..attrs
    ],
    children,
  )
}

pub fn item(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  html.details(
    [
      attribute.data("slot", "accordion-item"),
      attribute.class(cn_accordion_item_css),
      attribute.class(
        "
          group
          [&::details-content]:block
          [&::details-content]:overflow-clip
          [&::details-content]:opacity-0
          [&::details-content]:[block-size:0]
          [&::details-content]:transition-all
          [&::details-content]:duration-300
          [&::details-content]:ease-[cubic-bezier(0.87,0,0.13,1)]
          [&::details-content]:[transition-behavior:allow-discrete]
          [&[open]::details-content]:opacity-100
          [&[open]::details-content]:[block-size:calc-size(auto,size)]
        ",
      ),
      ..attrs
    ],
    children,
  )
}

pub fn trigger(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  html.summary(
    [
      attribute.data("slot", "accordion-trigger"),
      attribute.class(cn_accordion_trigger),
      attribute.class(
        "relative flex flex-1 items-start justify-between border border-transparent transition-all outline-none aria-disabled:pointer-events-none aria-disabled:opacity-50",
      ),
      ..attrs
    ],
    [
      element.fragment(children),
      icons.chevron_down([
        attribute.data("slot", "accordion-trigger-icon"),
        attribute.class(
          "pointer-events-none shrink-0 group-open:rotate-180 transition-transform duration-300 ease-[cubic-bezier(0.87,_0,_0.13,_1)]",
        ),
      ]),
    ],
  )
}

pub fn content(
  attrs: List(attribute.Attribute(a)),
  children: List(element.Element(a)),
) -> element.Element(a) {
  html.div(
    [
      attribute.data("slot", "accordion-content"),
      attribute.class("text-sm"),
      ..attrs
    ],
    [
      html.div(
        [
          // https://github.com/shadcn-ui/ui/blob/5b40b9de5ad5e81228efecbff86d5f0728342ec0/apps/v4/registry/styles/style-vega.css#L15
          attribute.class("pt-0 pb-4"),
          attribute.class(
            "[&_a]:underline [&_a]:underline-offset-3 [&_a]:hover:text-foreground [&_p:not(:last-child)]:mb-4",
          ),
        ],
        children,
      ),
    ],
  )
}
