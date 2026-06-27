import SwiftUI
import Testing
@testable import DesignSystem

@Suite("Theme Mode")
struct ThemeModeTests {
    @Test func systemModeUsesDeviceColorScheme() {
        #expect(ThemeMode.system.resolvedColorScheme(system: .light) == .light)
        #expect(ThemeMode.system.resolvedColorScheme(system: .dark) == .dark)
    }

    @Test func forcedModesIgnoreSystem() {
        #expect(ThemeMode.light.resolvedColorScheme(system: .dark) == .light)
        #expect(ThemeMode.dark.resolvedColorScheme(system: .light) == .dark)
    }

    @Test func preferredColorScheme() {
        #expect(ThemeMode.system.preferredColorScheme == nil)
        #expect(ThemeMode.light.preferredColorScheme == .light)
        #expect(ThemeMode.dark.preferredColorScheme == .dark)
    }
}
