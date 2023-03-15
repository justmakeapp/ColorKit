//
//  File.swift
//
//
//  Created by Long Vu on 14/05/2022.
//

import SwiftUI

#if os(iOS)
    import UIKit.UIColor

    public extension Color {
        var hexString: String? {
            return UIColor(self).hexString
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
#endif
