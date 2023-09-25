//
//  CharacterImageView.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import SwiftUI

struct CharacterImageView: View {
    let photoData: Data?
    let width: CGFloat
    var body: some View {
        Group {
            if let photoData = photoData, let image = UIImage(data: photoData) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }else {
                Color.gray
            }
        }.frame(width: width, height: width)
        .clipShape(Circle())
        .overlay {
            Circle()
                .stroke(Color.background, lineWidth: 5)
        }.shadow(radius: 10, y: 1)
    }
}
