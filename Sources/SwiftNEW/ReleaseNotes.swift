import SwiftUI

public struct ReleaseNotes: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var version: String
    public var date: Date?
    public var subtitle: String?
    public var notes: [ReleaseNote]

    public init(version: String, date: Date? = nil, subtitle: String? = nil, notes: [ReleaseNote]) {
        self.version = version
        self.date = date
        self.subtitle = subtitle
        self.notes = notes
    }

    enum CodingKeys: String, CodingKey {
        case version
        case date
        case subtitle
        case notes
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        version = try container.decode(String.self, forKey: .version)
        subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        notes = try container.decode([ReleaseNote].self, forKey: .notes)

        if let dateString = try container.decodeIfPresent(String.self, forKey: .date) {
            guard let parsedDate = ReleaseNotesDateParser.decode(dateString) else {
                throw DecodingError.dataCorruptedError(
                    forKey: .date,
                    in: container,
                    debugDescription: "Expected an ISO 8601 date string, got: \(dateString)"
                )
            }
            date = parsedDate
        } else {
            date = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(version, forKey: .version)
        try container.encodeIfPresent(subtitle, forKey: .subtitle)
        try container.encode(notes, forKey: .notes)
        try container.encodeIfPresent(date.map(ReleaseNotesDateParser.encode), forKey: .date)
    }

}

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

public struct ReleaseNote: Codable, Hashable, Identifiable {
    public var id = UUID()
    public var icon: String
    public var iconBackground: String?
    public var title: String
    public var subtitle: String?
    public var body: String

    public init(
        icon: String,
        iconBackground: String? = nil,
        title: String,
        subtitle: String? = nil,
        body: String
    ) {
        self.icon = icon
        self.iconBackground = iconBackground
        self.title = title
        self.subtitle = subtitle
        self.body = body
    }

    enum CodingKeys: String, CodingKey {
        case icon, iconBackground, title, subtitle, body
    }
}

private enum ReleaseNotesDateParser {
    static func decode(_ string: String) -> Date? {
        let trimmed = string.trimmingCharacters(in: .whitespacesAndNewlines)
        return iso8601WithFractionalSeconds.date(from: trimmed) ?? iso8601.date(from: trimmed)
    }

    static func encode(_ date: Date) -> String {
        iso8601WithFractionalSeconds.string(from: date)
    }

    private static let iso8601: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter
    }()

    private static let iso8601WithFractionalSeconds: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()
}

enum SwiftNEWPreviewData {
    static let currentItems: [ReleaseNotes] = [
        ReleaseNotes(
            version: "2.1.0",
            date: Date(timeIntervalSince1970: 1_743_984_000),
            subtitle: "Current release",
            notes: [
                ReleaseNote(
                    icon: "sparkles",
                    iconBackground: "#4F46E5",
                    title: "Sectioned changelog",
                    body: "History entries can now be grouped under optional section headers."
                )
            ]
        ),
        ReleaseNotes(
            version: "2.0.1",
            date: Date(timeIntervalSince1970: 1_741_305_600),
            notes: [
                ReleaseNote(
                    icon: "wrench.and.screwdriver.fill",
                    iconBackground: "#10B981",
                    title: "Layout fixes",
                    body: "Version badges now render inside each section instead of acting as sticky headers."
                )
            ]
        )
    ]

    static let historySections: [ReleaseNotesSection] = [
        ReleaseNotesSection(
            title: "2.0 Kyoto",
            items: [
                currentItems[0],
                currentItems[1],
                ReleaseNotes(
                    version: "2.0.0",
                    date: Date(timeIntervalSince1970: 1_728_086_400),
                    notes: [
                        ReleaseNote(
                            icon: "rectangle.3.group.fill",
                            iconBackground: "#8B5CF6",
                            title: "Shared release layout",
                            subtitle: "Unified presentation",
                            body: "Current and history views now share the same visual system so larger grouped data sets feel cohesive."
                        )
                    ]
                )
            ]
        ),
        ReleaseNotesSection(
            title: "1.0 Lisbon",
            items: [
                ReleaseNotes(
                    version: "1.1.0",
                    date: Date(timeIntervalSince1970: 1_722_643_200),
                    notes: [
                        ReleaseNote(
                            icon: "paintbrush.pointed.fill",
                            iconBackground: "#EC4899",
                            title: "Visual refresh",
                            body: "Older releases can live in their own major-version section."
                        )
                    ]
                ),
                ReleaseNotes(
                    version: "1.0.0",
                    date: Date(timeIntervalSince1970: 1_707_264_000),
                    notes: [
                        ReleaseNote(
                            icon: "shippingbox.fill",
                            iconBackground: "#3B82F6",
                            title: "Composable API",
                            body: "Release notes content can now be supplied directly, making previews and demos much easier to customize."
                        )
                    ]
                )
            ]
        )
    ]

    static let sampleNote = currentItems[0].notes[0]

    // MARK: - RTL (Arabic)

    static let rtlNote = ReleaseNote(
        icon: "sparkles",
        iconBackground: "#007AFF",
        title: "سجل زمني أغنى",
        subtitle: "سجل مُجمّع",
        body: "يعرض العرض التجريبي الآن سجل تغييرات مُجمعًا داخل أقسام للإصدارات الرئيسية بدلًا من قائمة واحدة مسطحة."
    )

    static let rtlCurrentItems: [ReleaseNotes] = [
        ReleaseNotes(
            version: "2.1.0",
            date: Date(timeIntervalSince1970: 1_743_984_000),
            notes: [
                rtlNote,
                ReleaseNote(
                    icon: "slider.horizontal.3",
                    iconBackground: "#34C759",
                    title: "رؤوس أقسام مثبتة",
                    body: "أثناء التمرير، يعرض الرأس المثبت عنوان القسم النشط بدلًا من شارة الإصدار الحالية."
                )
            ]
        )
    ]

    static let rtlHistorySections: [ReleaseNotesSection] = [
        ReleaseNotesSection(
            title: "(2.0) كيوتو",
            items: [
                rtlCurrentItems[0],
                ReleaseNotes(
                    version: "2.0.0",
                    date: Date(timeIntervalSince1970: 1_728_086_400),
                    subtitle: "تحديث رئيسي",
                    notes: [
                        ReleaseNote(
                            icon: "shippingbox.fill",
                            iconBackground: "#5856D6",
                            title: "تخطيط موحد",
                            body: "اعتمد العرض التجريبي نظام تخطيط مشتركًا لأقسام الإصدارات الحالية والتاريخية."
                        )
                    ]
                )
            ]
        ),
        ReleaseNotesSection(
            title: "(1.0) لشبونة",
            items: [
                ReleaseNotes(
                    version: "1.0.0",
                    date: Date(timeIntervalSince1970: 1_707_264_000),
                    subtitle: "تحديث رئيسي",
                    notes: [
                        ReleaseNote(
                            icon: "square.grid.2x2.fill",
                            iconBackground: "#0A84FF",
                            title: "تقسيم المكونات",
                            body: "تم تقسيم عرض ملاحظات الإصدار إلى أجزاء أصغر قابلة لإعادة الاستخدام داخل التطبيق التجريبي."
                        )
                    ]
                )
            ]
        )
    ]
}
