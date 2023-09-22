//
//  CountedCollectionTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 22/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CountedCollectionTests: XCTestCase {
    func testEmptyCollectionReturnsIsEmptyTrue() throws {
        let emptyCollection = CountedCollectionEntityMockFactory.assembleEmptyCollection()
        let isEmpty = emptyCollection.isEmpty
        XCTAssertTrue(isEmpty)
    }
    func testCollectionWithItemsReturnsIsEmptyFalse() throws {
        let collection = CountedCollectionEntityMockFactory.assembleCollectionWithItems()
        let isEmpty = collection.isEmpty
        XCTAssertTrue(!isEmpty)
    }
}
