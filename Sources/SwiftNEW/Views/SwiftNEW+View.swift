//
//  SwiftNEW+View.swift
//  SwiftNEW
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    public var body: some View {
        Group {
            if presentation == .embed {
                sheetContent
            } else {
                Button(action: {
                    isPresented = true
                }) {
                    Label(strings.triggerButtonLabel, systemImage: labelImage)
                        .frame(
                            width: triggerStyle == .mini ? nil : (triggerStyle == .hidden ? 0 : platformWidth),
                            height: triggerStyle == .mini ? nil : (triggerStyle == .hidden ? 0 : 50)
                        )
                        #if os(iOS) && !os(visionOS)
                        .foregroundColor(color.adaptedTextColor)
                        .background(triggerStyle == .regular ? color : Color.clear)
                        .cornerRadius(15)
                        #endif
                }
                .opacity(triggerStyle == .hidden ? 0 : 1)
                .modifier(PresentationModifier(isPresented: $isPresented, presentation: presentation, sheetContent: sheetContent))
            }
        }
    }
    
    private var platformWidth: CGFloat {
        #if os(tvOS)
        400
        #else
        300
        #endif
    }
    
    private var sheetContent: some View {
        ZStack {
            backgroundLayer
            sheetCurrent
                .sheet(isPresented: $historySheet) {
                    if canShowHistory {
                        historySheetContent
                    }
                }
                #if os(visionOS)
                .padding()
                #endif
        }
        .modifier(PresentationBackgroundModifier(background: background))
    }
    
    private var historySheetContent: some View {
        ZStack {
            backgroundLayer
            sheetHistory
                #if os(visionOS)
                .padding()
                #endif
        }
        .modifier(PresentationBackgroundModifier(background: background))
    }

    @ViewBuilder
    private var backgroundLayer: some View {
        switch background.storage {
        case let .solidColor(color):
            color.ignoresSafeArea()
        case let .view(view):
            view.ignoresSafeArea()
        case .mesh:
            MeshView(color: color)
        }
    }
}

private struct PresentationBackgroundModifier: ViewModifier {
    let background: SwiftNEWBackground

    func body(content: Content) -> some View {
        if #available(iOS 16.4, tvOS 16.4, *) {
            switch background.storage {
            case let .solidColor(color):
                content.presentationBackground(color)
            case .view, .mesh:
                content.presentationBackground(.clear)
            }
        } else {
            content
        }
    }
}

private struct PresentationModifier<V: View>: ViewModifier {
    @Binding var isPresented: Bool
    let presentation: SwiftNEWPresentation
    let sheetContent: V

    func body(content: Content) -> some View {
        #if os(macOS)
        content.sheet(isPresented: $isPresented) {
            sheetContent
        }
        #else
        if presentation == .fullScreenCover {
            if #available(iOS 14.0, tvOS 14.0, watchOS 7.0, *) {
                content.fullScreenCover(isPresented: $isPresented) {
                    sheetContent
                }
            } else {
                content.sheet(isPresented: $isPresented) {
                    sheetContent
                }
            }
        } else {
            content.sheet(isPresented: $isPresented) {
                sheetContent
            }
        }
        #endif
    }
}
