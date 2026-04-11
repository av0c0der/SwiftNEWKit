import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension ChangelogScreen {
    var sheetCurrent: some View {
        ReleaseNotesSheetLayout {
            headings
                .padding(.horizontal)
        } content: {
            ReleaseNotesList(
                sections: [ReleaseNotesSection(items: currentItems)],
                color: color,
                showsVersionBadges: true,
                hidesFirstVersionBadge: true,
                dateFormat: dateFormat
            )
        } footer: {
            VStack {
                if canShowHistory {
                    showHistoryButton
                }
                closeCurrentButton
            }
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Current Sheet") {
    ChangelogScreen(
        color: .indigo,
        background: .mesh,
        currentItems: ChangelogPreviewData.currentItems,
        historySections: ChangelogPreviewData.historySections
    )
    .sheetCurrent
    .padding()
}
