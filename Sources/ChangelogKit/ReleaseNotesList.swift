import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesList: View {
    let sections: [ReleaseNotesSection]
    let color: Color
    let showsVersionBadges: Bool
    let hidesFirstVersionBadge: Bool
    let fillsScrollViewportPerSection: Bool
    let sectionBoundaryTitle: String?
    let sectionBoundaryVersion: String?
    let dateFormat: Date.FormatStyle

    @Environment(\.releaseNotesViewportHeight) private var releaseNotesViewportHeight

    private var shouldShowVersionBadges: Bool {
        showsVersionBadges && sections.reduce(0) { $0 + $1.items.count } > 1
    }

    private func shouldHideVersionBadge(section: ReleaseNotesSection, item: ReleaseNotes) -> Bool {
        hidesFirstVersionBadge && sections.first == section && section.items.first?.version == item.version
    }

    private func minimumSectionHeight(for section: ReleaseNotesSection) -> CGFloat? {
        guard fillsScrollViewportPerSection, releaseNotesViewportHeight > 0 else {
            return nil
        }

        let headerHeight = ReleaseNotesSectionHeader.totalHeight(hasImage: section.imageName?.isEmpty == false)
        return max(0, releaseNotesViewportHeight - headerHeight)
    }

    var body: some View {
        LazyVStack(alignment: .center, spacing: 0, pinnedViews: [.sectionHeaders]) {
            ForEach(sections) { section in
                Section {
                    VStack(spacing: 0) {
                        ForEach(section.items) { item in
                            VStack(spacing: 0) {
                                if let sectionBoundaryTitle,
                                   let sectionBoundaryVersion,
                                   item.version == sectionBoundaryVersion {
                                    ReleaseNotesListBoundary(title: sectionBoundaryTitle)
                                        .padding(.vertical, 32)
                                }

                                if shouldShowVersionBadges && !shouldHideVersionBadge(section: section, item: item) {
                                    ReleaseNotesVersionBadge(
                                        version: item.version,
                                        date: item.date,
                                        subtitle: item.subtitle,
                                        color: color,
                                        dateFormat: dateFormat
                                    )
                                }

                                ForEach(item.notes) { note in
                                    ReleaseNoteRow(note: note, color: color)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, minHeight: minimumSectionHeight(for: section), alignment: .top)
                } header: {
                    if let title = section.title, !title.isEmpty {
                        ReleaseNotesSectionHeader(title: title, imageName: section.imageName)
                    }
                }
            }
        }
    }
}

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
private struct ReleaseNotesListBoundary: View {
    let title: String

    var body: some View {
        HStack(spacing: 12) {
            Capsule()
                .fill(Color.accentColor)
                .frame(height: 1)

            Text(title)
                .font(.caption.weight(.semibold))
                .foregroundStyle(Color.accentColor)
                .fixedSize()

            Capsule()
                .fill(Color.accentColor)
                .frame(height: 1)
        }
        .padding(.horizontal, 16)
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    ScrollView {
        ReleaseNotesList(
            sections: ChangelogPreviewData.sections,
            color: .indigo,
            showsVersionBadges: true,
            hidesFirstVersionBadge: false,
            fillsScrollViewportPerSection: false,
            sectionBoundaryTitle: nil,
            sectionBoundaryVersion: nil,
            dateFormat: .dateTime.year().month().day()
        )
        .padding(30)
    }
}
