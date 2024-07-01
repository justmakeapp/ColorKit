//
//  Color+Extension.swift
//
//
//  Created by Long Vu on 14/05/2022.
//

import SwiftUI

#if os(iOS)
    import UIKit.UIColor

    public typealias PlatformColor = UIColor
#endif

#if os(macOS)
    import AppKit.NSColor

    public typealias PlatformColor = NSColor
#endif

#if os(iOS)
    import UIKit.UIColor

    public extension Color {
        func toHexString(includeAlpha: Bool = false) -> String? {
            return UIColor(self).toHexString(includeAlpha: includeAlpha)
        }

        func lighter(by percentage: CGFloat = 30.0) -> Color? {
            guard let uiColor = UIColor(self).lighter(by: percentage) else {
                return nil
            }
            return Color(uiColor)
        }

        func darker(by percentage: CGFloat = 30.0) -> Color? {
            guard let uiColor = UIColor(self).darker(by: percentage) else {
                return nil
            }
            return Color(uiColor)
        }
    }

    extension Color {
        init(light: PlatformColor?, dark: PlatformColor?) {
            self = Color(UIColor(light: light, dark: dark))
        }
    }

#endif

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
