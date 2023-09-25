//
//  CharacterEntity.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
import WidgetKit

struct CharacterEntity: TimelineEntry {
    let date: Date
    let character: Character
    let photoData: Data?
    let preview: Bool
    let empty: Bool
}

extension Character {
    static let preview = Character(name: "Test", description: "Test description")
}
