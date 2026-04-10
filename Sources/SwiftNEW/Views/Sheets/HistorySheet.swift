import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    public var sheetHistory: some View {
        ReleaseNotesSheetLayout {
            Text(strings.historyTitle)
                .bold().font(.largeTitle)
        } content: {
            ReleaseNotesList(
                sections: historySections,
                color: color,
                showsVersionBadges: true,
                hidesFirstVersionBadge: false,
                dateFormat: dateFormat
            )
        } footer: {
            closeHistoryButton
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("History Sheet") {
    SwiftNEW(
        color: .indigo,
        background: .mesh,
        currentItems: SwiftNEWPreviewData.currentItems,
        historySections: SwiftNEWPreviewData.historySections
    )
    .sheetHistory
    .padding()
}
