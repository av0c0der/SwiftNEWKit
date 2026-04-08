//
//  ReleaseNotes.swift
//  SwiftNEW
//
//  Created by Ming on 7/1/2025.
//

import SwiftUI

public struct ReleaseNotes: Codable, Hashable {
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

public struct ReleaseNote: Codable, Hashable {
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
