//
//  ContentStateViewModifier.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 25/09/2023.
//

import SwiftUI

struct ContentStateViewModifier<T: ShapeStyle>: ViewModifier {
    let state: ContentViewState
    let style: T
    func body(content: Content) -> some View {
        switch state {
            case .empty:
                Text("No Content Available!")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(style)
            case .error(let error):
                Text(error)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(style)
            case .loading:
                ProgressView()
                    .controlSize(.large)
                    .tint(Color.white)
            case .loaded:
                content
        }
    }
}

extension View {
    func content<T: ShapeStyle>(state: ContentViewState, style: T) -> some View {
        modifier(ContentStateViewModifier(state: state, style: style))
    }
}
