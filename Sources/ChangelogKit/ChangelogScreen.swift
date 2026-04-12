import SwiftUI

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

/// A SwiftUI view that presents grouped release notes on a single changelog screen.
///
/// `ChangelogScreen` is a content view — present it with `.sheet`,
/// `.fullScreenCover`, or embed it directly in your view hierarchy.
///
/// ```swift
/// .fullScreenCover(isPresented: $showChangelog) {
///     ChangelogScreen(
///         sections: releaseSections,
///         lastSeenVersion: "3.0.0",
///         onContinue: { showChangelog = false }
///     )
/// }
/// ```
@available(iOS 15.0, watchOS 8.0, macOS 14.0, tvOS 17.0, *)
public struct ChangelogScreen: View {
    /// Grouped release sections shown on the changelog screen.
    let sections: [ReleaseNotesSection]

    /// Version where previously seen changes begin.
    let lastSeenVersion: String?

    /// Theme color applied to version badges and accent elements.
    let color: Color

    /// Background style for the changelog screen.
    let background: ChangelogBackground

    /// Customizable UI strings.
    let strings: ChangelogStrings

    /// Format used when displaying release dates.
    let dateFormat: Date.FormatStyle

    /// Called when the user taps the continue/dismiss button.
    let onContinue: (() -> Void)?

    /// Creates a changelog view with grouped sections.
    ///
    /// - Parameters:
    ///   - color: Theme color for badges and buttons. Defaults to `.accentColor`.
    ///   - background: Background style. Defaults to the system background color.
    ///   - sections: Grouped release sections ordered from newest to oldest.
    ///   - lastSeenVersion: The first version that should appear below the
    ///     previously-seen divider.
    ///   - strings: Override default UI copy.
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
        sections: [ReleaseNotesSection] = [],
        lastSeenVersion: String? = nil,
        strings: ChangelogStrings = .default,
        dateFormat: Date.FormatStyle = .dateTime.year().month().day(),
        onContinue: (() -> Void)? = nil
    ) {
        self.sections = sections
        self.lastSeenVersion = lastSeenVersion
        self.color = color
        self.background = background
        self.strings = strings
        self.dateFormat = dateFormat
        self.onContinue = onContinue
    }

    public var body: some View {
        ZStack {
            ChangelogBackgroundLayer(background: background, color: color)
            changelog
                #if os(visionOS)
                .padding()
                #endif
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .modifier(ChangelogPresentationModifier(background: background))
    }

    private var changelog: some View {
        ReleaseNotesSheetLayout {
            headings
                .padding(.horizontal)
        } content: {
            ReleaseNotesList(
                sections: sections,
                color: color,
                showsVersionBadges: true,
                hidesFirstVersionBadge: false,
                fillsScrollViewportPerSection: false,
                sectionBoundaryTitle: lastSeenVersion == nil ? nil : strings.previouslySeenTitle,
                sectionBoundaryVersion: lastSeenVersion,
                dateFormat: dateFormat
            )
        } footer: {
            closeCurrentButton
        }
    }
}

// MARK: - Previews

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Changelog") {
    ChangelogScreen(
        color: .blue,
        background: .mesh,
        sections: ChangelogPreviewData.sections,
        lastSeenVersion: ChangelogPreviewData.lastSeenVersion
    )
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Changelog Alternate Styling") {
    ChangelogScreen(
        color: Color(.systemMint),
        background: {
            #if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
            .background(Color(UIColor.systemBackground))
            #elseif os(macOS)
            .background(Color(NSColor.windowBackgroundColor))
            #endif
        }(),
        sections: ChangelogPreviewData.sections,
        lastSeenVersion: ChangelogPreviewData.lastSeenVersion
    )
}
