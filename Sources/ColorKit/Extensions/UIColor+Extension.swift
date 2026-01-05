//
//  UIColor+Extension.swift
//
//
//  Created by Long Vu on 14/05/2022.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
    import UIKit

    #if os(iOS) || os(visionOS)
        extension UIColor {
            convenience init(light: UIColor?, dark: UIColor?) {
                self.init {
                    switch $0.userInterfaceStyle {
                    case .dark:
                        return dark ?? .clear

                    case .light, .unspecified:
                        return light ?? .clear

                    @unknown default:
                        return light ?? .clear
                    }
                }
            }
        }
    #endif

    public extension UIColor {
        /// Creates a UIColor from a hexadecimal color string.
        ///
        /// Supports both RGB (6 characters) and RGBA (8 characters) formats.
        /// The hex string can optionally start with a '#' character.
        ///
        /// - Parameter hex: A hexadecimal color string. Examples: "#RRGGBB", "RRGGBB", "#RRGGBBAA", "RRGGBBAA"
        ///
        /// - Note: For 6-character hex strings, alpha defaults to 1.0 (fully opaque).
        ///         For 8-character hex strings, the last two characters represent alpha.
        ///         Invalid hex strings will result in black color (000000).
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

        convenience init?(hexRGBA: String) {
            guard let val = Int(hexRGBA.replacingOccurrences(of: "#", with: ""), radix: 16) else {
                return nil
            }

            self.init(red: CGFloat((val >> 24) & 0xFF) / 255.0,
                      green: CGFloat((val >> 16) & 0xFF) / 255.0,
                      blue: CGFloat((val >> 8) & 0xFF) / 255.0,
                      alpha: CGFloat(val & 0xFF) / 255.0)
        }

        convenience init?(hexRGB: String) {
            self.init(hexRGBA: hexRGB + "ff") // Add alpha = 1.0
        }
    }

    public extension UIColor {
        func toHexString(includeAlpha: Bool = false) -> String? {
            var red: CGFloat = 0
            var green: CGFloat = 0
            var blue: CGFloat = 0
            var alpha: CGFloat = 0

            guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
                assertionFailure("Failed to get RGBA components from UIColor")
                return "#000000"
            }

            // Clamp components to [0.0, 1.0]
            red = max(0, min(1, red))
            green = max(0, min(1, green))
            blue = max(0, min(1, blue))
            alpha = max(0, min(1, alpha))

            if !includeAlpha {
                // RGB
                return String(
                    format: "#%02lX%02lX%02lX",
                    Int(round(red * 255)),
                    Int(round(green * 255)),
                    Int(round(blue * 255))
                )
            } else {
                // RGBA
                return String(
                    format: "#%02lX%02lX%02lX%02lX",
                    Int(round(red * 255)),
                    Int(round(green * 255)),
                    Int(round(blue * 255)),
                    Int(round(alpha * 255))
                )
            }
        }
    }

#endif
