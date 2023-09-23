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
        return Character(id: id, name: "Test Character", description: "This is a test Character", modifiedDate: Date(), thumbnailPath: "", comics: assembleCollection(story: false), series: assembleCollection(story: false), stories: assembleCollection(story: true), events: assembleCollection(story: false), additionalLinks: [])
    }
    static func assembleCharacters(offset: Int, limit: Int) -> [Character] {
        let maxRange = offset + limit
        return (offset..<maxRange).map({assembleCharacter(id: $0)})
    }
    static func assembleCollection(story: Bool) -> [Character.Content] {
        let items = [
            Character.Content(resourceURI: "", name: "Test Character Content", type: story ? "testType": nil),
            Character.Content(resourceURI: "", name: "Test Character Content", type: story ? "testType": nil),
            Character.Content(resourceURI: "", name: "Test Character Content", type: story ? "testType": nil)
        ]
        return items
    }
}
