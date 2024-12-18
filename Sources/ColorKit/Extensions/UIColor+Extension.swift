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
            // Get the red, green, and blue components of the UIColor as floats between 0 and 1
            guard let components = cgColor.components, components.count > 2 else {
                // If the UIColor's color space doesn't support RGB components, return nil
                return nil
            }

            // Convert the red, green, and blue components to integers between 0 and 255
            let red = Int(components[0] * 255.0)
            let green = Int(components[1] * 255.0)
            let blue = Int(components[2] * 255.0)

            // Create a hex string with the RGB values and, optionally, the alpha value
            let hexString: String
            if includeAlpha, let alpha = components.last {
                let alphaValue = Int(alpha * 255.0)
                hexString = String(format: "#%02X%02X%02X%02X", red, green, blue, alphaValue)
            } else {
                hexString = String(format: "#%02X%02X%02X", red, green, blue)
            }

            // Return the hex string
            return hexString
        }
    }

#endif
