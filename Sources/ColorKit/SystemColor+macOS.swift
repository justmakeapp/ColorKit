//
//  File.swift
//  
//
//  Created by Long Vu on 15/03/2023.
//

import Foundation

#if os(macOS)
import SwiftUI
import AppKit.NSColor

public extension Color {
    var secondaryLabelColor: Color {
        return .init(nsColor: .secondaryLabelColor)
    }
    
    var textColor: Color {
        return .init(nsColor: .textColor)
    }
    
    var controlBackgroundColor: Color {
        return .init(nsColor: .controlBackgroundColor)
    }
    
    var controlColor: Color {
        return .init(nsColor: .controlColor)
    }
}
#endif
