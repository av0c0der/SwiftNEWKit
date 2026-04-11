import SwiftUI
import Changelog

private struct DemoChangelogData: Decodable {
    let currentItems: [ReleaseNotes]
    let historySections: [ReleaseNotesSection]
}

private enum DemoChangelogLoader {
    static let data: DemoChangelogData = load()

    private static func load() -> DemoChangelogData {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
            ?? Bundle.main.url(forResource: "data", withExtension: "json", subdirectory: nil, localization: "en")
        else {
            fatalError("Missing demo changelog JSON resource.")
        }

        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(DemoChangelogData.self, from: data)
        } catch {
            fatalError("Failed to decode demo changelog JSON: \(error)")
        }
    }
}

private let demoChangelogData = DemoChangelogLoader.data

struct ContentView: View {
    @State private var showsReleaseNotes = false

    var body: some View {
        Button("Show What's New") {
            showsReleaseNotes = true
        }
        .fullScreenCover(isPresented: $showsReleaseNotes) {
            Changelog(
                currentItems: demoChangelogData.currentItems,
                historySections: demoChangelogData.historySections,
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
    Changelog(
        currentItems: demoChangelogData.currentItems,
        historySections: demoChangelogData.historySections
    )
}
