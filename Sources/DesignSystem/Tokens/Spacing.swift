import CoreGraphics

public enum Spacing {
    private static var tokens: SpacingTokens { DesignSystem.shared.theme.spacing }

    public static var xxs: CGFloat { tokens.xxs }
    public static var xs: CGFloat { tokens.xs }
    public static var sm: CGFloat { tokens.sm }
    public static var md: CGFloat { tokens.md }
    public static var lg: CGFloat { tokens.lg }
    public static var xl: CGFloat { tokens.xl }
    public static var xxl: CGFloat { tokens.xxl }
    public static var screenHorizontal: CGFloat { tokens.screenHorizontal }
    public static var sectionGap: CGFloat { tokens.sectionGap }
    public static var listItemGap: CGFloat { tokens.listItemGap }
    public static var cardPadding: CGFloat { tokens.cardPadding }
    public static var cardPaddingLarge: CGFloat { tokens.cardPaddingLarge }
    public static var buttonVertical: CGFloat { tokens.buttonVertical }
    public static var searchHorizontal: CGFloat { tokens.searchHorizontal }
    public static var tabIconGap: CGFloat { tokens.tabIconGap }
    public static var chipIconGap: CGFloat { tokens.chipIconGap }
}
