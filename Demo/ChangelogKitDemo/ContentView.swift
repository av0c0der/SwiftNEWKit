import SwiftUI
import ChangelogKit

private struct DemoChangelogData {
    let sections: [ReleaseNotesSection]
    let lastSeenVersion: String
}

private enum DemoChangelogLoader {
    private static let lastSeenVersion = "3.3.0"

    static let data: DemoChangelogData = load()
    static let arabicData: DemoChangelogData = load(localization: "ar")

    private static func load(localization: String? = nil) -> DemoChangelogData {
        guard let url = (
            localization.flatMap { Bundle.main.url(forResource: "data", withExtension: "json", subdirectory: nil, localization: $0) }
            ?? Bundle.main.url(forResource: "data", withExtension: "json")
            ?? Bundle.main.url(forResource: "data", withExtension: "json", subdirectory: nil, localization: "en")
        )
        else {
            fatalError("Missing demo changelog JSON resource.")
        }

        do {
            let data = try Data(contentsOf: url)
            let sections = try JSONDecoder().decode([ReleaseNotesSection].self, from: data)

            return DemoChangelogData(
                sections: sections,
                lastSeenVersion: lastSeenVersion
            )
        } catch {
            fatalError("Failed to decode demo changelog JSON: \(error)")
        }
    }
}

private let demoChangelogData = DemoChangelogLoader.data
private let demoArabicChangelogData = DemoChangelogLoader.arabicData

struct ContentView: View {
    @State private var showsReleaseNotes = false

    var body: some View {
        Button("Show What's New") {
            showsReleaseNotes = true
        }
        .fullScreenCover(isPresented: $showsReleaseNotes) {
            ChangelogScreen(
                sections: demoChangelogData.sections,
                lastSeenVersion: demoChangelogData.lastSeenVersion,
                onContinue: {
                    showsReleaseNotes = false
                    print("Continue tapped")
                }
            )
        }
    }
}

#Preview("Default") {
    ContentView()
}

#Preview("Embed") {
    ChangelogScreen(
        sections: demoChangelogData.sections,
        lastSeenVersion: demoChangelogData.lastSeenVersion
    )
}

#Preview("Embed Arabic") {
    ChangelogScreen(
        sections: demoArabicChangelogData.sections,
        lastSeenVersion: demoArabicChangelogData.lastSeenVersion
    )
    .environment(\.layoutDirection, .rightToLeft)
    .environment(\.locale, Locale(identifier: "ar"))
    .environment(\.calendar, Calendar(identifier: .islamicCivil))
}
