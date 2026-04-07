//
//  ButtonComponents.swift
//  SwiftNEW
//
//  Created by Ming on 11/6/2022.
//

import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    
    public var showHistoryButton: some View {
        Button(action: {
            historySheet = true
        }) {
            HStack {
                if contentAlignment == .trailing {
                    Spacer()
                }
                Text(strings.showHistoryButton)
                Image(systemName: "clock.arrow.circlepath")
                if contentAlignment == .leading {
                    Spacer()
                }
            }.font(.caption)
        }
        #if !os(visionOS)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
        .tint(.secondary)
        #endif
    }
    
    public var closeCurrentButton: some View {
        Button(action: {
            isPresented = false
            onContinue?()
        }) {
            HStack{
                if contentAlignment == .trailing {
                    Spacer()
                }
                Text(strings.continueButton)
                    .bold()
                Image(systemName: "arrow.right.circle.fill")
                if contentAlignment == .leading {
                    Spacer()
                }
            }.font(.body)
            .padding(.horizontal)
            #if os(iOS)
            .frame(width: 300, height: 50)
            #elseif os(macOS)
            .frame(width: 200, height: 25)
            #endif
            #if os(iOS) && !os(visionOS)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(15)
            #elseif os(tvOS)
            .tint(.accentColor)
            #endif
        }
    }
    
    public var closeHistoryButton: some View {
        Button(action: { historySheet = false }) {
            HStack{
                if contentAlignment == .trailing {
                    Spacer()
                }
                Text(strings.returnButton)
                    .bold()
                Image(systemName: "arrow.down.circle.fill")
                if contentAlignment == .leading {
                    Spacer()
                }
            }.font(.body)
            .padding(.horizontal)
            #if os(iOS)
            .frame(width: 300, height: 50)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .cornerRadius(15)
            #elseif os(macOS)
            .frame(width: 300, height: 25)
            #endif
        }
    }
}
