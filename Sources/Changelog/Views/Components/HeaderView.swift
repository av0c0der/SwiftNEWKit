import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension Changelog {
    #if os(iOS)
    public var headings: some View {
        VStack {
            AppIconView()
            Text(strings.whatsNewIn)
                .bold().font(.largeTitle)
            Text("\(strings.version) \(Bundle.versionBuild)")
                .bold().font(.title).foregroundColor(.secondary)
        }
    }
    #elseif os(macOS) || os(visionOS) || os(tvOS)
    public var headings: some View {
        VStack {
            Text(strings.whatsNewIn)
                .bold().font(.largeTitle)
            Text("\(strings.version) \(Bundle.versionBuild)")
                .bold().font(.title).foregroundColor(.secondary)
        }
    }
    #endif
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Header") {
    Changelog(
        color: .indigo,
        currentItems: ChangelogPreviewData.currentItems,
        historySections: []
    )
    .headings
}
