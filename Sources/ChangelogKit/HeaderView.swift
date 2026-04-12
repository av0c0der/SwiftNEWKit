import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension ChangelogScreen {
    #if os(iOS)
    public var headings: some View {
        VStack(spacing: 0) {
            AppIconView()
            Text(strings.screenTitle)
                .bold().font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .allowsTightening(true)
        }
    }
    #elseif os(macOS) || os(visionOS) || os(tvOS)
    public var headings: some View {
        VStack {
            Text(strings.screenTitle)
                .bold().font(.largeTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .allowsTightening(true)
        }
    }
    #endif
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Header") {
    ChangelogScreen(
        color: .indigo,
        sections: ChangelogPreviewData.sections,
        lastSeenVersion: ChangelogPreviewData.lastSeenVersion
    )
    .headings
}
