//
//  CharacterEntityTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 22/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CharacterEntityTests: XCTestCase {
//MARK: - Properties
    private let mockCharacter = CharacterEntityMockFactory.assembleCharacter()
//MARK: - Helpers
    private func isStory(_ items: [Character.Content]) -> Bool {
        items.reduce(into: false) { partialResult, content in
            partialResult = partialResult || content.isStory
        }
    }
//MARK: - Tests
    func testCharacterContentStoriesReturnsIsStoryTrue() {
        let array = mockCharacter.stories.items
        XCTAssertTrue(isStory(array))
    }
    func testCharacterContentEventsReturnsIsStoryFalse() {
        let array = mockCharacter.events.items
        XCTAssertTrue(!isStory(array))
    }
    func testCharacterContentCommicsReturnsIsStoryFalse() {
        let array = mockCharacter.comics.items
        XCTAssertTrue(!isStory(array))
    }
    func testCharacterContentSeriesReturnsIsStoryFalse() {
        let array = mockCharacter.series.items
        XCTAssertTrue(!isStory(array))
    }
}
