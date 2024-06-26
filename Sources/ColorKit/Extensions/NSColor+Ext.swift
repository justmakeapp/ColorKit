//
//  NSColor+Ext.swift
//
//
//  Created by Long Vu on 24/3/24.
//

#if canImport(AppKit) && os(macOS)
    import AppKit.NSColor
    import Foundation

    extension NSColor {
        convenience init?(hexRGB: String) {
            self.init(hex: hexRGB)
        }

        convenience init?(hexRGBA: String) {
            self.init(hex: hexRGBA)
        }

        convenience init(hex: String) {
            let trimHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            let dropHash = String(trimHex.dropFirst()).trimmingCharacters(in: .whitespacesAndNewlines)
            let hexString = trimHex.starts(with: "#") ? dropHash : trimHex
            let ui64 = UInt64(hexString, radix: 16)
            let value = ui64 != nil ? Int(ui64!) : 0
            // #RRGGBB
            var components = (
                R: CGFloat((value >> 16) & 0xFF) / 255,
                G: CGFloat((value >> 08) & 0xFF) / 255,
                B: CGFloat((value >> 00) & 0xFF) / 255,
                a: CGFloat(1)
            )
            if String(hexString).count == 8 {
                // #RRGGBBAA
                components = (
                    R: CGFloat((value >> 24) & 0xFF) / 255,
                    G: CGFloat((value >> 16) & 0xFF) / 255,
                    B: CGFloat((value >> 08) & 0xFF) / 255,
                    a: CGFloat((value >> 00) & 0xFF) / 255
                )
            }
            self.init(red: components.R, green: components.G, blue: components.B, alpha: components.a)
        }

        func toHexString(includeAlpha: Bool = false) -> String? {
            guard let components = cgColor.components, components.count >= 3 else {
                return nil
            }

            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            var a = Float(1.0)

            if components.count >= 4 {
                a = Float(components[3])
            }

            if includeAlpha {
                return String(
                    format: "%02lX%02lX%02lX%02lX",
                    lroundf(r * 255),
                    lroundf(g * 255),
                    lroundf(b * 255),
                    lroundf(a * 255)
                )
            } else {
                return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
            }
        }
    }
#endif
