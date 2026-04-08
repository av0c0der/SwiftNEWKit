//
//  CurrentVersionSheet.swift
//  SwiftNEW
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    public var sheetCurrent: some View {
        ReleaseNotesSheetLayout(align: contentAlignment) {
            headings
        } content: {
            ReleaseNotesList(
                items: currentItems,
                align: contentAlignment,
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
