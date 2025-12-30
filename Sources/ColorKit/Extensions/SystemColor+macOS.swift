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

        static var gridColor: Color {
            return .init(nsColor: .gridColor)
        }

        static var unemphasizedSelectedTextBackgroundColor: Color {
            return .init(nsColor: .unemphasizedSelectedTextBackgroundColor)
        }

        static var controlColor: Color {
            return .init(nsColor: .controlColor)
        }

        // MARK: - Label Colors

//        static let label = Color(UIColor.label)
//        static let secondaryLabel = Color(UIColor.secondaryLabel)
        static let tertiaryLabel = Color(
            light: Color(hexRGB: "3C3C43")!.opacity(0.3),
            dark: Color(hexRGB: "EBEBF5")!.opacity(0.3)
        )

        static let quaternaryLabel = Color(
            light: Color(hexRGB: "3C3C43")!.opacity(0.18),
            dark: Color(hexRGB: "EBEBF5")!.opacity(0.16)
        )

        // MARK: - Background Colors

        static let systemBackgroundAsIOS = Color("PrimarySystemBackground", bundle: .module)
        static let secondarySystemBackgroundAsIOS = Color("SecondarySystemBackground", bundle: .module)
        static let tertiarySystemBackground = Color("TertiarySystemBackground", bundle: .module)

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
