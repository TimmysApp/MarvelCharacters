//
//  HomeView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            Group {
                switch viewModel.displayStyle {
                    case .carousel:
                        DicoverView(viewModel: viewModel)
                    case .list:
                        CharactersListViewWrapper(viewModel: viewModel)
                            .edgesIgnoringSafeArea(.all)
                }
            }.transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: Character.self) { character in
                Text("")
            }
        }.task {
            await viewModel.load()
        }.animation(.easeIn, value: viewModel.displayStyle)
    }
}
