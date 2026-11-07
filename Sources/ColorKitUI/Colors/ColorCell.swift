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
    @Environment(\.self) private var environment

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
        // The selected cell drops the outer ring and fills its whole size; its dot takes the size the inner circle
        // has when not selected.
        let unselectedSize = diameter - 8
        let innerSize = isSelected ? diameter : unselectedSize
        return Circle()
            .fill(color.gradient)
            .frame(width: innerSize, height: innerSize)
            .overlay {
                if isSelected {
                    Circle()
                        .fill(dotColor)
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

    /// A white dot disappears on white, yellow and pastel swatches, so light swatches get a dark dot.
    private var dotColor: Color {
        if #available(iOS 17.0, macOS 14.0, watchOS 10.0, visionOS 1.0, *) {
            let resolved = color.resolve(in: environment)
            // Relative luminance, from the linear sRGB components.
            let luminance = 0.2126 * resolved.linearRed
                + 0.7152 * resolved.linearGreen
                + 0.0722 * resolved.linearBlue
            if luminance > 0.5 {
                return .black.opacity(0.3)
            }
        }
        return .white.opacity(0.6)
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
        @State var selection: Color?

        var body: some View {
            HStack {
                ForEach(
                    // The last color is the light yellow card background, #F9EB9F.
                    [Color.blue, .green, .orange, .yellow, .white, Color(red: 0.976, green: 0.922, blue: 0.624)],
                    id: \.self
                ) { color in
                    ColorCell(selection: $selection, color: color, size: CGSize(width: 40, height: 40))
                }
            }
        }
    }

    #Preview {
        VStack(spacing: 16) {
            ColorCellPreview(selection: .green)
            ColorCellPreview(selection: .white)
            ColorCellPreview(selection: Color(red: 0.976, green: 0.922, blue: 0.624))
        }
    }
#endif
