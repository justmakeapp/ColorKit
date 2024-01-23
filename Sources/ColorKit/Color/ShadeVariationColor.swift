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

    public let success: ShadeVariationColor = {
        var v = ShadeVariationColor()
        v.shade50 = Color(light: .init(hexRGB: "#ECFDF3"), dark: .init(hexRGB: "#053321"))
        v.shade200 = Color(light: .init(hexRGB: "#ABEFC6"), dark: .init(hexRGB: "#085D3A"))
        v.shade500 = Color(light: .init(hexRGB: "#17B26A"), dark: .init(hexRGB: "#17B26A"))
        v.shade700 = Color(light: .init(hexRGB: "#067647"), dark: .init(hexRGB: "#75E0A7"))
        return v
    }()

    public let error: ShadeVariationColor = {
        var v = ShadeVariationColor()
        v.shade50 = Color(light: .init(hexRGB: "#FEF3F2"), dark: .init(hexRGB: "#55160C"))
        v.shade200 = Color(light: .init(hexRGB: "#FECDCA"), dark: .init(hexRGB: "#912018"))
        v.shade500 = Color(light: .init(hexRGB: "#F04438"), dark: .init(hexRGB: "#F04438"))
        v.shade700 = Color(light: .init(hexRGB: "#B42318"), dark: .init(hexRGB: "#FDA29B"))
        return v
    }()

    public let warning: ShadeVariationColor = {
        var v = ShadeVariationColor()
        v.shade50 = Color(light: .init(hexRGB: "#FFFAEB"), dark: .init(hexRGB: "#4E1D09"))
        v.shade200 = Color(light: .init(hexRGB: "#FEDF89"), dark: .init(hexRGB: "#93370D"))
        v.shade500 = Color(light: .init(hexRGB: "#F79009"), dark: .init(hexRGB: "#F79009"))
        v.shade700 = Color(light: .init(hexRGB: "#B54708"), dark: .init(hexRGB: "#FEC84B"))
        return v
    }()

    public let blueLight: ShadeVariationColor = {
        var v = ShadeVariationColor()
        v.shade50 = Color(light: .init(hexRGB: "#F0F9FF"), dark: .init(hexRGB: "#062C41"))
        v.shade200 = Color(light: .init(hexRGB: "#B9E6FE"), dark: .init(hexRGB: "#065986"))
        v.shade500 = Color(light: .init(hexRGB: "#0BA5EC"), dark: .init(hexRGB: "#0BA5EC"))
        v.shade700 = Color(light: .init(hexRGB: "#026AA2"), dark: .init(hexRGB: "#7CD4FD"))
        return v
    }()
}

public extension UIColor {
    static let utilityColor = UtilityColor()

    static func utility(_ keyPath: KeyPath<UtilityColor, Color>) -> Color {
        return utilityColor[keyPath: keyPath]
    }
}
