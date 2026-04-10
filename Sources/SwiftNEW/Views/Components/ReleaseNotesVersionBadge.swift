import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesVersionBadge: View {
    let version: String
    let date: Date?
    var subtitle: String?
    let color: Color
    let dateFormat: Date.FormatStyle

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Text(version)
                    .bold()
                    .font(.subheadline)

                if let date {
                    Text(date, format: dateFormat)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }

            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(.regularMaterial)
        .overlay {
            RoundedRectangle(cornerRadius: ReleaseNotesLayoutMetrics.cornerRadius, style: .continuous)
                .strokeBorder(.white.opacity(0.18))
        }
        .containerShape(RoundedRectangle(cornerRadius: ReleaseNotesLayoutMetrics.cornerRadius, style: .continuous))
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.bottom)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    ReleaseNotesVersionBadge(
        version: SwiftNEWPreviewData.currentItems[0].version,
        date: SwiftNEWPreviewData.currentItems[0].date,
        color: .indigo,
        dateFormat: .dateTime.year().month().day()
    )
    .padding()
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview("With subtitle") {
    ReleaseNotesVersionBadge(
        version: SwiftNEWPreviewData.currentItems[0].version,
        date: SwiftNEWPreviewData.currentItems[0].date,
        subtitle: SwiftNEWPreviewData.currentItems[0].subtitle,
        color: .indigo,
        dateFormat: .dateTime.year().month().day()
    )
    .padding()
}
