import SwiftUI

public final class DesignSystem: @unchecked Sendable {
    nonisolated(unsafe) public static var shared = DesignSystem(theme: .default)

    public private(set) var theme: Theme
    nonisolated(unsafe) public var appearanceMode: ThemeMode = .system

    public init(theme: Theme, appearanceMode: ThemeMode = .system) {
        self.theme = theme
        self.appearanceMode = appearanceMode
    }

    public init(json data: Data, appearanceMode: ThemeMode = .system) throws {
        theme = try Theme(json: data)
        self.appearanceMode = appearanceMode
    }

    public init(json string: String, appearanceMode: ThemeMode = .system) throws {
        theme = try Theme(json: string)
        self.appearanceMode = appearanceMode
    }

    public init(jsonURL url: URL, appearanceMode: ThemeMode = .system) throws {
        theme = try Theme(jsonURL: url)
        self.appearanceMode = appearanceMode
    }

    public init(jsonResource name: String, bundle: Bundle, appearanceMode: ThemeMode = .system) throws {
        theme = try Theme(jsonResource: name, bundle: bundle)
        self.appearanceMode = appearanceMode
    }

    @discardableResult
    public static func configure(theme: Theme, appearanceMode: ThemeMode = .system) -> DesignSystem {
        shared = DesignSystem(theme: theme, appearanceMode: appearanceMode)
        return shared
    }

    @discardableResult
    public static func configure(json data: Data, appearanceMode: ThemeMode = .system) throws -> DesignSystem {
        let system = try DesignSystem(json: data, appearanceMode: appearanceMode)
        shared = system
        return system
    }

    @discardableResult
    public static func configure(json string: String, appearanceMode: ThemeMode = .system) throws -> DesignSystem {
        let system = try DesignSystem(json: string, appearanceMode: appearanceMode)
        shared = system
        return system
    }

    @discardableResult
    public static func configure(jsonURL url: URL, appearanceMode: ThemeMode = .system) throws -> DesignSystem {
        let system = try DesignSystem(jsonURL: url, appearanceMode: appearanceMode)
        shared = system
        return system
    }

    @discardableResult
    public static func configure(jsonResource name: String, bundle: Bundle, appearanceMode: ThemeMode = .system) throws -> DesignSystem {
        let system = try DesignSystem(jsonResource: name, bundle: bundle, appearanceMode: appearanceMode)
        shared = system
        return system
    }
}

private struct ThemeEnvironmentKey: EnvironmentKey {
    static let defaultValue = DesignSystem.shared.theme
}

private struct ThemeModeEnvironmentKey: EnvironmentKey {
    static let defaultValue: ThemeMode = .system
}

private struct ResolvedColorPaletteKey: EnvironmentKey {
    static let defaultValue: ColorPalette? = nil
}

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeEnvironmentKey.self] }
        set { self[ThemeEnvironmentKey.self] = newValue }
    }

    var designThemeMode: ThemeMode {
        get { self[ThemeModeEnvironmentKey.self] }
        set { self[ThemeModeEnvironmentKey.self] = newValue }
    }

    var resolvedColorPalette: ColorPalette? {
        get { self[ResolvedColorPaletteKey.self] }
        set { self[ResolvedColorPaletteKey.self] = newValue }
    }
}

public extension View {
    func theme(_ theme: Theme) -> some View {
        environment(\.theme, theme)
    }

    func designThemeMode(_ mode: ThemeMode) -> some View {
        modifier(DesignThemeModeModifier(mode: mode))
    }
}

private struct DesignThemeModeModifier: ViewModifier {
    @Environment(\.theme) private var theme
    @Environment(\.colorScheme) private var colorScheme
    let mode: ThemeMode

    func body(content: Content) -> some View {
        content
            .environment(\.designThemeMode, mode)
            .environment(\.resolvedColorPalette, theme.colorPalette(for: mode, systemColorScheme: colorScheme))
            .preferredColorScheme(mode.preferredColorScheme)
    }
}
