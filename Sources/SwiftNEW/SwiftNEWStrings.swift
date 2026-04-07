//
//  SwiftNEWStrings.swift
//  SwiftNEW
//
//  Created by OpenCode on 4/7/2026.
//

import Foundation

public struct SwiftNEWStrings: Hashable, Sendable {
    public var triggerButtonLabel: String
    public var historyTitle: String
    public var showHistoryButton: String
    public var continueButton: String
    public var returnButton: String
    public var whatsNewIn: String
    public var version: String

    public init(
        triggerButtonLabel: String = "Show Release Note",
        historyTitle: String = "History",
        showHistoryButton: String = "Show History",
        continueButton: String = "Continue",
        returnButton: String = "Return",
        whatsNewIn: String = "What's New in",
        version: String = "Version"
    ) {
        self.triggerButtonLabel = triggerButtonLabel
        self.historyTitle = historyTitle
        self.showHistoryButton = showHistoryButton
        self.continueButton = continueButton
        self.returnButton = returnButton
        self.whatsNewIn = whatsNewIn
        self.version = version
    }

    public static let english = Self()
    public static let `default` = Self.english
}
