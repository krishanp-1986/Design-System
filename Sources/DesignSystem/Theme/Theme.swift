import CoreGraphics
import SwiftUI

/// Runtime design tokens resolved from JSON or built-in defaults.
public struct Theme: Sendable {
    public let name: String
    public let version: String
    public let colors: ColorTokens
    public let typography: TypographyTokens
    public let spacing: SpacingTokens
    public let radius: RadiusTokens
    public let shadows: ShadowTokens
    public let components: ComponentTokenValues

    public init(tokens: DesignTokenJSON) {
        name = tokens.name
        version = tokens.version
        colors = ColorTokens(
            light: ColorPalette(tokens.appearance.light.colors),
            dark: ColorPalette(tokens.appearance.dark.colors)
        )
        typography = TypographyTokens(tokens.typography)
        spacing = SpacingTokens(tokens.spacing)
        radius = RadiusTokens(tokens.radius)
        shadows = ShadowTokens(
            light: ShadowPalette(tokens.appearance.light.shadows),
            dark: ShadowPalette(tokens.appearance.dark.shadows)
        )
        components = ComponentTokenValues(tokens.components)
    }

    public init(json data: Data) throws {
        let decoder = JSONDecoder()
        let tokens = try decoder.decode(DesignTokenJSON.self, from: data)
        self.init(tokens: tokens)
    }

    public init(json string: String) throws {
        guard let data = string.data(using: .utf8) else {
            throw DesignSystemError.invalidJSONString
        }
        try self.init(json: data)
    }

    public init(jsonURL url: URL) throws {
        let data = try Data(contentsOf: url)
        try self.init(json: data)
    }

    public init(jsonResource name: String, bundle: Bundle) throws {
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            throw DesignSystemError.missingResource(name)
        }
        try self.init(jsonURL: url)
    }

    public func colorPalette(for colorScheme: ColorScheme) -> ColorPalette {
        colors.palette(for: colorScheme)
    }

    public func colorPalette(for mode: ThemeMode, systemColorScheme: ColorScheme) -> ColorPalette {
        colors.palette(for: mode.resolvedColorScheme(system: systemColorScheme))
    }

    public func shadowPalette(for colorScheme: ColorScheme) -> ShadowPalette {
        colorScheme == .dark ? shadows.dark : shadows.light
    }

    public func shadowPalette(for mode: ThemeMode, systemColorScheme: ColorScheme) -> ShadowPalette {
        shadowPalette(for: mode.resolvedColorScheme(system: systemColorScheme))
    }

    public static let `default`: Theme = {
        do {
            return try Theme(jsonResource: "tokens", bundle: .module)
        } catch {
            fatalError("DesignSystem: failed to load default tokens.json — \(error)")
        }
    }()
}

// MARK: - Color tokens

public struct ColorPalette: Sendable {
    public let accent: Color
    public let action: Color
    public let backgroundPrimary: Color
    public let backgroundSecondary: Color
    public let surface: Color
    public let textPrimary: Color
    public let textSecondary: Color
    public let textTertiary: Color
    public let textOnAction: Color
    public let textOnAccent: Color
    public let border: Color
    public let borderSubtle: Color
    public let statusOpenBackground: Color
    public let statusOpenForeground: Color
    public let statusWarningBackground: Color
    public let statusWarningForeground: Color
    public let iconInactive: Color
    public let iconButtonBackground: Color
    public let rating: Color
    public let mapPin: Color
    public let mapPinGlyph: Color

    init(_ json: DesignTokenJSON.ColorsJSON) {
        accent = Color(hexString: json.accent)
        action = Color(hexString: json.action)
        backgroundPrimary = Color(hexString: json.backgroundPrimary)
        backgroundSecondary = Color(hexString: json.backgroundSecondary)
        surface = Color(hexString: json.surface)
        textPrimary = Color(hexString: json.textPrimary)
        textSecondary = Color(hexString: json.textSecondary)
        textTertiary = Color(hexString: json.textTertiary)
        textOnAction = Color(hexString: json.textOnAction)
        textOnAccent = Color(hexString: json.textOnAccent)
        border = Color(hexString: json.border)
        borderSubtle = Color(hexString: json.borderSubtle)
        statusOpenBackground = Color(hexString: json.statusOpenBackground)
        statusOpenForeground = Color(hexString: json.statusOpenForeground)
        statusWarningBackground = Color(hexString: json.statusWarningBackground)
        statusWarningForeground = Color(hexString: json.statusWarningForeground)
        iconInactive = Color(hexString: json.iconInactive)
        iconButtonBackground = Color(hexString: json.iconButtonBackground)
        rating = Color(hexString: json.rating)
        mapPin = Color(hexString: json.mapPin)
        mapPinGlyph = Color(hexString: json.mapPinGlyph)
    }
}

public struct ColorTokens: Sendable {
    public let light: ColorPalette
    public let dark: ColorPalette

    public var accent: Color { .adaptive(light: light.accent, dark: dark.accent) }
    public var action: Color { .adaptive(light: light.action, dark: dark.action) }
    public var backgroundPrimary: Color { .adaptive(light: light.backgroundPrimary, dark: dark.backgroundPrimary) }
    public var backgroundSecondary: Color { .adaptive(light: light.backgroundSecondary, dark: dark.backgroundSecondary) }
    public var surface: Color { .adaptive(light: light.surface, dark: dark.surface) }
    public var textPrimary: Color { .adaptive(light: light.textPrimary, dark: dark.textPrimary) }
    public var textSecondary: Color { .adaptive(light: light.textSecondary, dark: dark.textSecondary) }
    public var textTertiary: Color { .adaptive(light: light.textTertiary, dark: dark.textTertiary) }
    public var textOnAction: Color { .adaptive(light: light.textOnAction, dark: dark.textOnAction) }
    public var textOnAccent: Color { .adaptive(light: light.textOnAccent, dark: dark.textOnAccent) }
    public var border: Color { .adaptive(light: light.border, dark: dark.border) }
    public var borderSubtle: Color { .adaptive(light: light.borderSubtle, dark: dark.borderSubtle) }
    public var statusOpenBackground: Color { .adaptive(light: light.statusOpenBackground, dark: dark.statusOpenBackground) }
    public var statusOpenForeground: Color { .adaptive(light: light.statusOpenForeground, dark: dark.statusOpenForeground) }
    public var statusWarningBackground: Color { .adaptive(light: light.statusWarningBackground, dark: dark.statusWarningBackground) }
    public var statusWarningForeground: Color { .adaptive(light: light.statusWarningForeground, dark: dark.statusWarningForeground) }
    public var iconInactive: Color { .adaptive(light: light.iconInactive, dark: dark.iconInactive) }
    public var iconButtonBackground: Color { .adaptive(light: light.iconButtonBackground, dark: dark.iconButtonBackground) }
    public var rating: Color { .adaptive(light: light.rating, dark: dark.rating) }
    public var mapPin: Color { .adaptive(light: light.mapPin, dark: dark.mapPin) }
    public var mapPinGlyph: Color { .adaptive(light: light.mapPinGlyph, dark: dark.mapPinGlyph) }

    public func palette(for colorScheme: ColorScheme) -> ColorPalette {
        colorScheme == .dark ? dark : light
    }

    public func fixedPalette(for mode: ThemeMode) -> ColorPalette? {
        switch mode {
        case .system: nil
        case .light: light
        case .dark: dark
        }
    }

    public func resolvedColor(
        _ paletteKeyPath: KeyPath<ColorPalette, Color>,
        appearanceMode: ThemeMode,
        adaptive adaptiveKeyPath: KeyPath<ColorTokens, Color>
    ) -> Color {
        switch appearanceMode {
        case .system:
            return self[keyPath: adaptiveKeyPath]
        case .light:
            return light[keyPath: paletteKeyPath]
        case .dark:
            return dark[keyPath: paletteKeyPath]
        }
    }
}

// MARK: - Typography, spacing, radius, components

public struct TypographyTokens: Sendable {
    public let largeTitle: Font
    public let sectionTitle: Font
    public let cardTitle: Font
    public let body: Font
    public let bodyMedium: Font
    public let subtext: Font
    public let caption: Font
    public let tabLabel: Font
    public let button: Font
    public let buttonSmall: Font
    public let searchInput: Font

    init(_ json: DesignTokenJSON.TypographyJSON) {
        largeTitle = Font.from(json.largeTitle)
        sectionTitle = Font.from(json.sectionTitle)
        cardTitle = Font.from(json.cardTitle)
        body = Font.from(json.body)
        bodyMedium = Font.from(json.bodyMedium)
        subtext = Font.from(json.subtext)
        caption = Font.from(json.caption)
        tabLabel = Font.from(json.tabLabel)
        button = Font.from(json.button)
        buttonSmall = Font.from(json.buttonSmall)
        searchInput = Font.from(json.searchInput)
    }
}

public struct SpacingTokens: Sendable {
    public let xxs: CGFloat
    public let xs: CGFloat
    public let sm: CGFloat
    public let md: CGFloat
    public let lg: CGFloat
    public let xl: CGFloat
    public let xxl: CGFloat
    public let screenHorizontal: CGFloat
    public let sectionGap: CGFloat
    public let listItemGap: CGFloat
    public let cardPadding: CGFloat
    public let cardPaddingLarge: CGFloat
    public let buttonVertical: CGFloat
    public let searchHorizontal: CGFloat
    public let tabIconGap: CGFloat
    public let chipIconGap: CGFloat

    init(_ json: DesignTokenJSON.SpacingJSON) {
        xxs = json.xxs
        xs = json.xs
        sm = json.sm
        md = json.md
        lg = json.lg
        xl = json.xl
        xxl = json.xxl
        screenHorizontal = json.screenHorizontal
        sectionGap = json.sectionGap
        listItemGap = json.listItemGap
        cardPadding = json.cardPadding
        cardPaddingLarge = json.cardPaddingLarge
        buttonVertical = json.buttonVertical
        searchHorizontal = json.searchHorizontal
        tabIconGap = json.tabIconGap
        chipIconGap = json.chipIconGap
    }
}

public struct RadiusTokens: Sendable {
    public let cardLarge: CGFloat
    public let cardSmall: CGFloat
    public let button: CGFloat
    public let input: CGFloat
    public let pill: CGFloat
    public let iconButton: CGFloat
    public let thumbnail: CGFloat

    init(_ json: DesignTokenJSON.RadiusJSON) {
        cardLarge = json.cardLarge
        cardSmall = json.cardSmall
        button = json.button
        input = json.input
        pill = json.pill
        iconButton = json.iconButton
        thumbnail = json.thumbnail
    }
}

public struct ShadowStyle: Sendable {
    public let color: Color
    public let radius: CGFloat
    public let x: CGFloat
    public let y: CGFloat

    public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
        self.color = color
        self.radius = radius
        self.x = x
        self.y = y
    }

    init(_ json: DesignTokenJSON.ShadowStyleJSON) {
        self.init(
            color: Color(hexString: json.color, opacity: json.opacity),
            radius: json.radius,
            x: json.x,
            y: json.y
        )
    }
}

public struct ShadowPalette: Sendable {
    public let card: ShadowStyle
    public let cardSmall: ShadowStyle
    public let map: ShadowStyle

    init(_ json: DesignTokenJSON.ShadowsJSON) {
        card = ShadowStyle(json.card)
        cardSmall = ShadowStyle(json.cardSmall)
        map = ShadowStyle(json.map)
    }
}

public struct ShadowTokens: Sendable {
    public let light: ShadowPalette
    public let dark: ShadowPalette

    public var card: AdaptiveShadowStyle { AdaptiveShadowStyle(light: light.card, dark: dark.card) }
    public var cardSmall: AdaptiveShadowStyle { AdaptiveShadowStyle(light: light.cardSmall, dark: dark.cardSmall) }
    public var map: AdaptiveShadowStyle { AdaptiveShadowStyle(light: light.map, dark: dark.map) }

    public func palette(for colorScheme: ColorScheme) -> ShadowPalette {
        colorScheme == .dark ? dark : light
    }
}

public struct AdaptiveShadowStyle: Sendable {
    public let light: ShadowStyle
    public let dark: ShadowStyle

    public init(light: ShadowStyle, dark: ShadowStyle) {
        self.light = light
        self.dark = dark
    }

    public func resolved(for colorScheme: ColorScheme) -> ShadowStyle {
        colorScheme == .dark ? dark : light
    }

    public func resolved(appearanceMode: ThemeMode, systemColorScheme: ColorScheme) -> ShadowStyle {
        resolved(for: appearanceMode.resolvedColorScheme(system: systemColorScheme))
    }
}

public struct ComponentTokenValues: Sendable {
    public let primaryButtonHeight: CGFloat
    public let iconButtonSize: CGFloat
    public let cafeCardImageWidth: CGFloat
    public let cafeCardImageHeight: CGFloat
    public let savedCardImageSize: CGFloat
    public let mapPreviewHeight: CGFloat
    public let tabBarHeight: CGFloat
    public let tabBarIconSize: CGFloat
    public let searchBarHeight: CGFloat
    public let tagVerticalPadding: CGFloat
    public let tagHorizontalPadding: CGFloat
    public let chipHeight: CGFloat

    init(_ json: DesignTokenJSON.ComponentsJSON) {
        primaryButtonHeight = json.primaryButtonHeight
        iconButtonSize = json.iconButtonSize
        cafeCardImageWidth = json.cafeCardImageWidth
        cafeCardImageHeight = json.cafeCardImageHeight
        savedCardImageSize = json.savedCardImageSize
        mapPreviewHeight = json.mapPreviewHeight
        tabBarHeight = json.tabBarHeight
        tabBarIconSize = json.tabBarIconSize
        searchBarHeight = json.searchBarHeight
        tagVerticalPadding = json.tagVerticalPadding
        tagHorizontalPadding = json.tagHorizontalPadding
        chipHeight = json.chipHeight
    }
}

extension Font {
    static func from(_ style: DesignTokenJSON.FontStyleJSON) -> Font {
        let weight = Font.Weight.from(style.weight)
        let design = Font.Design.from(style.design)
        return .system(size: style.size, weight: weight, design: design)
    }
}

extension Font.Weight {
    static func from(_ value: String) -> Font.Weight {
        switch value.lowercased() {
        case "ultralight": return .ultraLight
        case "thin": return .thin
        case "light": return .light
        case "regular": return .regular
        case "medium": return .medium
        case "semibold": return .semibold
        case "bold": return .bold
        case "heavy": return .heavy
        case "black": return .black
        default: return .regular
        }
    }
}

extension Font.Design {
    static func from(_ value: String?) -> Font.Design {
        switch value?.lowercased() {
        case "rounded": return .rounded
        case "serif": return .serif
        case "monospaced": return .monospaced
        default: return .default
        }
    }
}

public enum DesignSystemError: Error, LocalizedError {
    case invalidJSONString
    case missingResource(String)

    public var errorDescription: String? {
        switch self {
        case .invalidJSONString:
            "The provided JSON string could not be encoded as UTF-8 data."
        case .missingResource(let name):
            "Design token resource '\(name).json' was not found in the bundle."
        }
    }
}
