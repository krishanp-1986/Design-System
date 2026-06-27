import SwiftUI

/// A scrollable gallery of design tokens — used for previews, snapshot tests, and the demo app.
public struct TokenCatalogView: View {
    private let theme: Theme

    public init(theme: Theme = DesignSystem.shared.theme) {
        self.theme = theme
    }

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.sectionGap) {
                Text("Design System")
                    .font(Typography.largeTitle)
                    .foregroundStyle(Colors.textPrimary)
                    .accessibilityIdentifier("designSystem.title")

                colorSection(title: "Brand", keys: [
                    ("Accent", \ColorPalette.accent),
                    ("Action", \ColorPalette.action),
                ])

                colorSection(title: "Background", keys: [
                    ("Primary", \ColorPalette.backgroundPrimary),
                    ("Secondary", \ColorPalette.backgroundSecondary),
                    ("Surface", \ColorPalette.surface),
                ])

                colorSection(title: "Text", keys: [
                    ("Primary", \ColorPalette.textPrimary),
                    ("Secondary", \ColorPalette.textSecondary),
                    ("Tertiary", \ColorPalette.textTertiary),
                ])

                typographySection()
            }
            .padding(Spacing.screenHorizontal)
        }
        .background(Colors.backgroundPrimary)
        .accessibilityIdentifier("designSystem.catalog")
    }

    @ViewBuilder
    private func colorSection(
        title: String,
        keys: [(String, KeyPath<ColorPalette, Color>)]
    ) -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(title)
                .font(Typography.sectionTitle)
                .foregroundStyle(Colors.textPrimary)

            HStack(spacing: Spacing.sm) {
                paletteColumn(label: "Light", palette: theme.colors.light, keys: keys)
                paletteColumn(label: "Dark", palette: theme.colors.dark, keys: keys)
            }
        }
        .accessibilityIdentifier("designSystem.section.\(title.lowercased())")
    }

    private func paletteColumn(
        label: String,
        palette: ColorPalette,
        keys: [(String, KeyPath<ColorPalette, Color>)]
    ) -> some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            Text(label)
                .font(Typography.caption)
                .foregroundStyle(Colors.textSecondary)

            ForEach(keys, id: \.0) { name, keyPath in
                HStack(spacing: Spacing.xs) {
                    RoundedRectangle(cornerRadius: Radius.thumbnail)
                        .fill(palette[keyPath: keyPath])
                        .frame(width: 28, height: 28)
                    Text(name)
                        .font(Typography.caption)
                        .foregroundStyle(Colors.textPrimary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func typographySection() -> some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text("Typography")
                .font(Typography.sectionTitle)
                .foregroundStyle(Colors.textPrimary)

            Text("Large Title")
                .font(Typography.largeTitle)
            Text("Section Title")
                .font(Typography.sectionTitle)
            Text("Body text for descriptions and reviews.")
                .font(Typography.body)
            Text("Caption metadata")
                .font(Typography.caption)
        }
        .accessibilityIdentifier("designSystem.section.typography")
    }
}

#Preview {
    TokenCatalogView()
}
