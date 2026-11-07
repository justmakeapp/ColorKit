//
//  ColorCell.swift
//
//
//  Created by Long Vu on 3/7/24.
//

import ColorKit
import SwiftUI

struct InternalColorCell: View {
    let color: Color
    let size: CGSize
    let isSelected: Bool
    let action: () -> Void

    @State private var counter = 0

    var body: some View {
        Button {
            action()

            counter += 1
        } label: {
            ZStack {
                outerCircle
                    .opacity(isSelected ? 0 : 1)
                innerCircle
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
        }
        .buttonStyle(.plain)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .modify {
            if #available(iOS 17.0, macOS 14.0, *) {
                #if os(macOS) || os(iOS)
                    $0.sensoryFeedback(.selection, trigger: counter)
                #else
                    $0
                #endif
            } else {
                $0
            }
        }
    }

    private var outerCircle: some View {
        Circle()
            .strokeBorder(color.gradient, lineWidth: 2)
            .frame(width: diameter, height: diameter)
    }

    /// The cell is a circle, so a non-square `size` uses its shorter side; selecting a cell then never changes
    /// its height.
    private var diameter: CGFloat {
        min(size.width, size.height)
    }

    private var innerCircle: some View {
        // The selected cell drops the outer ring and fills its whole size; its white circle takes the size the
        // inner circle has when not selected.
        let unselectedSize = diameter - 8
        let innerSize = isSelected ? diameter : unselectedSize
        return Circle()
            .fill(color.gradient)
            .frame(width: innerSize, height: innerSize)
            .overlay {
                if isSelected {
                    Circle()
                        .fill(.white.opacity(0.6))
                        // The hairline keeps the white dot visible on white, yellow and other light swatches.
                        .overlay(Circle().strokeBorder(.black.opacity(0.15), lineWidth: 1))
                        .frame(width: unselectedSize, height: unselectedSize)
                        .modify {
                            if #available(iOS 26.0, macOS 26.0, watchOS 26.0, *) {
                                $0.glassEffect(.clear, in: Circle())
                            } else {
                                $0
                            }
                        }
                        .transition(.scale.combined(with: .opacity))
                }
            }
    }
}

public struct ColorCell: View {
    @Binding var selection: Color?
    let color: Color
    let displayColor: Color
    var size: CGSize

    public init(
        selection: Binding<Color?>,
        color: Color,
        displayColor: Color? = nil,
        size: CGSize
    ) {
        _selection = selection
        self.color = color
        self.displayColor = displayColor ?? color
        self.size = size
    }

    public var body: some View {
        contentView
    }

    private var isSelected: Bool {
        return selection?.toHexString() == color.toHexString() || selection == color
    }

    private var contentView: some View {
        InternalColorCell(color: displayColor, size: size, isSelected: isSelected) {
            if selection != color {
                selection = color
            }
        }
    }
}

public struct ColorProviderCell: View {
    @Binding var selection: ColorProvider?
    let colorProvider: ColorProvider
    var size: CGSize
    var colorBundle: Bundle?

    private var color: Color {
        colorProvider.asColor(bundle: colorBundle)
    }

    public init(
        selection: Binding<ColorProvider?>,
        colorProvider: ColorProvider,
        size: CGSize,
        colorBundle _: Bundle? = nil
    ) {
        _selection = selection
        self.colorProvider = colorProvider
        self.size = size
    }

    public var body: some View {
        contentView
    }

    private var isSelected: Bool {
        return selection == colorProvider
    }

    private var contentView: some View {
        InternalColorCell(color: color, size: size, isSelected: isSelected) {
            if selection != colorProvider {
                selection = colorProvider
            }
        }
    }
}

#if DEBUG
    /// Tap a cell to watch the selection animate.
    private struct ColorCellPreview: View {
        @State private var selection: Color? = .green

        var body: some View {
            HStack {
                ForEach([Color.blue, .green, .orange, .yellow, .white], id: \.self) { color in
                    ColorCell(selection: $selection, color: color, size: CGSize(width: 40, height: 40))
                }
            }
        }
    }

    #Preview {
        ColorCellPreview()
    }
#endif
