//
//  CharacterContentEntityMockFactory.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CharacterContentEntityMockFactory {
    static func assembleContent(id: Int = .random(in: 0..<10000), type: CharacterContent.ContentType, characterID: Int) -> CharacterContent {
        return CharacterContent(characterID: characterID, id: id, title: "Test", description: "Test Content", thumbnailPath: nil, type: type)
    }
    static func assembleCharacters(offset: Int, limit: Int, type: CharacterContent.ContentType, characterID: Int) -> [CharacterContent] {
        let maxRange = offset + limit
        return (offset..<maxRange).map({assembleContent(id: $0, type: type, characterID: characterID)})
    }
}
