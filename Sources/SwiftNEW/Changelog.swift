import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// A SwiftUI view that presents release notes and version history as a
/// polished changelog screen.
///
/// `Changelog` is a content view — present it with `.sheet`,
/// `.fullScreenCover`, or embed it directly in your view hierarchy.
///
/// ```swift
/// .fullScreenCover(isPresented: $showChangelog) {
///     Changelog(
///         currentItems: releaseNotes,
///         historySections: history,
///         onContinue: { showChangelog = false }
///     )
/// }
/// ```
@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
public struct Changelog: View {
    @State var historySheet: Bool = false

    /// Release notes shown on the main "What's New" screen.
    let currentItems: [ReleaseNotes]

    /// Grouped release history displayed in the history sheet.
    let historySections: [ReleaseNotesSection]

    /// Theme color applied to version badges and accent elements.
    let color: Color

    /// Background style for the changelog sheets.
    let background: ChangelogBackground

    /// Customizable UI strings (button labels, headings, etc.).
    let strings: ChangelogStrings

    /// Whether the history navigation button is shown.
    let history: Bool

    /// Format used when displaying release dates.
    let dateFormat: Date.FormatStyle

    /// Called when the user taps the continue/dismiss button.
    let onContinue: (() -> Void)?

    /// Creates a changelog view with sectioned history.
    ///
    /// - Parameters:
    ///   - color: Theme color for badges and buttons. Defaults to `.accentColor`.
    ///   - background: Background style. Defaults to the system background color.
    ///   - currentItems: Release notes for the current version.
    ///   - historySections: Grouped historical releases.
    ///   - strings: Override default UI copy.
    ///   - history: Show the history navigation button.
    ///   - dateFormat: Format for release dates.
    ///   - onContinue: Callback when the user dismisses the view.
    public init(
        color: Color = .accentColor,
        background: ChangelogBackground = {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        currentItems: [ReleaseNotes] = [],
        historySections: [ReleaseNotesSection] = [],
        strings: ChangelogStrings = .default,
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

    /// Convenience initializer that wraps a flat list of history items into a
    /// single unnamed section.
    ///
    /// - Parameter historyItems: A flat array of historical release notes.
    public init(
        color: Color = .accentColor,
        background: ChangelogBackground = {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        currentItems: [ReleaseNotes] = [],
        historyItems: [ReleaseNotes] = [],
        strings: ChangelogStrings = .default,
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
            ChangelogBackgroundLayer(background: background, color: color)
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
        .modifier(ChangelogPresentationModifier(background: background))
    }

    private var historySheetContent: some View {
        ZStack {
            ChangelogBackgroundLayer(background: background, color: color)
            sheetHistory
                #if os(visionOS)
                .padding()
                #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ChangelogPresentationModifier(background: background))
    }
}

// MARK: - Backward Compatibility

/// Backward-compatible alias for ``Changelog``.
@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
public typealias SwiftNEW = Changelog

// MARK: - Previews

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Changelog") {
    Changelog(
        color: .blue,
        background: .mesh,
        currentItems: ChangelogPreviewData.currentItems,
        historySections: ChangelogPreviewData.historySections
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Changelog Alternate Styling") {
    Changelog(
        color: Color(.systemMint),
        background: {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        currentItems: ChangelogPreviewData.currentItems,
        historySections: ChangelogPreviewData.historySections
    )
}
