import Foundation

/// Customizable UI strings for ``ChangelogScreen``.
///
/// Override individual labels to localize the changelog UI:
/// ```swift
/// ChangelogScreen(
///     strings: ChangelogStrings(
///         screenTitle: "Historial de cambios",
///         continueButton: "Continuar"
///     )
/// )
/// ```
public struct ChangelogStrings: Hashable, Sendable {
    /// Label used for the inline boundary before previously seen sections.
    public var previouslySeenTitle: String

    /// Title shown at the top of the changelog screen.
    public var screenTitle: String

    /// Label for the primary dismiss button.
    public var continueButton: String

    public init(
        previouslySeenTitle: String = "Previously Seen",
        screenTitle: String = "Changelog",
        continueButton: String = "Continue"
    ) {
        self.previouslySeenTitle = previouslySeenTitle
        self.screenTitle = screenTitle
        self.continueButton = continueButton
    }

    /// English defaults.
    public static let english = Self()

    /// The default string set (English).
    public static let `default` = Self.english
}
