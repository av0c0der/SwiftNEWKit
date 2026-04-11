import Foundation

/// A named group of ``ReleaseNotes`` shown under a shared section header.
public struct ReleaseNotesSection: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var title: String?
    public var items: [ReleaseNotes]

    public init(title: String? = nil, items: [ReleaseNotes]) {
        self.title = title
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case title, items
    }
}
