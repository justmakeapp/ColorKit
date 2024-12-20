//
//  SystemColor+macOS.swift
//
//
//  Created by Long Vu on 15/03/2023.
//

import Foundation

#if os(macOS)
    import AppKit.NSColor
    import SwiftUI

    public extension Color {
        static var secondaryLabelColor: Color {
            return .init(nsColor: .secondaryLabelColor)
        }

        static var textColor: Color {
            return .init(nsColor: .textColor)
        }

        static var controlBackgroundColor: Color {
            return .init(nsColor: .controlBackgroundColor)
        }

        static var controlColor: Color {
            return .init(nsColor: .controlColor)
        }

        // MARK: - Background Colors

        static let systemBackgroundAsIOS = Color("PrimarySystemBackground", bundle: .module)
        static let secondarySystemBackgroundAsIOS = Color("SecondarySystemBackground", bundle: .module)
        static let tertiarySystemBackgroundAsIOS = Color("TertiarySystemBackground", bundle: .module)

        static var systemBackground: Color {
            windowBackgroundColor
        }

        static var secondarySystemBackground: Color {
            controlBackgroundColor
        }

        // MARK: - Grouped Background Colors

        static let systemGroupedBackground = Color("PrimarySystemGroupedBackground", bundle: .module)
        static let secondarySystemGroupedBackground = Color("SecondarySystemGroupedBackground", bundle: .module)
        static let tertiarySystemGroupedBackground = Color("TertiarySystemGroupedBackground", bundle: .module)

        static var windowBackgroundColor: Color {
            return .init(nsColor: .windowBackgroundColor)
        }

        static var unemphasizedSelectedContentBackgroundColor: Color {
            return .init(nsColor: .unemphasizedSelectedContentBackgroundColor)
        }

        // MARK: - Fill Colors

        static var systemFill: Color {
            if #available(macOS 14.0, *) {
                return .init(nsColor: .systemFill)
            } else {
                return Color(
                    light: Color(hexRGBA: "#0000001A")!,
                    dark: Color(hexRGBA: "#FFFFFF1A")!
                )
            }
        }

        static var secondarySystemFill: Color {
            if #available(macOS 14.0, *) {
                return .init(nsColor: .secondarySystemFill)
            } else {
                return Color(
                    light: Color(hexRGBA: "#00000014")!,
                    dark: Color(hexRGBA: "#FFFFFF14")!
                )
            }
        }

        static var tertiarySystemFill: Color {
            if #available(macOS 14.0, *) {
                return .init(nsColor: .tertiarySystemFill)
            } else {
                return Color(
                    light: Color(hexRGBA: "#0000000D")!,
                    dark: Color(hexRGBA: "#FFFFFF0D")!
                )
            }
        }

        static var quaternarySystemFill: Color {
            if #available(macOS 14.0, *) {
                return .init(nsColor: .quaternarySystemFill)
            } else {
                return Color(
                    light: Color(hexRGBA: "#00000008")!,
                    dark: Color(hexRGBA: "#FFFFFF08")!
                )
            }
        }

        static var quinarySystemFill: Color {
            if #available(macOS 14.0, *) {
                return .init(nsColor: .quinarySystemFill)
            } else {
                return Color(
                    light: Color(hexRGBA: "#00000004")!,
                    dark: Color(hexRGBA: "#FFFFFF04")!
                )
            }
        }

        // MARK: - System Gray Colors

        static let systemGray = Color(NSColor.systemGray)
        static let systemGray2 = Color("AppleGray2", bundle: .module)
        static let systemGray3 = Color("AppleGray3", bundle: .module)
        static let systemGray4 = Color("AppleGray4", bundle: .module)
        static let systemGray5 = Color("AppleGray5", bundle: .module)
        static let systemGray6 = Color("AppleGray6", bundle: .module)

        // MARK: - Other Colors

        static let separator = Color(NSColor.separatorColor)
    }
#endif
