import Foundation

/// A single changelog entry with an SF Symbol icon, title, and description.
public struct ReleaseNote: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var icon: String
    public var iconBackground: String?
    public var iconColor: String?
    public var borderColor: String?
    public var title: String
    public var subtitle: String?
    public var body: String

    public init(
        icon: String,
        iconBackground: String? = nil,
        iconColor: String? = nil,
        borderColor: String? = nil,
        title: String,
        subtitle: String? = nil,
        body: String
    ) {
        self.icon = icon
        self.iconBackground = iconBackground
        self.iconColor = iconColor
        self.borderColor = borderColor
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }

    enum CodingKeys: String, CodingKey {
        case icon, iconBackground, iconColor, borderColor, title, subtitle, body
    }
}
