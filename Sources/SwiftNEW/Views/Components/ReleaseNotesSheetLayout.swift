import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesSheetLayout<Header: View, Content: View, Footer: View>: View {
    @ViewBuilder let header: () -> Header
    @ViewBuilder let content: () -> Content
    @ViewBuilder let footer: () -> Footer

    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            header()
                .padding(.bottom)

            Spacer()

            ScrollView(showsIndicators: false) {
                content()
            }
            .clipShape(RoundedRectangle(cornerRadius: ReleaseNotesLayoutMetrics.cornerRadius, style: .continuous))
            #if !os(tvOS)
            .frame(width: 300)
            #elseif !os(macOS)
            .frame(maxHeight: UIScreen.main.bounds.height * 0.5)
            #endif

            Spacer()

            footer()
                .padding(.bottom)
        }
        #if os(macOS)
        .padding()
        .frame(width: 600, height: 600)
        #elseif os(tvOS)
        .frame(width: 600)
        #endif
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    ReleaseNotesSheetLayout {
        Text("What's New")
            .font(.largeTitle.bold())
    } content: {
        ReleaseNotesList(
            sections: SwiftNEWPreviewData.historySections,
            color: .indigo,
            showsVersionBadges: true,
            hidesFirstVersionBadge: false,
            dateFormat: .dateTime.year().month().day()
        )
    } footer: {
        Button("Continue") {}
            .buttonStyle(.borderedProminent)
    }
    .padding()
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("RTL") {
    ReleaseNotesSheetLayout {
        Text("ما الجديد")
            .font(.largeTitle.bold())
    } content: {
        ReleaseNotesList(
            sections: SwiftNEWPreviewData.rtlHistorySections,
            color: .indigo,
            showsVersionBadges: true,
            hidesFirstVersionBadge: false,
            dateFormat: .dateTime.year().month().day()
        )
    } footer: {
        Button("متابعة") {}
            .buttonStyle(.borderedProminent)
    }
    .padding()
    .environment(\.layoutDirection, .rightToLeft)
    .environment(\.locale, Locale(identifier: "ar"))
    .environment(\.calendar, Calendar(identifier: .islamicCivil))
}
