import SwiftUI

/// Controls which appearance palette the design system uses.
public enum ThemeMode: Sendable {
    /// Follow the device light / dark setting.
    ///
    /// Colors are **adaptive** — they switch automatically at render time.
    /// Do not read from a single fixed palette when this mode is active.
    case system

    /// Always use the light palette, regardless of device setting.
    case light

    /// Always use the dark palette, regardless of device setting.
    case dark

    public var preferredColorScheme: ColorScheme? {
        switch self {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }

    /// Maps this mode to a concrete ``ColorScheme`` for palette lookup.
    public func resolvedColorScheme(system systemColorScheme: ColorScheme) -> ColorScheme {
        switch self {
        case .system: systemColorScheme
        case .light: .light
        case .dark: .dark
        }
    }
}
