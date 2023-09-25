//
//  CharacterDetailView.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import SwiftUI

struct CharacterDetailView: View {
    @Environment(\.screenSize) private var screenSize
    @Environment(\.dismiss) private var dismiss
    @State private var sheetHeight = CGFloat.zero
    @State private var featuredSheetPresented = false
    let character: Character
    var body: some View {
        RemotePhotoView(url: character.thumbnailURL, contentMode: .fit)
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            let height = screenSize.height - proxy.size.height + 100
                            sheetHeight = height
                            featuredSheetPresented = true
                        }.onChange(of: proxy.size.height) { newValue in
                            let height = screenSize.height - newValue + 100
                            sheetHeight = height
                            featuredSheetPresented = true
                        }
                }
            }.overlay(Color.black.opacity(0.4))
            .overlay(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Button(action: {
                        featuredSheetPresented = false
                        dismiss.callAsFunction()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    Text(character.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(character.description)
                        .fontWeight(.medium)
                }.foregroundStyle(Material.ultraThickMaterial.blendMode(.luminosity).opacity(0.8).shadow(.drop(radius: 10)))
                    .environment(\.colorScheme, .light)
                .padding(.top, 60)
                .padding(.horizontal, 15)
            }.frame(maxHeight: .infinity, alignment: .top)
            .edgesIgnoringSafeArea(.all)
            .background(Color.black)
            .sheet(isPresented: $featuredSheetPresented) {
                FeaturedViewFactory.assemble(for: character.id ?? 0)
                    .presentationDetents([.height(sheetHeight), .fraction(0.9)])
                    .addActiveBackgroundPresentationConfigs()
                    .presentationDragIndicator(.visible)
            }.toolbar(.hidden, for: .navigationBar)
            .onChange(of: featuredSheetPresented) { newValue in
                guard !newValue else {return}
                dismiss.callAsFunction()
            }
    }
}

extension View {
    @ViewBuilder func addActiveBackgroundPresentationConfigs() -> some View {
        if #available(iOS 16.4, *) {
            self
                .presentationCornerRadius(30)
                .interactiveDismissDisabled()
                .presentationBackgroundInteraction(.enabled)
                .presentationBackground(Color.background)
        }else {
            self
        }
    }
}
