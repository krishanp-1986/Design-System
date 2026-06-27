import CoreGraphics

public enum Radius {
    private static var tokens: RadiusTokens { DesignSystem.shared.theme.radius }

    public static var cardLarge: CGFloat { tokens.cardLarge }
    public static var cardSmall: CGFloat { tokens.cardSmall }
    public static var button: CGFloat { tokens.button }
    public static var input: CGFloat { tokens.input }
    public static var pill: CGFloat { tokens.pill }
    public static var iconButton: CGFloat { tokens.iconButton }
    public static var thumbnail: CGFloat { tokens.thumbnail }
}
