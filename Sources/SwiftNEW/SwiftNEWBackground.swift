//
//  SwiftNEWBackground.swift
//  SwiftNEW
//
//  Created by OpenCode on 4/7/2026.
//

import SwiftUI

public struct SwiftNEWBackground {
    enum Storage {
        case solidColor(Color)
        case view(AnyView)
        case mesh
    }

    let storage: Storage

    private init(storage: Storage) {
        self.storage = storage
    }

    public static func solidColor(_ color: Color) -> Self {
        Self(storage: .solidColor(color))
    }

    public static func custom<V: View>(_ view: V) -> Self {
        Self(storage: .view(AnyView(view)))
    }

    public static let mesh = Self(storage: .mesh)
}
