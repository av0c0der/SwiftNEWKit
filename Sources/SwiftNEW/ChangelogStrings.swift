import Foundation

/// Customizable UI strings for ``Changelog`` and ``ChangelogHistory``.
///
/// Override individual labels to localize the changelog UI:
/// ```swift
/// Changelog(
///     strings: ChangelogStrings(
///         historyTitle: "Historial",
///         continueButton: "Continuar"
///     )
/// )
/// ```
public struct ChangelogStrings: Hashable, Sendable {
    /// Title shown at the top of the history sheet.
    public var historyTitle: String

    /// Label for the button that opens the history sheet.
    public var showHistoryButton: String

    /// Label for the primary dismiss button on the current-version sheet.
    public var continueButton: String

    /// Label for the button that returns from history to the current-version sheet.
    public var returnButton: String

    /// Label for the dismiss button on the standalone history view.
    public var dismissHistoryButton: String

    /// Heading text shown before the app name (e.g. "What's New in").
    public var whatsNewIn: String

    /// Label preceding the version number in the header.
    public var version: String

    public init(
        historyTitle: String = "History",
        showHistoryButton: String = "Show History",
        continueButton: String = "Continue",
        returnButton: String = "Return",
        dismissHistoryButton: String = "Done",
        whatsNewIn: String = "What's New in",
        version: String = "Version"
    ) {
        self.historyTitle = historyTitle
        self.showHistoryButton = showHistoryButton
        self.continueButton = continueButton
        self.returnButton = returnButton
        self.dismissHistoryButton = dismissHistoryButton
        self.whatsNewIn = whatsNewIn
        self.version = version
    }

    /// English defaults.
    public static let english = Self()

    /// The default string set (English).
    public static let `default` = Self.english
}

// MARK: - Backward Compatibility

/// Backward-compatible alias for ``ChangelogStrings``.
public typealias SwiftNEWStrings = ChangelogStrings
