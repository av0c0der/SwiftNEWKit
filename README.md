# ChangelogKit

A SwiftUI changelog view for iOS, macOS, tvOS, and visionOS. Render release notes with customizable backgrounds, grouped version history, and adaptive styling.

## Usage

```swift
import ChangelogKit

struct ContentView: View {
    @State private var showChangelog = false

    var body: some View {
        Button("What's New") { showChangelog = true }
            .fullScreenCover(isPresented: $showChangelog) {
                ChangelogScreen(
                    currentItems: [
                        ReleaseNotes(
                            version: "1.0.0",
                            notes: [
                                ReleaseNote(icon: "sparkles", title: "Welcome", body: "Thanks for downloading!")
                            ]
                        )
                    ],
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
| `currentItems` | `[ReleaseNotes]` | `[]` | Release notes for the main view |
| `historySections` | `[ReleaseNotesSection]` | `[]` | Grouped items for the history sheet |
| `color` | `Color` | `.accentColor` | Theme color for badges and buttons |
| `background` | `ChangelogBackground` | system | `.solidColor(.blue)`, `.mesh`, or `.custom(view)` |
| `strings` | `ChangelogStrings` | `.default` | Override UI copy |
| `history` | `Bool` | `true` | Show history navigation |
| `dateFormat` | `Date.FormatStyle` | year-month-day | Date display format |
| `onContinue` | `(() -> Void)?` | `nil` | Continue button callback |

A convenience initializer also accepts a flat `historyItems: [ReleaseNotes]` array.

### Standalone History

Use `ChangelogHistoryScreen` to present version history directly:

```swift
.sheet(isPresented: $showHistory) {
    ChangelogHistoryScreen(
        historySections: sections,
        color: .indigo,
        onDismiss: { showHistory = false }
    )
}
```

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
