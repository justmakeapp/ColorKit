//
//  File.swift
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
    }
#endif
