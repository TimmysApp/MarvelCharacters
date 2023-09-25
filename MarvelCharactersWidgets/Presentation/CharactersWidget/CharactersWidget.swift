//
//  CharactersWidget.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import SwiftUI
import WidgetKit

struct CharactersWidgets: Widget {
    private let kind: String = "CharactersWidgets"
    private let provider = CharactresWidgetTimelineProviderFactory.assemble()
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: provider) { entry in
            CharacterWidgetView(entry: entry)
        }.configurationDisplayName("Characters Widget")
        .description("Display Marvel Characters on your home screen!")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}
