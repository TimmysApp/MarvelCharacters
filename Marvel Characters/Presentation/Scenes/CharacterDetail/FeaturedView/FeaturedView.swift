//
//  FeaturedView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

struct FeaturedView: View {
    @StateObject var viewModel: FeaturedViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Featured In")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ForEach(viewModel.featuredData) { item in
                    FeaturedTypeView(content: item)
                }
            }.padding(.top, 20)
            .padding(.horizontal, 15)
        }.task {
            await viewModel.load()
        }.overlay {
            EmptyView()
                .content(state: viewModel.state, style: Color.secondaryText)
        }.background(Color.background)
    }
}
