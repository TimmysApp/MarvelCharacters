//
//  ViewOffsetPrefrenceKey.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import SwiftUI

struct ViewOffsetPrefrenceKey: PreferenceKey {
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

