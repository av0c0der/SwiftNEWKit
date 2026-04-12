import Foundation

/// A named group of ``ReleaseNotes`` shown under a shared section header.
public struct ReleaseNotesSection: Codable, Hashable, Identifiable {
    public var title: String?
    public var subtitle: String?
    public var imageName: String?
    public var items: [ReleaseNotes]

    public var id: String {
        title ?? ""
    }

    public init(title: String? = nil, subtitle: String? = nil, imageName: String? = nil, items: [ReleaseNotes]) {
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case title, subtitle, imageName, items
    }
}
