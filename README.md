# ChangelogKit

A SwiftUI changelog view for iOS, macOS, tvOS, and visionOS. Render grouped release notes in one screen with a divider for previously seen updates.

## Usage

```swift
import ChangelogKit

struct ContentView: View {
    @State private var showChangelog = false

    var body: some View {
        Button("What's New") { showChangelog = true }
            .fullScreenCover(isPresented: $showChangelog) {
                ChangelogScreen(
                    sections: [
                        ReleaseNotesSection(
                            title: "1.0",
                            items: [
                                ReleaseNotes(
                                    version: "1.1.0",
                                    notes: [
                                        ReleaseNote(icon: "sparkles", title: "Welcome", body: "Thanks for downloading!")
                                    ]
                                ),
                                ReleaseNotes(
                                    version: "1.0.0",
                                    notes: [
                                        ReleaseNote(icon: "shippingbox.fill", title: "Launch", body: "The first public release is here.")
                                    ]
                                )
                            ]
                        )
                    ],
                    lastSeenVersion: "1.0.0",
                    onContinue: { showChangelog = false }
                )
            }
    }
}
```

`ChangelogScreen` is a content view — present it with `.sheet`, `.fullScreenCover`, or embed it directly.

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `sections` | `[ReleaseNotesSection]` | `[]` | Grouped release sections ordered from newest to oldest |
| `lastSeenVersion` | `String?` | `nil` | The first version shown below the previously-seen divider |
| `color` | `Color` | `.accentColor` | Theme color for badges and buttons |
| `background` | `ChangelogBackground` | system | `.solidColor(.blue)`, `.mesh`, or `.custom(view)` |
| `strings` | `ChangelogStrings` | `.default` | Override UI copy |
| `dateFormat` | `Date.FormatStyle` | year-month-day | Date display format |
| `onContinue` | `(() -> Void)?` | `nil` | Continue button callback |

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
    var subtitle: String?
    var imageName: String?
    var items: [ReleaseNotes]
}

struct ReleaseNote: Codable, Hashable {
    var icon: String            // SF Symbol name
    var iconBackground: String? // Hex color, e.g. "#007AFF"
    var iconColor: String?      // Icon tint override
    var borderColor: String?    // Icon border color
    var title: String
    var subtitle: String?
    var body: String
}
```

These conform to `Codable` — decode directly from JSON.

## Background Styles

```swift
ChangelogScreen(background: .solidColor(.blue))   // Solid color
ChangelogScreen(background: .mesh)                 // Adaptive mesh gradient (iOS 18+)
ChangelogScreen(background: .custom(MyGradient())) // Any SwiftUI view
```

## Platforms

iOS 15+ · macOS 12+ · tvOS 17+ · visionOS 1+ · watchOS 8+

## License

MIT
