import Foundation

/// Codable representation of a design token JSON file.
public struct DesignTokenJSON: Codable, Sendable {
    public let name: String
    public let version: String
    public let appearance: AppearanceJSON
    public let typography: TypographyJSON
    public let spacing: SpacingJSON
    public let radius: RadiusJSON
    public let components: ComponentsJSON

    public struct AppearanceJSON: Codable, Sendable {
        public let light: AppearanceVariantJSON
        public let dark: AppearanceVariantJSON
    }

    public struct AppearanceVariantJSON: Codable, Sendable {
        public let colors: ColorsJSON
        public let shadows: ShadowsJSON
    }

    public struct ColorsJSON: Codable, Sendable {
        public let accent: String
        public let action: String
        public let backgroundPrimary: String
        public let backgroundSecondary: String
        public let surface: String
        public let textPrimary: String
        public let textSecondary: String
        public let textTertiary: String
        public let textOnAction: String
        public let textOnAccent: String
        public let border: String
        public let borderSubtle: String
        public let statusOpenBackground: String
        public let statusOpenForeground: String
        public let statusWarningBackground: String
        public let statusWarningForeground: String
        public let iconInactive: String
        public let iconButtonBackground: String
        public let rating: String
        public let mapPin: String
        public let mapPinGlyph: String
    }

    public struct FontStyleJSON: Codable, Sendable {
        public let size: CGFloat
        public let weight: String
        public let design: String?
    }

    public struct TypographyJSON: Codable, Sendable {
        public let largeTitle: FontStyleJSON
        public let sectionTitle: FontStyleJSON
        public let cardTitle: FontStyleJSON
        public let body: FontStyleJSON
        public let bodyMedium: FontStyleJSON
        public let subtext: FontStyleJSON
        public let caption: FontStyleJSON
        public let tabLabel: FontStyleJSON
        public let button: FontStyleJSON
        public let buttonSmall: FontStyleJSON
        public let searchInput: FontStyleJSON
    }

    public struct SpacingJSON: Codable, Sendable {
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
    }

    public struct RadiusJSON: Codable, Sendable {
        public let cardLarge: CGFloat
        public let cardSmall: CGFloat
        public let button: CGFloat
        public let input: CGFloat
        public let pill: CGFloat
        public let iconButton: CGFloat
        public let thumbnail: CGFloat
    }

    public struct ShadowStyleJSON: Codable, Sendable {
        public let color: String
        public let opacity: Double
        public let radius: CGFloat
        public let x: CGFloat
        public let y: CGFloat
    }

    public struct ShadowsJSON: Codable, Sendable {
        public let card: ShadowStyleJSON
        public let cardSmall: ShadowStyleJSON
        public let map: ShadowStyleJSON
    }

    public struct ComponentsJSON: Codable, Sendable {
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
    }

    private enum CodingKeys: String, CodingKey {
        case name, version, appearance, colors, shadows, typography, spacing, radius, components
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        version = try container.decode(String.self, forKey: .version)
        typography = try container.decode(TypographyJSON.self, forKey: .typography)
        spacing = try container.decode(SpacingJSON.self, forKey: .spacing)
        radius = try container.decode(RadiusJSON.self, forKey: .radius)
        components = try container.decode(ComponentsJSON.self, forKey: .components)

        if let appearance = try container.decodeIfPresent(AppearanceJSON.self, forKey: .appearance) {
            self.appearance = appearance
        } else {
            let colors = try container.decode(ColorsJSON.self, forKey: .colors)
            let shadows = try container.decode(ShadowsJSON.self, forKey: .shadows)
            let variant = AppearanceVariantJSON(colors: colors, shadows: shadows)
            self.appearance = AppearanceJSON(light: variant, dark: variant)
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(version, forKey: .version)
        try container.encode(appearance, forKey: .appearance)
        try container.encode(typography, forKey: .typography)
        try container.encode(spacing, forKey: .spacing)
        try container.encode(radius, forKey: .radius)
        try container.encode(components, forKey: .components)
    }
}
