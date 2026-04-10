import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
public struct SwiftNEW: View {
    @State var historySheet: Bool = false
    let currentItems: [ReleaseNotes]
    let historySections: [ReleaseNotesSection]
    let color: Color
    let background: SwiftNEWBackground
    let strings: SwiftNEWStrings
    let history: Bool
    let dateFormat: Date.FormatStyle
    let onContinue: (() -> Void)?

    public init(
        color: Color = .accentColor,
        background: SwiftNEWBackground = {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        currentItems: [ReleaseNotes] = [],
        historySections: [ReleaseNotesSection] = [],
        strings: SwiftNEWStrings = .default,
        history: Bool = true,
        dateFormat: Date.FormatStyle = .dateTime.year().month().day(),
        onContinue: (() -> Void)? = nil
    ) {
        self.currentItems = currentItems
        self.historySections = historySections
        self.color = color
        self.background = background
        self.strings = strings
        self.history = history
        self.dateFormat = dateFormat
        self.onContinue = onContinue
    }

    public init(
        color: Color = .accentColor,
        background: SwiftNEWBackground = {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        currentItems: [ReleaseNotes] = [],
        historyItems: [ReleaseNotes] = [],
        strings: SwiftNEWStrings = .default,
        history: Bool = true,
        dateFormat: Date.FormatStyle = .dateTime.year().month().day(),
        onContinue: (() -> Void)? = nil
    ) {
        self.init(
            color: color,
            background: background,
            currentItems: currentItems,
            historySections: historyItems.isEmpty ? [] : [ReleaseNotesSection(items: historyItems)],
            strings: strings,
            history: history,
            dateFormat: dateFormat,
            onContinue: onContinue
        )
    }

    var canShowHistory: Bool {
        history && historySections.contains { !$0.items.isEmpty }
    }

    public var body: some View {
        sheetContent
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(PresentationBackgroundModifier(background: background))
    }

    @ViewBuilder
    private var backgroundLayer: some View {
        switch background.storage {
        case let .view(view, _):
            view
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        case .mesh:
            MeshView(color: color)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
        }
    }
}

private struct PresentationBackgroundModifier: ViewModifier {
    let background: SwiftNEWBackground

    func body(content: Content) -> some View {
        if #available(iOS 16.4, tvOS 16.4, *) {
            switch background.storage {
            case let .view(_, presentationColor):
                content.presentationBackground(presentationColor ?? .clear)
            case .mesh:
                content.presentationBackground(.clear)
            }
        } else {
            content
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("SwiftNEW") {
    SwiftNEW(
        color: .blue,
        background: .mesh,
        currentItems: SwiftNEWPreviewData.currentItems,
        historySections: SwiftNEWPreviewData.historySections
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("SwiftNEW Alternate Styling") {
    SwiftNEW(
        color: Color(.systemMint),
        background: {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        currentItems: SwiftNEWPreviewData.currentItems,
        historySections: SwiftNEWPreviewData.historySections
    )
}
