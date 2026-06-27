import SnapshotTesting
import SwiftUI
import Testing
@testable import DesignSystem

/// Visual regression tests for the token catalog.
///
/// To record new reference images, change `.snapshots(record: .failed)` to
/// `.snapshots(record: .all)` on the suite, run once, then revert.
@Suite(.serialized, .snapshots(record: .failed))
@MainActor
struct TokenCatalogSnapshotTests {
    init() {
        DesignSystem.configure(theme: .default, appearanceMode: .system)
    }

    @Test func tokenCatalogLightMode() {
        let view = TokenCatalogView()
            .frame(width: 390, height: 844)
            .designThemeMode(.light)

        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            named: "tokenCatalog-light"
        )
    }

    @Test func tokenCatalogDarkMode() {
        let view = TokenCatalogView()
            .frame(width: 390, height: 844)
            .designThemeMode(.dark)

        assertSnapshot(
            of: view,
            as: .image(layout: .sizeThatFits),
            named: "tokenCatalog-dark"
        )
    }
}
