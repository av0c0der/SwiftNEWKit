import Foundation

/// A named group of ``ReleaseNotes`` shown under a shared section header.
public struct ReleaseNotesSection: Codable, Hashable, Identifiable {
    public var title: String?
    public var imageName: String?
    public var items: [ReleaseNotes]

    public var id: String {
        title ?? ""
    }

    public init(title: String? = nil, imageName: String? = nil, items: [ReleaseNotes]) {
        self.title = title
        self.imageName = imageName
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case title, imageName, items
    }
}
