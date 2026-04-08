//
//  SwiftNEW.swift
//  SwiftNEW
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI

// Setup presentation type of the SwiftNEW view
public enum SwiftNEWPresentation {
    case sheet
    case fullScreenCover
    case embed
}

public enum SwiftNEWTriggerStyle {
    case regular
    case mini
    case hidden
}

public enum SwiftNEWContentAlignment {
    case leading
    case center
    case trailing
}

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
public struct SwiftNEW: View {
    @State var isPresented: Bool
    @State var historySheet: Bool = false
    let currentItems: [ReleaseNotes]
    let historyItems: [ReleaseNotes]
    let contentAlignment: SwiftNEWContentAlignment
    let color: Color
    let background: SwiftNEWBackground
    let triggerStyle: SwiftNEWTriggerStyle
    let strings: SwiftNEWStrings
    let labelImage: String
    let history: Bool
    let presentation: SwiftNEWPresentation
    let dateFormat: Date.FormatStyle
    let onContinue: (() -> Void)?

    public init(
        contentAlignment: SwiftNEWContentAlignment = .center,
        color: Color = .accentColor,
        background: SwiftNEWBackground = .mesh,
        triggerStyle: SwiftNEWTriggerStyle = .regular,
        currentItems: [ReleaseNotes] = [],
        historyItems: [ReleaseNotes] = [],
        strings: SwiftNEWStrings = .default,
        labelImage: String = "arrow.up.circle.fill",
        history: Bool = true,
        presentation: SwiftNEWPresentation = .sheet,
        dateFormat: Date.FormatStyle = .dateTime.year().month().day(),
        onContinue: (() -> Void)? = nil
    ) {
        _isPresented = State(initialValue: triggerStyle == .hidden)
        self.currentItems = currentItems
        self.historyItems = historyItems
        self.contentAlignment = contentAlignment
        self.color = color
        self.background = background
        self.triggerStyle = triggerStyle
        self.strings = strings
        self.labelImage = labelImage
        self.history = history
        self.presentation = presentation
        self.dateFormat = dateFormat
        self.onContinue = onContinue
    }

    var horizontalAlignment: HorizontalAlignment {
        switch contentAlignment {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    var canShowHistory: Bool {
        history && !historyItems.isEmpty
    }
}
