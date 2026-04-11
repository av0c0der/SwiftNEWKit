import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")

        guard hex.count == 6 || hex.count == 8,
              let value = UInt64(hex, radix: 16) else {
            return nil
        }

        let red: Double
        let green: Double
        let blue: Double
        let alpha: Double

        if hex.count == 8 {
            red = Double((value & 0xFF000000) >> 24) / 255
            green = Double((value & 0x00FF0000) >> 16) / 255
            blue = Double((value & 0x0000FF00) >> 8) / 255
            alpha = Double(value & 0x000000FF) / 255
        } else {
            red = Double((value & 0xFF0000) >> 16) / 255
            green = Double((value & 0x00FF00) >> 8) / 255
            blue = Double(value & 0x0000FF) / 255
            alpha = 1
        }

        self = Color(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    var adaptedTextColor: Color {
        #if canImport(UIKit)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        let uiColor = UIColor(self)
        uiColor.getRed(&r, green: &g, blue: &b, alpha: nil)
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)

        let luminance = Self.relativeLuminance(red: r, green: g, blue: b)
        if saturation > 0.45, brightness > 0.75, luminance < 0.8 {
            return .white
        }
        return luminance > 0.6 ? .black : .white
        #elseif canImport(AppKit)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        if let sRgbColor = NSColor(self).usingColorSpace(.sRGB) {
            sRgbColor.getRed(&r, green: &g, blue: &b, alpha: nil)
            sRgbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        }

        let luminance = Self.relativeLuminance(red: r, green: g, blue: b)
        if saturation > 0.45, brightness > 0.75, luminance < 0.8 {
            return .white
        }
        return luminance > 0.6 ? .black : .white
        #else
        return .white
        #endif
    }

    private static func relativeLuminance(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat {
        let red = linearized(red)
        let green = linearized(green)
        let blue = linearized(blue)
        return 0.2126 * red + 0.7152 * green + 0.0722 * blue
    }

    private static func linearized(_ value: CGFloat) -> CGFloat {
        value <= 0.04045 ? value / 12.92 : pow((value + 0.055) / 1.055, 2.4)
    }
}
