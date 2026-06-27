import Testing
@testable import DesignSystem

@Suite("Spacing and Components")
struct SpacingAndComponentTests {
    @Test func spacingScale() {
        let spacing = Theme.default.spacing
        #expect(spacing.xxs == 4)
        #expect(spacing.md == 16)
        #expect(spacing.screenHorizontal == spacing.md)
        #expect(spacing.sectionGap == spacing.xl)
    }

    @Test func componentSizes() {
        let components = Theme.default.components
        #expect(components.primaryButtonHeight == 48)
        #expect(components.searchBarHeight == 44)
        #expect(components.tabBarHeight == 56)
    }

    @Test func shadowResolution() {
        let style = Theme.default.shadows.card
        let lightShadow = style.resolved(appearanceMode: .light, systemColorScheme: .dark)
        let darkShadow = style.resolved(appearanceMode: .dark, systemColorScheme: .light)
        #expect(lightShadow.radius == Theme.default.shadows.light.card.radius)
        #expect(darkShadow.radius == Theme.default.shadows.dark.card.radius)
    }
}
