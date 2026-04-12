import SwiftUI

@available(iOS 15.0, watchOS 8.0, macOS 12.0, tvOS 17.0, *)
struct ReleaseNotesSectionHeader: View {
    let title: String
    let imageName: String?
    
    var hasImage: Bool {
        imageName?.isEmpty == false
    }

    var body: some View {
        Text(title)
            .font(hasImage ? Font.title.weight(.bold) : Font.headline)
            .foregroundStyle(titleColor)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 20)
        .background {
            ZStack {
                if let imageName, !imageName.isEmpty {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()

                    LinearGradient(
                        colors: [.black.opacity(0.55), .black.opacity(0.15)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                } else {
                    Rectangle()
                        .fill(.regularMaterial)
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: ReleaseNotesLayoutMetrics.cornerRadius, style: .continuous))
        .padding(.bottom)
    }

    private var titleColor: Color {
        if let imageName, !imageName.isEmpty {
            return .white
        }

        return .primary
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
    ReleaseNotesSectionHeader(title: "2.0", imageName: nil)
        .padding()
}
