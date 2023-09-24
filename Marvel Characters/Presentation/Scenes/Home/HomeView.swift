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
        ZStack {
            switch viewModel.displayStyle {
                case .carousel:
                    DicoverView(viewModel: viewModel)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                case .list:
                    CharactersListViewWrapper(viewModel: viewModel)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .task {
            await viewModel.load()
        }.animation(.spring(), value: viewModel.displayStyle)
    }
}
