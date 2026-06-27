import Testing
@testable import DesignSystem

@Suite("Color Tokens")
struct ColorTokensTests {
    private let theme = Theme.default

    @Test func fixedPaletteReturnsNilForSystemMode() {
        #expect(theme.colors.fixedPalette(for: .system) == nil)
    }

    @Test func fixedPaletteReturnsCorrectPalette() {
        let light = theme.colors.fixedPalette(for: .light)!
        let dark = theme.colors.fixedPalette(for: .dark)!
        #expect(light.accent == theme.colors.light.accent)
        #expect(dark.accent == theme.colors.dark.accent)
    }

    @Test func paletteForColorScheme() {
        #expect(
            theme.colorPalette(for: .light).backgroundPrimary
                == theme.colors.light.backgroundPrimary
        )
        #expect(
            theme.colorPalette(for: .dark).backgroundPrimary
                == theme.colors.dark.backgroundPrimary
        )
    }

    @Test func resolvedColorSystemModeUsesAdaptivePath() {
        #expect(theme.colors.fixedPalette(for: .system) == nil)
        let _ = theme.colors.resolvedColor(
            \.accent,
            appearanceMode: .system,
            adaptive: \.accent
        )
    }

    @Test func resolvedColorUsesLightPaletteWhenForced() {
        let color = theme.colors.resolvedColor(
            \.accent,
            appearanceMode: .light,
            adaptive: \.accent
        )
        #expect(color == theme.colors.light.accent)
    }

    @Test func resolvedColorUsesDarkPaletteWhenForced() {
        let color = theme.colors.resolvedColor(
            \.accent,
            appearanceMode: .dark,
            adaptive: \.accent
        )
        #expect(color == theme.colors.dark.accent)
    }
}
