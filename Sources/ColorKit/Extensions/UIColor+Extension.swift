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
