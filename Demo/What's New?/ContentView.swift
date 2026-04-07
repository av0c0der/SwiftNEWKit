//
//  ContentView.swift
//  What's New?
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI
import SwiftNEW

private let demoCurrentItems = [
    ReleaseNotes(
        version: "6.2",
        notes: [
            ReleaseNote(
                icon: "sparkles",
                iconBackground: "#007AFF",
                title: "Fresh Design",
                subtitle: "Updated visuals",
                body: "The release notes screen now uses injected content instead of loading JSON internally."
            ),
            ReleaseNote(
                icon: "slider.horizontal.3",
                iconBackground: "#34C759",
                title: "Simpler API",
                body: "Customize copy with SwiftNEWStrings and pass release items directly in the initializer."
            )
        ]
    ),
    ReleaseNotes(
        version: "6.1",
        subtitle: "Missed release",
        notes: [
            ReleaseNote(
                icon: "tray.full",
                iconBackground: "#FF9500",
                title: "Better Presentation",
                subtitle: "Current items are supplied directly",
                body: "The current release screen can now render multiple missed release sections in order."
            ),
            ReleaseNote(
                icon: "paintbrush.pointed",
                iconBackground: "#AF52DE",
                title: "Background Cleanup",
                body: "Background configuration is now explicit and simpler to reason about."
            )
        ]
    )
]

private let demoHistoryItems = [
    ReleaseNotes(
        version: "6.2",
        notes: [
            ReleaseNote(
                icon: "sparkles",
                iconBackground: "#007AFF",
                title: "Fresh Design",
                subtitle: "Updated visuals",
                body: "The release notes screen now uses injected content instead of loading JSON internally."
            ),
            ReleaseNote(
                icon: "slider.horizontal.3",
                iconBackground: "#34C759",
                title: "Simpler API",
                body: "Customize copy with SwiftNEWStrings and pass release items directly in the initializer."
            )
        ]
    ),
    ReleaseNotes(
        version: "6.1",
        subtitle: "Previous release",
        notes: [
            ReleaseNote(
                icon: "wand.and.stars",
                iconBackground: "#AF52DE",
                title: "Previous Release",
                body: "History items are now supplied separately from current release items."
            )
        ]
    ),
    ReleaseNotes(
        version: "6.0",
        subtitle: "Refactor",
        notes: [
            ReleaseNote(
                icon: "rectangle.3.group",
                iconBackground: "#FF9500",
                title: "Shared Components",
                body: "History and current release layouts now reuse the same underlying components."
            )
        ]
    ),
    ReleaseNotes(
        version: "5.9",
        subtitle: "Earlier",
        notes: [
            ReleaseNote(
                icon: "text.bubble",
                iconBackground: "#32ADE6",
                title: "String Overrides",
                body: "All visible copy can be configured through SwiftNEWStrings."
            )
        ]
    )
]

struct ContentView : View {
    var body: some View {
        SwiftNEW(
            background: .solidColor(Color(.systemBackground)),
            currentItems: demoCurrentItems,
            historyItems: demoHistoryItems,
            onContinue: {
                print("Continue tapped")
            }
        )
    }
}

#Preview("Default") {
    ContentView()
}

// Mini (Toolbar / List only)
#Preview("Mini") {
        List {
            Section(header: Text("Compatible with Toolbar / List")) {
            SwiftNEW(triggerStyle: .mini, currentItems: demoCurrentItems, historyItems: demoHistoryItems)
            }
        }
}

#Preview("Invisible") {
    SwiftNEW(triggerStyle: .hidden, currentItems: demoCurrentItems, historyItems: demoHistoryItems)
}

// Full Screen Cover (>6.2.0) - Presentation option
#Preview("Full Screen Cover") {
    SwiftNEW(currentItems: demoCurrentItems, historyItems: demoHistoryItems, presentation: .fullScreenCover)
}

// Embed (>6.2.0) - Render content directly
#Preview("Embed") {
    SwiftNEW(currentItems: demoCurrentItems, historyItems: demoHistoryItems, presentation: .embed)
}
