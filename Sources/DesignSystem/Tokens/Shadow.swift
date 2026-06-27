import SwiftUI

public enum Shadow {
    private static var tokens: ShadowTokens { DesignSystem.shared.theme.shadows }

    public static var card: AdaptiveShadowStyle { tokens.card }
    public static var cardSmall: AdaptiveShadowStyle { tokens.cardSmall }
    public static var map: AdaptiveShadowStyle { tokens.map }
}

public extension View {
    func dsShadow(_ style: AdaptiveShadowStyle) -> some View {
        modifier(AdaptiveShadowModifier(style: style))
    }
}

private struct AdaptiveShadowModifier: ViewModifier {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.designThemeMode) private var designThemeMode
    let style: AdaptiveShadowStyle

    func body(content: Content) -> some View {
        let resolved = style.resolved(
            appearanceMode: designThemeMode,
            systemColorScheme: colorScheme
        )
        content.shadow(
            color: resolved.color,
            radius: resolved.radius,
            x: resolved.x,
            y: resolved.y
        )
    }
}
