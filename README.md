# SwiftNEW

A SwiftUI "What's New" view for iOS, macOS, tvOS, and visionOS. Render release notes with customizable backgrounds, grouped version history, and adaptive styling.

## Usage

```swift
import SwiftNEW

struct ContentView: View {
    @State private var showNew = false

    var body: some View {
        Button("What's New") { showNew = true }
            .fullScreenCover(isPresented: $showNew) {
                SwiftNEW(
                    currentItems: [
                        ReleaseNotes(
                            version: "1.0.0",
                            notes: [
                                ReleaseNote(icon: "sparkles", title: "Welcome", body: "Thanks for downloading!")
                            ]
                        )
                    ],
                    onContinue: { showNew = false }
                )
            }
    }
}
```

SwiftNEW is a content view — present it with `.sheet`, `.fullScreenCover`, or embed it directly.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `currentItems` | `[ReleaseNotes]` | `[]` | Release notes for the main view |
| `historySections` | `[ReleaseNotesSection]` | `[]` | Grouped items for the history sheet |
| `color` | `Color` | `.accentColor` | Theme color for badges and buttons |
| `background` | `SwiftNEWBackground` | system | `.solidColor(.blue)`, `.mesh`, or `.custom(view)` |
| `strings` | `SwiftNEWStrings` | `.default` | Override UI copy |
| `history` | `Bool` | `true` | Show history navigation |
| `dateFormat` | `Date.FormatStyle` | year-month-day | Date display format |
| `onContinue` | `(() -> Void)?` | `nil` | Continue button callback |

A convenience initializer also accepts a flat `historyItems: [ReleaseNotes]` array.

## Data Models

```swift
struct ReleaseNotes: Codable, Hashable {
    var version: String
    var date: Date?
    var subtitle: String?
    var notes: [ReleaseNote]
}

struct ReleaseNotesSection: Codable, Hashable {
    var title: String?
    var items: [ReleaseNotes]
}

struct ReleaseNote: Codable, Hashable {
    var icon: String            // SF Symbol name
    var iconBackground: String? // Hex color, e.g. "#007AFF"
    var title: String
    var subtitle: String?
    var body: String
}
```

These match the JSON format — decode a `ChangelogPayload` to get `currentItems` and `historySections`.

## Platforms

iOS 15+ · macOS 12+ · tvOS 17+ · visionOS 1+ · watchOS 8+

## License

MIT
