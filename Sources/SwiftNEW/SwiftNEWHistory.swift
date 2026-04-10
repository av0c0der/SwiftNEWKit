import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// A standalone history view that can be presented directly without showing
/// the current-version sheet first.
///
/// ```swift
/// .sheet(isPresented: $showHistory) {
///     SwiftNEWHistory(
///         historySections: historySections,
///         color: .indigo,
///         onDismiss: { showHistory = false }
///     )
/// }
/// ```
@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
public struct SwiftNEWHistory: View {
    let historySections: [ReleaseNotesSection]
    let color: Color
    let background: SwiftNEWBackground
    let strings: SwiftNEWStrings
    let dateFormat: Date.FormatStyle
    let onDismiss: (() -> Void)?

    public init(
        historySections: [ReleaseNotesSection],
        color: Color = .accentColor,
        background: SwiftNEWBackground = {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        strings: SwiftNEWStrings = .default,
        dateFormat: Date.FormatStyle = .dateTime.year().month().day(),
        onDismiss: (() -> Void)? = nil
    ) {
        self.historySections = historySections
        self.color = color
        self.background = background
        self.strings = strings
        self.dateFormat = dateFormat
        self.onDismiss = onDismiss
    }

    public var body: some View {
        ZStack {
            backgroundLayer
            content
                #if os(visionOS)
                .padding()
                #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(HistoryPresentationBackgroundModifier(background: background))
    }

    private var content: some View {
        ReleaseNotesSheetLayout {
            Text(strings.historyTitle)
                .bold().font(.largeTitle)
        } content: {
            ReleaseNotesList(
                sections: historySections,
                color: color,
                showsVersionBadges: true,
                hidesFirstVersionBadge: false,
                dateFormat: dateFormat
            )
        } footer: {
            dismissButton
        }
    }

    private var dismissButton: some View {
        Button(action: { onDismiss?() }) {
            HStack {
                Text(strings.dismissHistoryButton)
                    .bold()
                Image(systemName: "xmark.circle.fill")
            }.font(.body)
            .padding(.horizontal)
            #if os(iOS)
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(15)
            #elseif os(macOS)
            .frame(width: 300, height: 25)
            #endif
        }
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

private struct HistoryPresentationBackgroundModifier: ViewModifier {
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
#Preview("SwiftNEWHistory") {
    SwiftNEWHistory(
        historySections: SwiftNEWPreviewData.historySections,
        color: .indigo,
        background: .mesh
    )
}
