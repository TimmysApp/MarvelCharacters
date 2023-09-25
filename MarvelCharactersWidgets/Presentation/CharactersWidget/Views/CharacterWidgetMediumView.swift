//
//  CharacterWidgetMediumView.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import SwiftUI
import WidgetKit

struct CharacterWidgetMediumView: View {
    let entry: CharacterEntity
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 10) {
                CharacterImageView(photoData: entry.photoData, width: 70)
                Text(entry.character.name)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.text)
                    .shadow(radius: 10, y: 1)
                Spacer()
            }
            Text(entry.character.description)
                .fontWeight(.medium)
                .font(.callout)
                .shadow(radius: 10, y: 1)
                .frame(maxHeight: .infinity)
        }
    }
}
