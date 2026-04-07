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
    let subtitle: String?
    let color: Color

    var body: some View {
        HStack(spacing: 4) {
            Text(version)
                .bold()
                .font(.subheadline)
            if let subtitle, !subtitle.isEmpty {
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(color.adaptedTextColor.opacity(0.8))
            }
        }
        .foregroundColor(color.adaptedTextColor)
        .padding(.horizontal, 12)
        .frame(minHeight: 30)
        .background(color.opacity(0.25))
        .cornerRadius(15)
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

    private var shouldShowVersionBadges: Bool {
        showsVersionBadges && items.count > 1
    }

    var body: some View {
        ForEach(Array(items.enumerated()), id: \.element) { index, item in
            if shouldShowVersionBadges && !(hidesFirstVersionBadge && index == 0) {
                ReleaseNotesVersionBadge(version: item.version, subtitle: item.subtitle, color: color)
            }

            ForEach(item.notes, id: \.self) { note in
                ReleaseNoteRow(note: note, align: align, color: color)
            }
        }
    }
}
