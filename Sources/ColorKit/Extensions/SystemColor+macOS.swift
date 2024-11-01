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
