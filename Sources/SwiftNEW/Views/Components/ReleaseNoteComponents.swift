//
//  ReleaseNoteComponents.swift
//  SwiftNEW
//
//  Created by OpenCode on 4/7/2026.
//

import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesSheetLayout<Header: View, Content: View, Footer: View>: View {
    let align: SwiftNEWContentAlignment
    @ViewBuilder let header: () -> Header
    @ViewBuilder let content: () -> Content
    @ViewBuilder let footer: () -> Footer

    private var horizontalAlignment: HorizontalAlignment {
        switch align {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    var body: some View {
        VStack(alignment: horizontalAlignment) {
            Spacer()

            header()
                .padding(.bottom)

            Spacer()

            ScrollView(showsIndicators: false) {
                content()
            }
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

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNoteRow: View {
    let note: ReleaseNote
    let align: SwiftNEWContentAlignment
    let color: Color

    private var iconBackground: Color {
        Color(hex: note.iconBackground ?? "") ?? color
    }

    private var textAlignment: HorizontalAlignment {
        align == .trailing ? .trailing : .leading
    }

    var body: some View {
        HStack {
            if align == .leading || align == .center {
                iconView
                    .padding(.trailing)
            } else {
                Spacer()
            }

            VStack(alignment: textAlignment) {
                Text(note.title).font(.headline)
                if let subtitle = note.subtitle {
                    Text(subtitle).font(.subheadline).foregroundColor(.secondary)
                }
                Text(note.body).font(.caption).foregroundColor(.secondary)
            }

            if align == .trailing {
                iconView
                    .padding(.leading)
            } else {
                Spacer()
            }
        }
        .padding(.bottom)
    }

    private var iconView: some View {
        ZStack {
            iconBackground
            Image(systemName: note.icon)
                .foregroundColor(Color.white)
        }
        #if !os(tvOS)
        .frame(width: 50, height: 50)
        #else
        .frame(width: 100, height: 100)
        #endif
        .cornerRadius(15)
    }
}

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesVersionBadge: View {
    let version: String
    let date: Date?
    let subtitle: String?
    let color: Color
    let align: SwiftNEWContentAlignment
    let dateFormat: Date.FormatStyle

    private var horizontalAlignment: HorizontalAlignment {
        switch align {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    private var frameAlignment: Alignment {
        switch align {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    var body: some View {
        VStack(alignment: horizontalAlignment, spacing: 4) {
            HStack(spacing: 8) {
                Text(version)
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(color.adaptedTextColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(color)
                    .clipShape(Capsule())

                if let date {
                    Text(date, format: dateFormat)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                }
            }

            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(align == .trailing ? .trailing : (align == .center ? .center : .leading))
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: frameAlignment)
        .background(.regularMaterial)
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .strokeBorder(.white.opacity(0.18))
        }
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.bottom)
    }
}

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesList: View {
    let items: [ReleaseNotes]
    let align: SwiftNEWContentAlignment
    let color: Color
    let showsVersionBadges: Bool
    let hidesFirstVersionBadge: Bool
    let dateFormat: Date.FormatStyle

    private var horizontalAlignment: HorizontalAlignment {
        switch align {
        case .leading:
            .leading
        case .center:
            .center
        case .trailing:
            .trailing
        }
    }

    private var shouldShowVersionBadges: Bool {
        showsVersionBadges && items.count > 1
    }

    private func noteID(sectionIndex: Int, noteIndex: Int) -> String {
        "\(sectionIndex)-\(noteIndex)"
    }

    private func indexedNotes(for item: ReleaseNotes, sectionIndex: Int) -> [(id: String, note: ReleaseNote)] {
        item.notes.enumerated().map { noteIndex, note in
            (id: noteID(sectionIndex: sectionIndex, noteIndex: noteIndex), note: note)
        }
    }

    var body: some View {
        LazyVStack(alignment: horizontalAlignment, spacing: 0, pinnedViews: [.sectionHeaders]) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]

                Section {
                    ForEach(indexedNotes(for: item, sectionIndex: index), id: \.id) { entry in
                        ReleaseNoteRow(note: entry.note, align: align, color: color)
                    }
                } header: {
                    if shouldShowVersionBadges && !(hidesFirstVersionBadge && index == 0) {
                        ReleaseNotesVersionBadge(
                            version: item.version,
                            date: item.date,
                            subtitle: item.subtitle,
                            color: color,
                            align: align,
                            dateFormat: dateFormat
                        )
                    }
                }
            }
        }
    }
}
