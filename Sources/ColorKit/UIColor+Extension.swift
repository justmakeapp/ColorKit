//
//  UIColor+Extension.swift
//
//
//  Created by Long Vu on 14/05/2022.
//

import Foundation

#if os(iOS)
    import UIKit
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
        var hexString: String? {
            guard let components = cgColor.components, components.count >= 3 else {
                return nil
            }

            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            return "#" + String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }

    public extension UIColor {
        func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
            let dynamicColor = UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return self.adjust(by: abs(percentage)) ?? .clear
                default:
                    return self.adjust(by: abs(percentage)) ?? .clear
                }
            }
            return dynamicColor
        }

        func darker(by percentage: CGFloat = 30.0) -> UIColor? {
            let dynamicColor = UIColor { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return self.adjust(by: -1 * abs(percentage)) ?? .clear
                default:
                    return self.adjust(by: -1 * abs(percentage)) ?? .clear
                }
            }
            return dynamicColor
        }

        func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                return UIColor(red: min(red + percentage / 100, 1.0),
                               green: min(green + percentage / 100, 1.0),
                               blue: min(blue + percentage / 100, 1.0),
                               alpha: alpha)
            } else {
                return nil
            }
        }
    }

#endif
