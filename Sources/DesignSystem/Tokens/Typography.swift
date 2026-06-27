import SwiftUI

public enum Typography {
    private static var tokens: TypographyTokens { DesignSystem.shared.theme.typography }

    public static var largeTitle: Font { tokens.largeTitle }
    public static var sectionTitle: Font { tokens.sectionTitle }
    public static var cardTitle: Font { tokens.cardTitle }
    public static var body: Font { tokens.body }
    public static var bodyMedium: Font { tokens.bodyMedium }
    public static var subtext: Font { tokens.subtext }
    public static var caption: Font { tokens.caption }
    public static var tabLabel: Font { tokens.tabLabel }
    public static var button: Font { tokens.button }
    public static var buttonSmall: Font { tokens.buttonSmall }
    public static var searchInput: Font { tokens.searchInput }
}
