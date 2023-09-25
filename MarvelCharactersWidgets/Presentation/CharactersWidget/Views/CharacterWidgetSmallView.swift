//
//  CharacterWidgetSmallView.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import SwiftUI
import WidgetKit

struct CharacterWidgetSmallView: View {
    let entry: CharacterEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            CharacterImageView(photoData: entry.photoData, width: 60)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(entry.character.name)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(Color.text)
                .shadow(radius: 10, y: 1)
                .frame(maxHeight: .infinity)
        }
    }
}
