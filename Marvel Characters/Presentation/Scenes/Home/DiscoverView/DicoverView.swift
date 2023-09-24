//
//  DicoverView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import SwiftUI

struct Test: Identifiable, Hashable {
    var id: Int
}

struct DicoverView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var width: CGFloat = 10
    private let spacing: CGFloat = 15
    var body: some View {
        let glassStyle = Material.ultraThickMaterial.blendMode(.luminosity).opacity(0.8).shadow(.drop(radius: 10))
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 20) {
                Text(viewModel.selectedCharacter?.name ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.selectedCharacter?.description ?? "")
                    .fontWeight(.medium)
                Spacer()
            }.foregroundStyle(glassStyle)
            .padding(.horizontal, 15)
            .background {
                AsyncImage(url: viewModel.selectedCharacter?.thumbnailURL) { state in
                    switch state {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .failure(let error):
                            Text(error.localizedDescription)
                                .frame(width: width)
                        case .empty:
                            ProgressView()
                                .frame(width: width)
                    }
                }.overlay(Color.black.opacity(0.4))
            }.overlay(alignment: .bottom) {
                LinearGradient(colors: [.clear, .black.opacity(0.6), .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                    .frame(height: 50)
            }
            Text("Marvel Characters")
                .foregroundColor(.white)
                .padding(.horizontal, spacing)
                .font(.title3)
                .fontWeight(.semibold)
            HStack {
                let itemWidth = (width - (3 * spacing)) / 2.5
                ScrollCarouselView(viewModel.characters, selection: $viewModel.selectedCharacter, width: itemWidth, spacing: spacing) { character in
                    AsyncImage(url: character.thumbnailURL) { state in
                        switch state {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: itemWidth, height: itemWidth * 1.5)
                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                            case .failure(let error):
                                Text(error.localizedDescription)
                                    .frame(width: itemWidth, height: itemWidth * 1.5)
                            case .empty:
                                ProgressView()
                                    .frame(width: itemWidth, height: itemWidth * 1.5)
                        }
                    }
                }.frame(height: itemWidth * 1.5)
            }
        }.background(Color.black)
        .edgesIgnoringSafeArea(.top)
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        width = proxy.size.width
                    }
            }
        }
    }
}
