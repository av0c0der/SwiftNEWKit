//
//  HistorySheet.swift
//  SwiftNEW
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    public var sheetHistory: some View {
        ReleaseNotesSheetLayout(align: contentAlignment) {
            Text(strings.historyTitle)
                .bold().font(.largeTitle)
        } content: {
            ReleaseNotesList(items: historyItems, align: contentAlignment, color: color, showsVersionBadges: true, hidesFirstVersionBadge: false)
        } footer: {
            closeHistoryButton
        }
    }
}
