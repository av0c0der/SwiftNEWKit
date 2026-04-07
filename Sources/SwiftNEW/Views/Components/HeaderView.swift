//
//  HeaderView.swift
//  SwiftNEW
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    
    #if os(iOS)
    public var headings: some View {
        HStack {
            if contentAlignment == .leading {
                AppIconView()
                    .padding(.leading, -8)
                    .padding(.trailing, 8)
            }
            VStack(alignment: horizontalAlignment) {
                if contentAlignment == .center {
                    AppIconView()
                }
                Text(strings.whatsNewIn)
                    .bold().font(.largeTitle)
                Text("\(strings.version) \(Bundle.versionBuild)")
                    .bold().font(.title).foregroundColor(.secondary)
            }
            if contentAlignment == .trailing {
                AppIconView()
            }
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
