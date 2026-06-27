import SwiftUI

#if canImport(UIKit)
import UIKit
#endif

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        let red = Double((hex >> 16) & 0xFF) / 255
        let green = Double((hex >> 8) & 0xFF) / 255
        let blue = Double(hex & 0xFF) / 255
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    init(hexString: String, opacity: Double = 1) {
        let sanitized = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        let value = UInt32(sanitized, radix: 16) ?? 0
        self.init(hex: value, opacity: opacity)
    }

    /// A color that automatically switches between light and dark variants.
    static func adaptive(light lightHex: String, dark darkHex: String) -> Color {
        adaptive(light: Color(hexString: lightHex), dark: Color(hexString: darkHex))
    }

    static func adaptive(light: Color, dark: Color) -> Color {
        #if canImport(UIKit)
        Color(
            uiColor: UIColor { traits in
                traits.userInterfaceStyle == .dark ? UIColor(dark) : UIColor(light)
            }
        )
        #else
        light
        #endif
    }
}

#if canImport(UIKit)
private extension UIColor {
    convenience init(hexString: String, opacity: Double = 1) {
        let sanitized = hexString
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        let value = UInt32(sanitized, radix: 16) ?? 0
        let red = CGFloat((value >> 16) & 0xFF) / 255
        let green = CGFloat((value >> 8) & 0xFF) / 255
        let blue = CGFloat(value & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: opacity)
    }
}
#endif
