import SwiftUI

public enum Colors {
    private static var tokens: ColorTokens { DesignSystem.shared.theme.colors }
    private static var appearanceMode: ThemeMode { DesignSystem.shared.appearanceMode }

    private static func resolved(
        _ paletteKeyPath: KeyPath<ColorPalette, Color>,
        adaptive adaptiveKeyPath: KeyPath<ColorTokens, Color>
    ) -> Color {
        tokens.resolvedColor(
            paletteKeyPath,
            appearanceMode: appearanceMode,
            adaptive: adaptiveKeyPath
        )
    }

    public static var accent: Color { resolved(\.accent, adaptive: \.accent) }
    public static var action: Color { resolved(\.action, adaptive: \.action) }
    public static var backgroundPrimary: Color { resolved(\.backgroundPrimary, adaptive: \.backgroundPrimary) }
    public static var backgroundSecondary: Color { resolved(\.backgroundSecondary, adaptive: \.backgroundSecondary) }
    public static var surface: Color { resolved(\.surface, adaptive: \.surface) }
    public static var textPrimary: Color { resolved(\.textPrimary, adaptive: \.textPrimary) }
    public static var textSecondary: Color { resolved(\.textSecondary, adaptive: \.textSecondary) }
    public static var textTertiary: Color { resolved(\.textTertiary, adaptive: \.textTertiary) }
    public static var textOnAction: Color { resolved(\.textOnAction, adaptive: \.textOnAction) }
    public static var textOnAccent: Color { resolved(\.textOnAccent, adaptive: \.textOnAccent) }
    public static var border: Color { resolved(\.border, adaptive: \.border) }
    public static var borderSubtle: Color { resolved(\.borderSubtle, adaptive: \.borderSubtle) }
    public static var statusOpenBackground: Color { resolved(\.statusOpenBackground, adaptive: \.statusOpenBackground) }
    public static var statusOpenForeground: Color { resolved(\.statusOpenForeground, adaptive: \.statusOpenForeground) }
    public static var statusWarningBackground: Color { resolved(\.statusWarningBackground, adaptive: \.statusWarningBackground) }
    public static var statusWarningForeground: Color { resolved(\.statusWarningForeground, adaptive: \.statusWarningForeground) }
    public static var iconInactive: Color { resolved(\.iconInactive, adaptive: \.iconInactive) }
    public static var iconButtonBackground: Color { resolved(\.iconButtonBackground, adaptive: \.iconButtonBackground) }
    public static var rating: Color { resolved(\.rating, adaptive: \.rating) }
    public static var mapPin: Color { resolved(\.mapPin, adaptive: \.mapPin) }
    public static var mapPinGlyph: Color { resolved(\.mapPinGlyph, adaptive: \.mapPinGlyph) }
}
