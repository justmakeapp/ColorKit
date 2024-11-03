//
//  Color+Extension.swift
//
//
//  Created by Long Vu on 14/05/2022.
//

import SwiftUI

#if canImport(UIKit)
    import UIKit.UIColor

    public typealias PlatformColor = UIColor
#endif

#if os(macOS)
    import AppKit.NSColor

    public typealias PlatformColor = NSColor
#endif

public extension Color {
    func toHexString(includeAlpha: Bool = false) -> String? {
        return PlatformColor(self).toHexString(includeAlpha: includeAlpha)
    }
}

public extension Color {
    init?(hexRGB: String) {
        guard let pColor = PlatformColor(hexRGB: hexRGB) else {
            return nil
        }
        self = Color(pColor)
    }

    init?(hexRGBA: String) {
        guard let pColor = PlatformColor(hexRGBA: hexRGBA) else {
            return nil
        }
        self = Color(pColor)
    }
}

public extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0 ... 1),
            green: Double.random(in: 0 ... 1),
            blue: Double.random(in: 0 ... 1)
        )
    }
}

// MARK: - Dynamic Color Provider

// https://www.jessesquires.com/blog/2023/07/11/creating-dynamic-colors-in-swiftui/

public extension Color {
    @available(iOS 15.0, *)
    init(light: Color, dark: Color) {
        #if canImport(UIKit)
            self.init(light: UIColor(light), dark: UIColor(dark))
        #else
            self.init(light: NSColor(light), dark: NSColor(dark))
        #endif
    }

    #if canImport(UIKit)
        @available(iOS 15.0, *)
        init(light: UIColor, dark: UIColor) {
            #if os(watchOS)
                // watchOS does not support light mode / dark mode
                // Per Apple HIG, prefer dark-style interfaces
                self.init(uiColor: dark)
            #else
                self.init(uiColor: UIColor(dynamicProvider: { traits in
                    switch traits.userInterfaceStyle {
                    case .light, .unspecified:
                        return light

                    case .dark:
                        return dark

                    @unknown default:
                        assertionFailure("Unknown userInterfaceStyle: \(traits.userInterfaceStyle)")
                        return light
                    }
                }))
            #endif
        }
    #endif

    #if canImport(AppKit)
        init(light: NSColor, dark: NSColor) {
            self.init(nsColor: NSColor(name: nil, dynamicProvider: { appearance in
                switch appearance.name {
                case .aqua,
                     .vibrantLight,
                     .accessibilityHighContrastAqua,
                     .accessibilityHighContrastVibrantLight:
                    return light

                case .darkAqua,
                     .vibrantDark,
                     .accessibilityHighContrastDarkAqua,
                     .accessibilityHighContrastVibrantDark:
                    return dark

                default:
                    assertionFailure("Unknown appearance: \(appearance.name)")
                    return light
                }
            }))
        }
    #endif
}

// MARK: - Color Spaces

public extension Color {
    /// A list of changeable attributes of the Color.
    enum ChangeableAttribute {
        /// The red color part of RGB.
        case red
        /// The green color part of RGB.
        case green
        /// The blue color part of RGB.
        case blue
        /// The hue color part of HSB.
        case hueHSB
        /// The saturation color part of HSB.
        case saturation
        /// The brightness color part of HSB.
        case brightness
        /// The hue color part of HLC.
        case hueHLC
        /// The luminance color part of HLC.
        case luminance
        /// The chroma color part of HLC.
        case chroma
        /// The opacity color part of RGB / HSB / HLC.
        case opacity
    }

    // MARK: - Computed Properties

    /// The HSB & alpha attributes of the `Color` instance.
    var hsbo: (hue: Double, saturation: Double, brightness: Double, opacity: Double) {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, opacity: CGFloat = 0
        #if os(macOS)
            let color = PlatformColor(self).usingColorSpace(.deviceRGB)!
        #else
            let color = PlatformColor(self)
        #endif

        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &opacity)

        return (
            hue: Double(hue),
            saturation: Double(saturation),
            brightness: Double(brightness),
            opacity: Double(opacity)
        )
    }

    /// The RGB & alpha attributes of the `Color` instance.
    var rgbo: (red: Double, green: Double, blue: Double, opacity: Double) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, opacity: CGFloat = 0

        #if os(macOS)
            let color = PlatformColor(self).usingColorSpace(.deviceRGB)!
        #else
            let color = PlatformColor(self)
        #endif
        color.getRed(&red, green: &green, blue: &blue, alpha: &opacity)

        return (red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(opacity))
    }

    /// The HLC & alpha attributes of the `Color` instance.
    var hlco: (hue: Double, luminance: Double, chroma: Double, opacity: Double) {
        let lch = self.rgbColor().toLCH()
        return (hue: lch.h / 360, luminance: lch.l / 100, chroma: lch.c / 128, opacity: lch.alpha)
    }

    /// Initializes and returns a color with the given HLCA values.
    ///
    /// - Parameters:
    ///   - hue:        The hue. A value between 0 and 1.
    ///   - luminance:  The luminance. A value between 0 and 1.
    ///   - chroma:     The chroma. A value between 0 and 1.
    ///   - opacity:    The opacity. A value between 0 and 1.
    init(
        hue: Double,
        luminance: Double,
        chroma: Double,
        opacity: Double
    ) {
        let rgb = LCHColor(l: luminance * 100, c: chroma * 128, h: hue * 360, alpha: opacity).toRGB()
        self.init(red: rgb.r, green: rgb.g, blue: rgb.b, opacity: rgb.alpha)
    }

    // MARK: - Methods

    /// Creates a new `Color` object with a single attribute changed by a given difference using addition.
    ///
    /// - Parameters:
    ///   - attribute: The attribute to change.
    ///   - by: The addition to be added to the current value of the attribute.
    /// - Returns: The resulting new `Color` with the specified change applied.
    func change(_ attribute: ChangeableAttribute, by addition: Double) -> Self {
        switch attribute {
        case .red:
            return change(attribute, to: rgbo.red + addition)

        case .green:
            return change(attribute, to: rgbo.green + addition)

        case .blue:
            return change(attribute, to: rgbo.blue + addition)

        case .hueHSB:
            return change(attribute, to: hsbo.hue + addition)

        case .saturation:
            return change(attribute, to: hsbo.saturation + addition)

        case .brightness:
            return change(attribute, to: hsbo.brightness + addition)

        case .hueHLC:
            return change(attribute, to: hlco.hue + addition)

        case .luminance:
            return change(attribute, to: hlco.luminance + addition)

        case .chroma:
            return change(attribute, to: hlco.chroma + addition)

        case .opacity:
            return change(attribute, to: hlco.opacity + addition)
        }
    }

    /// Creates a new `Color` object with the value of a single attribute set to a given value.
    ///
    /// - Parameters:
    ///   - attribute: The attribute to change.
    ///   - to: The new value to be set for the attribute.
    /// - Returns: The resulting new `Color` with the specified change applied.
    func change(_ attribute: ChangeableAttribute, to newValue: Double) -> Self {
        switch attribute {
        case .red, .green, .blue:
            return newRgboColor(attribute, newValue)

        case .hueHSB, .saturation, .brightness:
            return newHsboColor(attribute, newValue)

        case .hueHLC, .luminance, .chroma, .opacity:
            return newHlcoColor(attribute, newValue)
        }
    }

    private func newHlcoColor(_ attribute: Self.ChangeableAttribute, _ newValue: Double) -> Self {
        var newHlco = hlco

        switch attribute {
        case .hueHLC:
            newHlco.hue = newValue

        case .luminance:
            newHlco.luminance = newValue

        case .chroma:
            newHlco.chroma = newValue

        case .opacity:
            newHlco.opacity = newValue

        default:
            break
        }

        return Self(hue: newHlco.hue, luminance: newHlco.luminance, chroma: newHlco.chroma, opacity: newHlco.opacity)
    }

    private func newHsboColor(_ attribute: Self.ChangeableAttribute, _ newValue: Double) -> Self {
        var newHsbo = hsbo

        switch attribute {
        case .hueHSB:
            newHsbo.hue = newValue

        case .saturation:
            newHsbo.saturation = newValue

        case .brightness:
            newHsbo.brightness = newValue

        case .opacity:
            newHsbo.opacity = newValue

        default:
            break
        }

        return Self(
            hue: newHsbo.hue,
            saturation: newHsbo.saturation,
            brightness: newHsbo.brightness,
            opacity: newHsbo.opacity
        )
    }

    private func newRgboColor(_ attribute: Self.ChangeableAttribute, _ newValue: Double) -> Self {
        var newRgbo = self.rgbo

        switch attribute {
        case .red:
            newRgbo.red = newValue

        case .green:
            newRgbo.green = newValue

        case .blue:
            newRgbo.blue = newValue

        case .opacity:
            newRgbo.opacity = newValue

        default:
            break
        }

        return Color(red: newRgbo.red, green: newRgbo.green, blue: newRgbo.blue, opacity: newRgbo.opacity)
    }
}
