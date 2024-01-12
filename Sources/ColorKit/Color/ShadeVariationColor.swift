//
//  SwiftUIView.swift
//
//
//  Created by Long Vu on 12/01/2024.
//

import SwiftUI

public struct ShadeVariationColor {
    public var shade50: Color = .clear
    public var shade100: Color = .clear
    public var shade200: Color = .clear
    public var shade500: Color = .clear
    public var shade700: Color = .clear

    public init() {}
}

public struct UtilityColor {
    public init() {}

    public let orange: ShadeVariationColor = {
        var v = ShadeVariationColor()
        v.shade50 = Color(light: .init(hexRGB: "#FFF4ED"), dark: .init(hexRGB: "#57130A"))
        v.shade200 = Color(light: .init(hexRGB: "#FFD6AE"), dark: .init(hexRGB: "#97180C"))
        v.shade500 = Color(light: .init(hexRGB: "#FF4405"), dark: .init(hexRGB: "#FF4405"))
        v.shade700 = Color(light: .init(hexRGB: "#BC1B06"), dark: .init(hexRGB: "#FF9C66"))
        return v
    }()
}

public extension UIColor {
    static let utilityColor = UtilityColor()

    static func utility(_ keyPath: KeyPath<UtilityColor, Color>) -> Color {
        return utilityColor[keyPath: keyPath]
    }
}
