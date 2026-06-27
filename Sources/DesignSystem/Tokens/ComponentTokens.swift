import CoreGraphics

public enum ComponentTokens {
    private static var tokens: ComponentTokenValues { DesignSystem.shared.theme.components }

    public static var primaryButtonHeight: CGFloat { tokens.primaryButtonHeight }
    public static var iconButtonSize: CGFloat { tokens.iconButtonSize }
    public static var cafeCardImageWidth: CGFloat { tokens.cafeCardImageWidth }
    public static var cafeCardImageHeight: CGFloat { tokens.cafeCardImageHeight }
    public static var savedCardImageSize: CGFloat { tokens.savedCardImageSize }
    public static var mapPreviewHeight: CGFloat { tokens.mapPreviewHeight }
    public static var tabBarHeight: CGFloat { tokens.tabBarHeight }
    public static var tabBarIconSize: CGFloat { tokens.tabBarIconSize }
    public static var searchBarHeight: CGFloat { tokens.searchBarHeight }
    public static var tagVerticalPadding: CGFloat { tokens.tagVerticalPadding }
    public static var tagHorizontalPadding: CGFloat { tokens.tagHorizontalPadding }
    public static var chipHeight: CGFloat { tokens.chipHeight }
}
