//
//  View+Ext.swift
//
//
//  Created by Long Vu on 3/7/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func modify(
        @ViewBuilder transform: (Self) -> some View
    ) -> some View {
        transform(self)
    }
}
