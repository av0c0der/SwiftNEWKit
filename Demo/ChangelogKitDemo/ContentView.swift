import SwiftUI
import ChangelogKit

private struct DemoChangelogData {
    let currentItems: [ReleaseNotes]
    let historySections: [ReleaseNotesSection]
}

private enum DemoChangelogLoader {
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
            let historySections = try JSONDecoder().decode([ReleaseNotesSection].self, from: data)
            return DemoChangelogData(
                currentItems: historySections.first?.items ?? [],
                historySections: historySections
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
    ChangelogScreen(
        currentItems: demoChangelogData.currentItems,
        historySections: demoChangelogData.historySections
    )
}

#Preview("Embed Arabic") {
    ChangelogScreen(
        currentItems: demoArabicChangelogData.currentItems,
        historySections: demoArabicChangelogData.historySections
    )
    .environment(\.layoutDirection, .rightToLeft)
    .environment(\.locale, Locale(identifier: "ar"))
    .environment(\.calendar, Calendar(identifier: .islamicCivil))
}
