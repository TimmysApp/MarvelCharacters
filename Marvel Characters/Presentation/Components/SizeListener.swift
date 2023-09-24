//
//  SizeListener.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

struct ScreenSizeKey: EnvironmentKey {
    static let defaultValue = CGSize.zero
}

extension EnvironmentValues {
    var screenSize: CGSize {
        get {
            self[ScreenSizeKey.self]
        }
        set {
            self[ScreenSizeKey.self] = newValue
        }
    }
}

extension View {
    func sizeListener() -> some View {
        GeometryReader { geometryProxy in
            self
                .environment(\.screenSize, geometryProxy.size)
        }
    }
}
