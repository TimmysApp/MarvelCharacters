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
            let selectedCharacter = viewModel.selectedCharacter?.get()
            VStack(alignment: .leading, spacing: 20) {
                Text(selectedCharacter?.name ?? "")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(selectedCharacter?.description ?? "")
                    .fontWeight(.medium)
                Spacer()
            }.foregroundStyle(glassStyle)
            .padding(.horizontal, 15)
            .background {
                if viewModel.selectedCharacter == .pagination {
                    progressView
                        .frame(width: width)
                }else {
                    RemotePhotoView(url: selectedCharacter?.thumbnailURL)
                        .frame(width: width)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(Color.black.opacity(0.4))
                        .id(selectedCharacter?.thumbnailURL)
                }
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
                ScrollCarouselView(viewModel.characters, selection: $viewModel.selectedCharacter, width: itemWidth, spacing: spacing) { type in
                    switch type {
                        case .info(let character):
                            RemotePhotoView(url: character.thumbnailURL)
                                .frame(width: itemWidth, height: itemWidth * 1.5)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        case .pagination:
                            progressView
                                .frame(width: itemWidth, height: itemWidth * 1.5)
                                .background(Material.ultraThin)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .task {
                                    await viewModel.paginate()
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
        }.overlay(alignment: .topTrailing) {
            Button(action: {
                viewModel.switchStyle(to: .list)
            }) {
                Image(systemName: "list.dash")
                    .fontWeight(.semibold)
                    .foregroundStyle(glassStyle)
                    .frame(height: 40)
            }.padding(.horizontal, 15)
            .padding(.top, 30)
        }
    }
    private var progressView: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.white.opacity(0.9))
    }
}
