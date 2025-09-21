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

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        Button {
            action()

            counter += 1
        } label: {
            ZStack {
                outerCircle
                innerCircle
            }
            .modify {
                if #available(iOS 26.0, macOS 26.0, watchOS 26.0, *) {
                    $0.glassEffect()
                } else {
                    $0
                }
            }
        }
        .buttonStyle(.plain)
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
            .strokeBorder(color, lineWidth: 2)
            .frame(width: size.width, height: size.height)
    }

    @ViewBuilder
    private var innerCircle: some View {
        let paddingValue: CGFloat = 8
        Circle()
            .fill(color)
            .frame(width: size.width - paddingValue, height: size.width - paddingValue)
            .overlay(
                ZStack {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor({
                                switch colorScheme {
                                case .light:
                                    return .white
                                case .dark:
                                    #if os(visionOS)
                                        return .white
                                    #else
                                        return .black
                                    #endif
                                @unknown default:
                                    return .white
                                }
                            }())
                    }
                }
                .padding()
            )
    }
}

public struct ColorCell: View {
    @Binding var selection: Color?
    let color: Color
    var size: CGSize

    public init(
        selection: Binding<Color?>,
        color: Color,
        size: CGSize
    ) {
        _selection = selection
        self.color = color
        self.size = size
    }

    public var body: some View {
        contentView
    }

    private var isSelected: Bool {
        return selection?.toHexString() == color.toHexString() || selection == color
    }

    private var contentView: some View {
        InternalColorCell(color: color, size: size, isSelected: isSelected) {
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

#Preview {
    let size = CGSize(width: 40, height: 40)
    return HStack {
        ColorCell(
            selection: .constant(Color.blue),
            color: Color.green,
            size: size
        )

        ColorCell(
            selection: .constant(Color.green),
            color: Color.green,
            size: size
        )
    }
}
