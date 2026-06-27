# DesignSystem

A SwiftUI design token library for iOS apps. Tokens are defined in JSON, loaded at runtime, and exposed through type-safe Swift APIs for colors, typography, spacing, radius, shadows, and component sizing.

Originally built for [Cafe Finder](https://github.com/krishanp-1986/Cafe-Finder) and reusable in any SwiftUI project that needs a consistent, themeable visual language.

**Repository:** [github.com/krishanp-1986/Design-System](https://github.com/krishanp-1986/Design-System)

## Features

- **JSON-driven tokens** — edit `tokens.json` without recompiling Swift for most design changes
- **Light & dark appearance** — separate palettes with adaptive colors that follow the system, or force light/dark mode
- **Ergonomic APIs** — `Colors.accent`, `Typography.body`, `Spacing.md`, `Radius.cardLarge`, and more
- **Component sizing** — shared dimensions for buttons, cards, search bars, tab bars, and map previews
- **Token catalog** — `TokenCatalogView` for previews, QA, and snapshot testing
- **Demo app** — runnable gallery of all tokens via the `DesignSystemDemo` executable
- **Test coverage** — unit tests (Swift Testing) and snapshot tests

## Requirements

| | |
|---|---|
| **Platforms** | iOS 17+ |
| **Swift** | 6.0+ |
| **Xcode** | 16+ recommended |

## Installation

Add the package with Swift Package Manager.

### Xcode

1. **File → Add Package Dependencies…**
2. Enter `https://github.com/krishanp-1986/Design-System`
3. Choose a version (or branch) and add the **DesignSystem** library product to your app target

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/krishanp-1986/Design-System", from: "2.0.0"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "DesignSystem", package: "DesignSystem"),
        ]
    ),
]
```

## Quick start

Configure the design system once at app launch, then use token enums in your views.

```swift
import DesignSystem
import SwiftUI

@main
struct MyApp: App {
    init() {
        DesignSystem.configure(theme: .default, appearanceMode: .system)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

```swift
import DesignSystem
import SwiftUI

struct CafeCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Harbour Coffee")
                .font(Typography.cardTitle)
                .foregroundStyle(Colors.textPrimary)

            Text("12 Sea Road")
                .font(Typography.caption)
                .foregroundStyle(Colors.textSecondary)
        }
        .padding(Spacing.md)
        .background(Colors.surface)
        .clipShape(RoundedRectangle(cornerRadius: Radius.cardSmall))
        .dsShadow(Shadow.cardSmall)
    }
}
```

## Token reference

### Colors

Semantic colors resolve for the current appearance mode (system, light, or dark).

| Token | Usage |
|---|---|
| `Colors.accent` | Brand accent (map pins, highlights) |
| `Colors.action` | Primary actions and buttons |
| `Colors.backgroundPrimary` | Main screen background |
| `Colors.backgroundSecondary` | Grouped / secondary backgrounds |
| `Colors.surface` | Cards and elevated surfaces |
| `Colors.textPrimary` | Headings and primary text |
| `Colors.textSecondary` | Supporting text |
| `Colors.textTertiary` | Placeholders and hints |
| `Colors.border` / `Colors.borderSubtle` | Dividers and outlines |
| `Colors.statusOpen*` / `Colors.statusWarning*` | Status badges |
| `Colors.rating` | Star ratings |
| `Colors.mapPin` / `Colors.mapPinGlyph` | Map markers |

### Typography

| Token | Typical use |
|---|---|
| `Typography.largeTitle` | Screen titles |
| `Typography.sectionTitle` | Section headers |
| `Typography.cardTitle` | Card headings |
| `Typography.body` / `bodyMedium` | Body copy |
| `Typography.subtext` / `caption` | Metadata, labels |
| `Typography.button` / `buttonSmall` | Button labels |
| `Typography.searchInput` | Search fields |
| `Typography.tabLabel` | Tab bar labels |

### Spacing

Scale tokens (`xxs` → `xxl`) plus layout-specific values:

`screenHorizontal`, `sectionGap`, `listItemGap`, `cardPadding`, `cardPaddingLarge`, `buttonVertical`, `searchHorizontal`, `tabIconGap`, `chipIconGap`

### Radius

`cardLarge`, `cardSmall`, `button`, `input`, `pill`, `iconButton`, `thumbnail`

### Shadows

Apply adaptive shadows with the `dsShadow` view modifier:

```swift
RoundedRectangle(cornerRadius: Radius.cardLarge)
    .dsShadow(Shadow.card)
```

Available styles: `Shadow.card`, `Shadow.cardSmall`, `Shadow.map`

### Component sizing

`ComponentTokens` provides shared layout constants — for example `primaryButtonHeight`, `searchBarHeight`, `mapPreviewHeight`, `cafeCardImageWidth`, and `tabBarHeight`.

## Appearance modes

`ThemeMode` controls how colors and shadows resolve:

| Mode | Behavior |
|---|---|
| `.system` | Follows device light/dark setting; colors are **adaptive** |
| `.light` | Always uses the light palette |
| `.dark` | Always uses the dark palette |

Override appearance for a subtree:

```swift
MySettingsScreen()
    .designThemeMode(.dark)
```

Or configure globally:

```swift
DesignSystem.configure(theme: .default, appearanceMode: .light)
```

## Custom themes

Load tokens from your own JSON file instead of the bundled default.

```swift
try DesignSystem.configure(jsonResource: "my-brand-tokens", bundle: .main)
```

You can also build a `Theme` directly:

```swift
let theme = try Theme(jsonURL: url)
DesignSystem.configure(theme: theme, appearanceMode: .system)
```

### JSON schema

The bundled `Sources/DesignSystem/Resources/tokens.json` is the source of truth. Top-level structure:

```json
{
  "name": "Cafe Finder",
  "version": "2.0.0",
  "appearance": {
    "light": { "colors": { ... }, "shadows": { ... } },
    "dark": { "colors": { ... }, "shadows": { ... } }
  },
  "typography": { ... },
  "spacing": { ... },
  "radius": { ... },
  "components": { ... }
}
```

Colors are hex strings (`#RRGGBB`). Typography entries specify `size`, `weight`, and optional `design` (`default`, `rounded`, `serif`, `monospaced`).

## Token catalog

`TokenCatalogView` renders a scrollable gallery of colors and typography — useful for design review and automated snapshot tests.

```swift
TokenCatalogView(theme: .default)
```

## Demo app

Open the package in Xcode and run the **DesignSystemDemo** scheme, or from the command line:

```bash
swift run DesignSystemDemo
```

The demo loads the default theme and displays `TokenCatalogView`.

## Development

### Project layout

```
Design-System/
├── Package.swift
├── Sources/
│   └── DesignSystem/
│       ├── DesignSystem.swift      # Configuration & environment
│       ├── Theme/                  # Theme, ThemeMode
│       ├── Tokens/                 # Colors, Typography, Spacing, …
│       ├── Catalog/                # TokenCatalogView
│       └── Resources/tokens.json
├── Examples/
│   └── DesignSystemDemo/           # Runnable token gallery
└── Tests/
    ├── DesignSystemTests/          # Unit tests (Swift Testing)
    └── DesignSystemSnapshotTests/  # Snapshot tests
```

### Running tests

From the package directory:

```bash
swift test
```

Or in Xcode: select the **DesignSystem** package and press **⌘U**.

Snapshot tests use [swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing). Re-record snapshots when you intentionally change tokens:

```bash
swift test --filter TokenCatalogSnapshotTests
```

Set `record = true` in the snapshot test file when updating reference images, then revert to `false`.

## Integrating in a host app

### Remote dependency (recommended)

```swift
.package(url: "https://github.com/krishanp-1986/Design-System", from: "2.0.0")
```

### Local checkout (development)

If you have the repo cloned next to your app:

```swift
.package(path: "../Design-System")
```

In Xcode, add the local folder via **Add Local…** and link **DesignSystem** to your app target.

## License

This package is intended for open source distribution. Add an `LICENSE` file before publishing (MIT is a common choice).
