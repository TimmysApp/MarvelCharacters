//
//  CharacterEntityMockFactory.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 22/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CharacterEntityMockFactory {
    static func assembleCharacter() -> Character {
        return Character(id: Int.random(in: 0..<10000), name: "Test Character", description: "This is a test Character", modifiedDate: Date(), thumbnailPath: "", comics: assembleCollection(story: false), series: assembleCollection(story: false), stories: assembleCollection(story: true), events: assembleCollection(story: false), additionalLinks: [])
    }
    static func assembleCollection(story: Bool) -> CountedCollection<Character.Content> {
        let items = [
            Character.Content(resourceURI: "", name: "Test Character Content", type: story ? "testType": nil),
            Character.Content(resourceURI: "", name: "Test Character Content", type: story ? "testType": nil),
            Character.Content(resourceURI: "", name: "Test Character Content", type: story ? "testType": nil)
        ]
        return CountedCollection(count: 3, items: items)
    }
}
