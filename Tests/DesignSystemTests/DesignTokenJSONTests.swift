import Testing
@testable import DesignSystem

@Suite("Design Token JSON")
struct DesignTokenJSONTests {
    @Test func decodesBundledTokens() throws {
        let theme = try Theme(jsonResource: "tokens", bundle: .module)
        #expect(theme.name == "Cafe Finder")
        #expect(theme.version == "2.0.0")
    }

    @Test func decodesLegacyFlatColorFormat() throws {
        let json = """
        {
          "name": "Legacy",
          "version": "1.0.0",
          "colors": {
            "accent": "#B85C38",
            "action": "#251A14",
            "backgroundPrimary": "#FFFFFF",
            "backgroundSecondary": "#F5F3F0",
            "surface": "#FFFFFF",
            "textPrimary": "#1A1A1A",
            "textSecondary": "#757575",
            "textTertiary": "#999999",
            "textOnAction": "#FFFFFF",
            "textOnAccent": "#FFFFFF",
            "border": "#E0E0E0",
            "borderSubtle": "#EEEEEE",
            "statusOpenBackground": "#E6F4EA",
            "statusOpenForeground": "#2E7D32",
            "statusWarningBackground": "#FFF0E6",
            "statusWarningForeground": "#C45C26",
            "iconInactive": "#9E9E9E",
            "iconButtonBackground": "#F0F0F0",
            "rating": "#F5A623",
            "mapPin": "#B85C38",
            "mapPinGlyph": "#FFFFFF"
          },
          "shadows": {
            "card": { "color": "#000000", "opacity": 0.08, "radius": 8, "x": 0, "y": 2 },
            "cardSmall": { "color": "#000000", "opacity": 0.06, "radius": 4, "x": 0, "y": 1 },
            "map": { "color": "#000000", "opacity": 0.10, "radius": 12, "x": 0, "y": 4 }
          },
          "typography": {
            "largeTitle": { "size": 24, "weight": "bold", "design": "default" },
            "sectionTitle": { "size": 18, "weight": "semibold", "design": "default" },
            "cardTitle": { "size": 16, "weight": "semibold", "design": "default" },
            "body": { "size": 15, "weight": "regular", "design": "default" },
            "bodyMedium": { "size": 14, "weight": "medium", "design": "default" },
            "subtext": { "size": 13, "weight": "regular", "design": "default" },
            "caption": { "size": 12, "weight": "regular", "design": "default" },
            "tabLabel": { "size": 10, "weight": "medium", "design": "default" },
            "button": { "size": 16, "weight": "semibold", "design": "default" },
            "buttonSmall": { "size": 14, "weight": "semibold", "design": "default" },
            "searchInput": { "size": 15, "weight": "regular", "design": "default" }
          },
          "spacing": {
            "xxs": 4, "xs": 8, "sm": 12, "md": 16, "lg": 20, "xl": 24, "xxl": 32,
            "screenHorizontal": 16, "sectionGap": 24, "listItemGap": 12,
            "cardPadding": 12, "cardPaddingLarge": 16, "buttonVertical": 14,
            "searchHorizontal": 12, "tabIconGap": 4, "chipIconGap": 6
          },
          "radius": {
            "cardLarge": 16, "cardSmall": 12, "button": 12, "input": 12,
            "pill": 999, "iconButton": 20, "thumbnail": 10
          },
          "components": {
            "primaryButtonHeight": 48, "iconButtonSize": 40,
            "cafeCardImageWidth": 80, "cafeCardImageHeight": 80,
            "savedCardImageSize": 100, "mapPreviewHeight": 180,
            "tabBarHeight": 56, "tabBarIconSize": 24, "searchBarHeight": 44,
            "tagVerticalPadding": 4, "tagHorizontalPadding": 10, "chipHeight": 32
          }
        }
        """

        let theme = try Theme(json: json)
        #expect(theme.name == "Legacy")
        #expect(theme.spacing.md == 16)
        #expect(theme.radius.cardLarge == 16)
    }
}
