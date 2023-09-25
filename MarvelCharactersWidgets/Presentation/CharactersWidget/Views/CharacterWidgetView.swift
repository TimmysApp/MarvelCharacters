//
//  CharacterWidgetView.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import SwiftUI

struct CharacterWidgetView: View {
    @Environment(\.widgetFamily) private var widgetFamily
    let entry: CharacterEntity
    var body: some View {
        Group {
            if entry.empty {
                Text("No saved characters found!")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.text)
                    .fontWeight(.semibold)
            }else {
                Group {
                    switch widgetFamily {
                        case .systemSmall:
                            CharacterWidgetSmallView(entry: entry)
                        case .systemMedium:
                            CharacterWidgetMediumView(entry: entry)
                        default:
                            EmptyView()
                    }
                }.redacted(reason: entry.preview ? .placeholder: [])
            }
        }.padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background.gradient)
    }
}
