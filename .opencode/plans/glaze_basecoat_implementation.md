# glaze_basecoat Implementation Plan

## Overview

**glaze_basecoat** is a Gleam/Lustre wrapper library for [Basecoat UI](https://basecoatui.com/) - a Tailwind CSS-based component library inspired by shadcn/ui that works with any web stack.

- **Basecoat UI Version**: v0.3.11
- **Repository**: https://github.com/hunvreus/basecoat
- **Documentation**: https://basecoatui.com/

## Key Differences from glaze_oat

| Aspect | Oat UI | Basecoat UI |
|--------|--------|-------------|
| Styling | CSS custom properties + data attributes | Tailwind CSS classes |
| Variant syntax | `data-variant="primary"` | `class="btn-primary"` |
| Requires Tailwind | No | Yes (unless using CDN) |
| Size | ~8KB | Larger (Tailwind + components) |
| Components | 22 | 36+ |
| JavaScript | Minimal | More JS for interactive components |

## Architecture

### Package Structure

```
glaze_basecoat/
├── gleam.toml
├── README.md
├── CHANGELOG.md
├── manifest.toml
├── src/
│   ├── glaze_basecoat.gleam          # Main module, register() function
│   └── glaze_basecoat/
│       ├── theme.gleam               # Theme tokens and CSS variables
│       ├── button.gleam              # Button + Button Group
│       ├── badge.gleam               # Badge
│       ├── card.gleam                # Card
│       ├── alert.gleam               # Alert
│       ├── dialog.gleam              # Dialog + Alert Dialog
│       ├── accordion.gleam           # Accordion
│       ├── avatar.gleam              # Avatar
│       ├── breadcrumb.gleam          # Breadcrumb
│       ├── checkbox.gleam            # Checkbox
│       ├── command.gleam             # Command
│       ├── combobox.gleam            # Combobox
│       ├── dropdown_menu.gleam       # Dropdown Menu
│       ├── empty.gleam               # Empty
│       ├── field.gleam               # Field
│       ├── form.gleam                # Form
│       ├── input.gleam               # Input + Input Group
│       ├── item.gleam                # Item
│       ├── kbd.gleam                 # Kbd (Keyboard)
│       ├── label.gleam               # Label
│       ├── pagination.gleam          # Pagination
│       ├── popover.gleam             # Popover
│       ├── progress.gleam            # Progress
│       ├── radio_group.gleam         # Radio Group
│       ├── select.gleam              # Select
│       ├── sidebar.gleam             # Sidebar
│       ├── skeleton.gleam            # Skeleton
│       ├── slider.gleam              # Slider
│       ├── spinner.gleam             # Spinner
│       ├── switch.gleam              # Switch
│       ├── table.gleam               # Table
│       ├── tabs.gleam                # Tabs
│       ├── textarea.gleam            # Textarea
│       ├── theme_switcher.gleam      # Theme Switcher
│       ├── toast.gleam               # Toast
│       ├── toast_ffi.mjs             # Toast FFI for JS interop
│       └── tooltip.gleam             # Tooltip
└── dev/
    └── glaze_basecoat_dev.gleam      # Kitchen sink demo
```

## Implementation Phases

### Phase 1: Project Setup
- [ ] Update `gleam.toml` with proper metadata (lustre dependency, etc.)
- [ ] Create `src/glaze_basecoat.gleam` with `register()` function
- [ ] Create `src/glaze_basecoat/theme.gleam` for theming support
- [ ] Set up dev module structure

### Phase 2: Core Components (Priority 1)
Simple components with minimal to no JavaScript:

1. **button.gleam** - Button variants (primary, secondary, destructive, outline, ghost, link, icon)
   - Classes: `btn`, `btn-primary`, `btn-secondary`, `btn-destructive`, `btn-outline`, `btn-ghost`, `btn-link`, `btn-icon`
   - Sizes: `btn-sm`, `btn-lg`
   - Button Group: `buttons` container

2. **badge.gleam** - Badge component
   - Classes: `badge`, `badge-secondary`, `badge-outline`, `badge-destructive`

3. **card.gleam** - Card with header, content, footer
   - Class: `card`
   - Structure: `<header>`, `<section>`, `<footer>`

4. **alert.gleam** - Alert component
   - Classes: `alert`, `alert-destructive`
   - Structure: icon, title, description

5. **skeleton.gleam** - Skeleton loading placeholder
   - Class: `skeleton`

6. **spinner.gleam** - Loading spinner
   - Class: `spinner`

7. **progress.gleam** - Progress bar
   - Class: `progress`

8. **avatar.gleam** - Avatar component
   - Class: `avatar`
   - Fallback initials support

9. **kbd.gleam** - Keyboard shortcut display
   - Class: `kbd`

10. **label.gleam** - Form label
    - Class: `label`

### Phase 3: Form Components (Priority 2)

11. **input.gleam** - Input field + Input Group
    - Class: `input`
    - Input Group: `input-group`

12. **textarea.gleam** - Textarea
    - Class: `textarea`

13. **checkbox.gleam** - Checkbox
    - Class: `checkbox`

14. **switch.gleam** - Toggle switch
    - Class: `switch`

15. **radio_group.gleam** - Radio button group
    - Classes: `radio-group`, `radio`

16. **select.gleam** - Select dropdown (requires JS)
    - Class: `select`
    - Requires: `select.js`

17. **slider.gleam** - Range slider
    - Class: `slider`

18. **field.gleam** - Form field wrapper
    - Class: `field`

19. **form.gleam** - Form container
    - Class: `form`

### Phase 4: Layout Components (Priority 3)

20. **sidebar.gleam** - Sidebar navigation (requires JS)
    - Classes: `sidebar`, `sidebar-content`, `sidebar-trigger`
    - Requires: `sidebar.js`

21. **pagination.gleam** - Pagination
    - Classes: `pagination`, `pagination-ellipsis`

22. **breadcrumb.gleam** - Breadcrumb navigation
    - Class: `breadcrumb`

23. **tabs.gleam** - Tab navigation (requires JS)
    - Classes: `tabs`, `tabs-list`, `tabs-trigger`, `tabs-content`
    - Requires: `tabs.js`

24. **table.gleam** - Table component
    - Classes: `table`, `table-header`, `table-body`, `table-row`, `table-cell`

25. **empty.gleam** - Empty state
    - Class: `empty`

### Phase 5: Overlay Components (Priority 4)

26. **dialog.gleam** - Modal dialog
    - Class: `dialog`
    - Structure: trigger, header, section, footer, close button

27. **alert_dialog.gleam** - Confirmation dialog
    - Extends dialog with specific patterns

28. **dropdown_menu.gleam** - Dropdown menu (requires JS)
    - Classes: `dropdown`, `dropdown-content`, `dropdown-item`
    - Requires: `dropdown-menu.js`

29. **popover.gleam** - Popover (requires JS)
    - Class: `popover`
    - Requires: `popover.js`

30. **tooltip.gleam** - Tooltip
    - Class: `tooltip`

### Phase 6: Advanced Components (Priority 5)

31. **accordion.gleam** - Collapsible accordion
    - Classes: `accordion`, `accordion-item`, `accordion-trigger`, `accordion-content`

32. **command.gleam** - Command palette
    - Class: `command`

33. **combobox.gleam** - Combo box input
    - Class: `combobox`

34. **item.gleam** - List item
    - Class: `item`

35. **toast.gleam** - Toast notification (requires JS)
    - Classes: `toast`, `toaster`
    - Requires: `toast.js`
    - FFI needed for client-side toast dispatch

36. **theme_switcher.gleam** - Theme toggle
    - Class: `theme-switcher`

## Component Implementation Pattern

Each component should follow the glaze_oat pattern:

```gleam
//// Basecoat documentation: <https://basecoatui.com/components/button/>
////
//// The [`button`](#button) helpers style interactive actions.
////
//// ## Variants
////
//// - [`primary`](#primary) - Primary button (default `btn`)
//// - [`secondary`](#secondary) - Secondary button
//// - [`destructive`](#destructive) - Destructive/danger button
//// - [`outline`](#outline) - Outline button
//// - [`ghost`](#ghost) - Ghost button
//// - [`link`](#link) - Link-styled button
////
//// ## Sizes
////
//// - [`small`](#small) - Small button
//// - [`large`](#large) - Large button

import lustre/attribute.{type Attribute}
import lustre/element.{type Element}
import lustre/element/html

/// Render a primary button.
pub fn button(
  attrs: List(Attribute(msg)),
  children: List(Element(msg)),
) -> Element(msg) {
  html.button([attribute.class("btn"), ..attrs], children)
}

/// Render a secondary button.
pub fn secondary() -> Attribute(msg) {
  attribute.class("btn-secondary")
}

/// Render a destructive button.
pub fn destructive() -> Attribute(msg) {
  attribute.class("btn-destructive")
}

// ... etc
```

## Theme System

Basecoat uses shadcn/ui compatible CSS variables. The theme module should support:

```gleam
pub type Token {
  Background
  Foreground
  Card
  CardForeground
  Primary
  PrimaryForeground
  Secondary
  SecondaryForeground
  Muted
  MutedForeground
  Accent
  AccentForeground
  Destructive
  DestructiveForeground
  Border
  Input
  Ring
  Radius
  // ... more tokens
}
```

## CDN Registration

```gleam
pub const version = "0.3.11"

pub fn register(version: String) -> Element(a) {
  element.fragment([
    html.link([
      attribute.rel("stylesheet"),
      attribute.href(
        "https://cdn.jsdelivr.net/npm/basecoat-css@" <> version <> "/dist/basecoat.cdn.min.css"
      ),
    ]),
    html.script(
      [
        attribute.defer("defer"),
        attribute.src(
          "https://cdn.jsdelivr.net/npm/basecoat-css@" <> version <> "/dist/js/all.min.js"
        ),
      ],
      "",
    ),
  ])
}
```

## JavaScript Components

Components requiring JavaScript:
- **dropdown_menu** - Dropdown menu interactions
- **popover** - Popover positioning and display
- **select** - Custom select dropdown
- **sidebar** - Sidebar toggle and responsive behavior
- **tabs** - Tab switching
- **toast** - Toast notifications and auto-dismiss

These need either:
1. CDN script inclusion (automatic with `register()`)
2. FFI for client-side interactions (like toast dispatch)

## Kitchen Sink Demo

The dev module should create a comprehensive demo similar to Basecoat's [kitchen sink](https://basecoatui.com/kitchen-sink):

1. Navigation sidebar with component links
2. Each component section with multiple examples
3. Theme switcher
4. Responsive layout

## Testing Strategy

1. Unit tests for attribute helpers
2. Visual testing via kitchen sink demo
3. Cross-browser testing (via opening HTML file)

## Documentation

Each module should include:
- Link to Basecoat documentation
- Usage examples in doc comments
- Anatomy diagrams (in comments)
- Recipe examples for common patterns

## Notes

1. **Tailwind Dependency**: Unlike glaze_oat, users need Tailwind CSS unless using CDN
2. **Class Composition**: Basecoat uses multiple classes (e.g., `btn-sm btn-outline`)
3. **JavaScript Events**: Some components dispatch custom events (e.g., `basecoat:toast`)
4. **Icons**: Basecoat uses Lucide icons - users need to provide their own SVG icons

## Implementation Order

### Sprint 1: Foundation
1. Update gleam.toml
2. Main module with register()
3. Theme module
4. Button component
5. Badge component

### Sprint 2: Core Components
6. Card component
7. Alert component
8. Avatar component
9. Skeleton component
10. Spinner component
11. Progress component

### Sprint 3: Form Components
12. Input component
13. Textarea component
14. Checkbox component
15. Switch component
16. Label component
17. Field component
18. Form component

### Sprint 4: Layout
19. Sidebar component
20. Breadcrumb component
21. Pagination component
22. Tabs component
23. Table component

### Sprint 5: Overlays
24. Dialog component
25. Alert Dialog component
26. Dropdown Menu component
27. Popover component
28. Tooltip component

### Sprint 6: Advanced
29. Accordion component
30. Select component
31. Combobox component
32. Toast component (with FFI)
33. Command component
34. Radio Group component
35. Slider component
36. Theme Switcher component
37. Empty component
38. Item component
39. Kbd component
40. Kitchen sink demo

## Questions to Clarify

1. Should we provide a Tailwind CSS integration helper, or assume users handle Tailwind separately?
2. Do we want to provide icon helpers (Lucide), or just document that users need to provide SVGs?
3. Should toast FFI work both client-side and server-side (like glaze_oat)?
4. Do we want to provide shadcn/ui theme presets as Gleam constants?

## Progress Tracking

| Component | Status | Notes |
|-----------|--------|-------|
| Project setup | Pending | |
| Theme | Pending | |
| Button | Pending | |
| Badge | Pending | |
| Card | Pending | |
| Alert | Pending | |
| Avatar | Pending | |
| Skeleton | Pending | |
| Spinner | Pending | |
| Progress | Pending | |
| Input | Pending | |
| Textarea | Pending | |
| Checkbox | Pending | |
| Switch | Pending | |
| Label | Pending | |
| Field | Pending | |
| Form | Pending | |
| Sidebar | Pending | |
| Breadcrumb | Pending | |
| Pagination | Pending | |
| Tabs | Pending | |
| Table | Pending | |
| Dialog | Pending | |
| Alert Dialog | Pending | |
| Dropdown Menu | Pending | |
| Popover | Pending | |
| Tooltip | Pending | |
| Accordion | Pending | |
| Select | Pending | |
| Combobox | Pending | |
| Toast | Pending | |
| Command | Pending | |
| Radio Group | Pending | |
| Slider | Pending | |
| Theme Switcher | Pending | |
| Empty | Pending | |
| Item | Pending | |
| Kbd | Pending | |
| Kitchen Sink | Pending | |
