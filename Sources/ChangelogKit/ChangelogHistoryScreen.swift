import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// A standalone history view that presents grouped release notes without
/// showing the current-version screen first.
///
/// Use this when you want to offer a dedicated "Version History" screen
/// independent of the "What's New" flow.
///
/// ```swift
/// .sheet(isPresented: $showHistory) {
///     ChangelogHistoryScreen(
///         historySections: historySections,
///         color: .indigo,
///         onDismiss: { showHistory = false }
///     )
/// }
/// ```
@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
public struct ChangelogHistoryScreen: View {
    /// Grouped release sections to display.
    let historySections: [ReleaseNotesSection]

    /// Theme color for version badges and accents.
    let color: Color

    /// Background style for the sheet.
    let background: ChangelogBackground

    /// Customizable UI strings.
    let strings: ChangelogStrings

    /// Format used when displaying release dates.
    let dateFormat: Date.FormatStyle

    /// Called when the user dismisses the history view.
    let onDismiss: (() -> Void)?

    /// Creates a standalone history view.
    ///
    /// - Parameters:
    ///   - historySections: Grouped historical releases.
    ///   - color: Theme color. Defaults to `.accentColor`.
    ///   - background: Background style. Defaults to the system background color.
    ///   - strings: Override default UI copy.
    ///   - dateFormat: Format for release dates.
    ///   - onDismiss: Callback when the user dismisses the view.
    public init(
        historySections: [ReleaseNotesSection],
        color: Color = .accentColor,
        background: ChangelogBackground = {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        strings: ChangelogStrings = .default,
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
            ChangelogBackgroundLayer(background: background, color: color)
            content
                #if os(visionOS)
                .padding()
                #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ChangelogPresentationModifier(background: background))
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
            Text(strings.dismissHistoryButton)
                .bold()
                .font(.body)
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
}

// MARK: - Previews

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("ChangelogHistory") {
    ChangelogHistoryScreen(
        historySections: ChangelogPreviewData.historySections,
        color: .indigo,
        background: .mesh
    )
}
