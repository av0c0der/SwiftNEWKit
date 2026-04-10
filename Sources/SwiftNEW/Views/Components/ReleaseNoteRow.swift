import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNoteRow: View {
    let note: ReleaseNote
    let color: Color

    private var iconBackground: Color {
        Color(hex: note.iconBackground ?? "") ?? color
    }

    var body: some View {
        HStack {
            iconView

            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color.primary.opacity(0.7))
                if let subtitle = note.subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                }
                Text(note.body)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
            }
            .foregroundColor(.secondary)

            Spacer()
        }
        .padding(.bottom)
    }

    private var iconView: some View {
        ZStack {
            iconBackground
            Image(systemName: note.icon)
                .foregroundColor(.white)
        }
        #if !os(tvOS)
        .frame(width: 50, height: 50)
        #else
        .frame(width: 100, height: 100)
        #endif
        .cornerRadius(15)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Release Note Row") {
    ReleaseNoteRow(note: SwiftNEWPreviewData.sampleNote, color: .indigo)
        .padding()
        .frame(maxWidth: 360)
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("Release Note Row (RTL)") {
    ReleaseNoteRow(note: SwiftNEWPreviewData.rtlNote, color: .indigo)
        .padding()
        .frame(maxWidth: 360)
        .environment(\.layoutDirection, .rightToLeft)
        .environment(\.locale, Locale(identifier: "ar"))
        .environment(\.calendar, Calendar(identifier: .islamicCivil))
}
