**Note**: Save agent instructions to AGENTS.md files (this file), not CLAUDE.md.

## Overview

ColorKit is a reusable Swift Package providing cross-platform color utilities for iOS, macOS, visionOS, and watchOS. Swift 6 language mode, minimum iOS 16 / macOS 13 / visionOS 2 / watchOS 10.

## Build

```bash
swift build
```

No tests are configured in this package.

## Architecture

Two library targets:

- **ColorKit** — Core color types and extensions (no UI dependency beyond SwiftUI `Color`)
- **ColorKitUI** — SwiftUI view components that depend on ColorKit

### Key types

- `ColorProvider` — Serializable enum (`RawRepresentable`, `Codable`) that represents a color source: hex RGB, hex RGBA, asset catalog name, or Apple system color. Serialized as `"prefix|value"` strings.
- `ShadeVariationColor` / `UtilityColor` — Semantic color palettes (success, error, warning, etc.) with light/dark shade variants (50/100/200/500/700).
- `PlatformColor` — Type alias resolving to `UIColor` (UIKit) or `NSColor` (AppKit), used internally for hex parsing and color space conversions.

### Platform bridging pattern

The package uses `#if canImport(UIKit)` / `#if os(macOS)` conditional compilation throughout. UIKit-based hex parsing lives in `UIColor+Extension.swift`, AppKit equivalent in `NSColor+Ext.swift`. System color constants (`Color.systemBackground`, `Color.systemGray2`, etc.) are defined separately per platform in `SystemColor+iOS.swift` and `SystemColor+macOS.swift` — on macOS these often reference bundled `.xcassets` color sets via `.module` bundle.

### Color space math

`ColorSpaces.swift` (sourced from `timrwood/ColorSpaces`) implements RGB ↔ XYZ ↔ LAB ↔ LCH conversions with interpolation (`lerp`). These power the `Color.change(_:by:)` / `Color.change(_:to:)` API for programmatic color manipulation via HSB, RGB, or HLC attributes.

### `Color` is `Codable`

`Color+Extension.swift` adds `Codable` conformance to SwiftUI `Color`, encoding/decoding as hex strings (RGBA).

## Conventions

- File headers use `//  Created by {Name} on DD/MM/YYYY.` format
- This is a standalone reusable package shared across multiple apps
