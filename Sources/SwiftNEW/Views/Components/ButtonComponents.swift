import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
extension SwiftNEW {
    public var showHistoryButton: some View {
        Button(action: {
            historySheet = true
        }) {
            HStack {
                Text(strings.showHistoryButton)
                Image(systemName: "clock.arrow.circlepath")
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
            onContinue?()
        }) {
            HStack{
                Text(strings.continueButton)
                    .bold()
                Image(systemName: "arrow.forward.circle.fill")
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
                Text(strings.returnButton)
                    .bold()
                Image(systemName: "arrow.down.circle.fill")
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

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Buttons") {
    VStack(spacing: 20) {
        SwiftNEW(
            color: .indigo,
            currentItems: SwiftNEWPreviewData.currentItems,
            historySections: SwiftNEWPreviewData.historySections
        )
        .showHistoryButton

        SwiftNEW(
            color: .indigo,
            currentItems: SwiftNEWPreviewData.currentItems,
            historySections: []
        )
        .closeCurrentButton

        SwiftNEW(
            color: .indigo,
            currentItems: SwiftNEWPreviewData.currentItems,
            historySections: []
        )
        .closeHistoryButton
    }
    .padding()
}
