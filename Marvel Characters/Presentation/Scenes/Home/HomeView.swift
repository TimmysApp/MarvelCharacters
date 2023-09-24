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
            CharactersListViewWrapper(viewModel: viewModel)
                .edgesIgnoringSafeArea(.all)
                .opacity(viewModel.displayStyle == .list ? 1: 0)
            DicoverView(viewModel: viewModel)
                .opacity(viewModel.displayStyle == .carousel ? 1: 0)
        }.task {
            await viewModel.load()
        }
    }
}
