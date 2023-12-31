//
//  CharacterEntityMockFactory.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CharacterEntityMockFactory {
    static func assembleCharacter(id: Int = .random(in: 0..<10000)) -> Character {
        return Character(id: id, name: "Test Character", description: "This is a test Character", thumbnailPath: "")
    }
    static func assembleCharacters(offset: Int, limit: Int) -> [Character] {
        let maxRange = offset + limit
        return (offset..<maxRange).map({assembleCharacter(id: $0)})
    }
}
