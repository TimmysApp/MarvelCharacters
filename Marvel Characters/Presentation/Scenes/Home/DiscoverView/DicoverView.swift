//
//  DicoverView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import SwiftUI

struct DicoverView: View {
    @Environment(\.screenSize) private var screenSize
    @ObservedObject var viewModel: HomeViewModel
    private let spacing: CGFloat = 15
    private var itemWidth: CGFloat {
        return (screenSize.width - (3 * spacing)) / 2.5
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(viewModel.displayedCharacter?.name ?? "")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    Spacer()
                    Button(action: {
                        viewModel.switchStyle(to: .list)
                    }) {
                        Image(systemName: "list.dash")
                            .fontWeight(.semibold)
                            .frame(height: 40)
                    }
                }
                Text(viewModel.displayedCharacter?.description ?? "")
                    .fontWeight(.medium)
                Spacer()
            }.foregroundStyle(Material.ultraThickMaterial.blendMode(.luminosity).opacity(0.8).shadow(.drop(radius: 10)))
            .background {
                if viewModel.displayedCharacterStyle == .pagination {
                    progressView
                        .frame(width: screenSize.width)
                }else {
                    RemotePhotoView(url: viewModel.displayedCharacter?.thumbnailURL)
                        .frame(width: screenSize.width)
                        .overlay(Color.black.opacity(0.4))
                        .id(viewModel.displayedCharacter?.thumbnailURL)
                        .edgesIgnoringSafeArea(.top)
                        .overlay(alignment: .bottom) {
                            LinearGradient(colors: [.clear, .black.opacity(0.6), .black.opacity(0.8)], startPoint: .top, endPoint: .bottom)
                                .frame(height: 50)
                        }
                }
            }.padding(.horizontal, 15)
            Text("Marvel Characters")
                .foregroundColor(.white)
                .padding(.horizontal, spacing)
                .font(.title3)
                .fontWeight(.semibold)
            HStack {
                ScrollCarouselView(viewModel.characters, selection: $viewModel.displayedCharacterStyle, width: itemWidth, spacing: spacing) { type in
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
    }
    private var progressView: some View {
        ProgressView()
            .controlSize(.large)
            .tint(.white.opacity(0.9))
    }
}
