//
//  ColorProvider.swift
//
//
//  Created by Long Vu on 3/7/24.
//

import Foundation
import SwiftUI

public enum ColorProvider: RawRepresentable, Hashable, Codable, Sendable {
    enum Prefix: String {
        case hexRGB
        case hexRGBA
        case local
        case appleColor
    }

    public enum AppleColor: String, CaseIterable, Sendable {
        case systemRed
        case systemOrange
        case systemYellow
        case systemGreen
        case systemTeal
        case systemBlue
        case systemIndigo
        case systemPurple
        case systemBrown
    }

    case hexRGB(value: String)
    case hexRGBA(value: String)
    case local(name: String)
    case appleColor(value: AppleColor)

    public var rawValue: String {
        switch self {
        case let .hexRGB(value):
            return "\(Prefix.hexRGB.rawValue)|\(value)"
        case let .hexRGBA(value):
            return "\(Prefix.hexRGBA.rawValue)|\(value)"
        case let .local(name):
            return "\(Prefix.local.rawValue)|\(name)"
        case let .appleColor(value):
            return "\(Prefix.appleColor.rawValue)|\(value.rawValue)"
        }
    }

    public static var allAppleColors: [ColorProvider] {
        AppleColor.allCases.map { .appleColor(value: $0) }
    }

    public init?(rawValue: String) {
        let components = rawValue.components(separatedBy: "|").map { String($0) }
        guard
            components.count >= 2,
            let prefix = Prefix(rawValue: components[0])
        else {
            return nil
        }

        switch prefix {
        case .hexRGB:
            self = .hexRGB(value: components[1])
        case .hexRGBA:
            self = .hexRGBA(value: components[1])
        case .local:
            self = .local(name: components[1])
        case .appleColor:
            let value = AppleColor(rawValue: components[1])
            self = .appleColor(value: value ?? .systemBlue)
        }
    }
}

public extension ColorProvider {
    func asColor(bundle: Bundle? = nil) -> Color {
        let color: Color? = {
            switch self {
            case let .hexRGB(value):
                return Color(hexRGB: value)
            case let .hexRGBA(value):
                return Color(hexRGBA: value)
            case let .local(name):
                return Color(name, bundle: bundle ?? .main)
            case let .appleColor(value):
                return value.asColor()
            }

        }()
        return color ?? .clear
    }
}

public extension ColorProvider.AppleColor {
    func asColor() -> Color {
        switch self {
        case .systemRed:
            return .red
        case .systemOrange:
            return .orange
        case .systemYellow:
            return .yellow
        case .systemGreen:
            return .green
        case .systemTeal:
            if #available(iOS 15.0, macCatalyst 15.0, *) {
                return .teal
            } else {
                fatalError()
            }
        case .systemBlue:
            return .blue
        case .systemIndigo:
            if #available(iOS 15.0, macCatalyst 15.0, *) {
                return .indigo
            } else {
                fatalError()
            }
        case .systemPurple:
            return .purple
        case .systemBrown:
            if #available(iOS 15.0, macCatalyst 15.0, *) {
                return .brown
            } else {
                fatalError()
            }
        }
    }
}
