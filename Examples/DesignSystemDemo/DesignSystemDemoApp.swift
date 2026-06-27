import DesignSystem
import SwiftUI

@main
struct DesignSystemDemoApp: App {
    init() {
        DesignSystem.configure(theme: .default, appearanceMode: .system)
    }

    var body: some Scene {
        WindowGroup {
            TokenCatalogView()
        }
    }
}
