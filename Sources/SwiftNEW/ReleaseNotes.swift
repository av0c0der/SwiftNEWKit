//
//  ReleaseNotes.swift
//  SwiftNEW
//
//  Created by Ming on 7/1/2025.
//

import SwiftUI

public struct ReleaseNotes: Codable, Hashable {
    public var version: String
    public var subtitle: String?
    public var notes: [ReleaseNote]

    public init(version: String, subtitle: String? = nil, notes: [ReleaseNote]) {
        self.version = version
        self.subtitle = subtitle
        self.notes = notes
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
