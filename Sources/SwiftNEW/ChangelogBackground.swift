import SwiftUI

/// Controls the background style of ``Changelog`` and ``ChangelogHistory``
/// sheets.
///
/// Use the static factory methods to create a background:
/// ```swift
/// Changelog(background: .mesh)
/// Changelog(background: .solidColor(.blue))
/// Changelog(background: .custom(MyGradient()))
/// ```
public struct ChangelogBackground {
    enum Storage {
        case view(AnyView, presentationColor: Color?)
        case mesh
    }

    let storage: Storage

    private init(storage: Storage) {
        self.storage = storage
    }

    /// A solid color background that also tints the sheet presentation chrome.
    public static func background(_ color: Color) -> Self {
        Self(storage: .view(AnyView(color), presentationColor: color))
    }

    /// A custom view used as the background layer.
    public static func background<V: View>(_ view: V) -> Self {
        Self(storage: .view(AnyView(view), presentationColor: nil))
    }

    /// Convenience alias for ``background(_:)-7x3nv``.
    public static func solidColor(_ color: Color) -> Self {
        background(color)
    }

    /// Convenience alias for ``background(_:)-1lpqt``.
    public static func custom<V: View>(_ view: V) -> Self {
        background(view)
    }

    /// An adaptive mesh gradient that uses the theme color.
    /// Falls back to a linear gradient on platforms earlier than iOS 18.
    public static let mesh = Self(storage: .mesh)
}

// MARK: - Backward Compatibility

/// Backward-compatible alias for ``ChangelogBackground``.
public typealias SwiftNEWBackground = ChangelogBackground

// MARK: - Shared Internal Views

/// Renders the appropriate background layer for a changelog sheet.
@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ChangelogBackgroundLayer: View {
    let background: ChangelogBackground
    let color: Color

    var body: some View {
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

/// Applies the correct presentation background based on the changelog
/// background style. On older platforms this is a no-op.
@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ChangelogPresentationModifier: ViewModifier {
    let background: ChangelogBackground

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
