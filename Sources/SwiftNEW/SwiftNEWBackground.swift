import SwiftUI

public struct SwiftNEWBackground {
    enum Storage {
        case view(AnyView, presentationColor: Color?)
        case mesh
    }

    let storage: Storage

    private init(storage: Storage) {
        self.storage = storage
    }

    public static func background(_ color: Color) -> Self {
        Self(storage: .view(AnyView(color), presentationColor: color))
    }

    public static func background<V: View>(_ view: V) -> Self {
        Self(storage: .view(AnyView(view), presentationColor: nil))
    }

    public static func solidColor(_ color: Color) -> Self {
        background(color)
    }

    public static func custom<V: View>(_ view: V) -> Self {
        background(view)
    }

    public static let mesh = Self(storage: .mesh)
}
