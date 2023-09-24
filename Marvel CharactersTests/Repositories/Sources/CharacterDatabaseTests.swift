//
//  CharacterDatabaseTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 23/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CharacterDatabaseTests: XCTestCase {
//MARK: - Properies
    private var source: CharactersDatabase!
//MARK: - Lifecycle
    override func setUp() async throws {
        try await super.setUp()
        source = CharactersDatabase(objectContext: PersistenceControllerStub().container.newBackgroundContext())
    }
    override func tearDown() async throws {
        try await super.tearDown()
        source = nil
    }
//MARK: - Tests
    func testUpdateFunctionSavesData() async {
        do {
            let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 5)
            try await source.update(using: characters)
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            let fetchedData = try await source.fetch()
            XCTAssertEqual(fetchedData, characters)
        }catch {
            XCTFail("No errors should be thrown")
        }
    }
    func testUpdateFunctionDeletesOldDataAndSavesNewData() async {
        let oldCharacters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 5)
        let newCharacters = CharacterEntityMockFactory.assembleCharacters(offset: 10, limit: 5)
        do {
            try await source.update(using: oldCharacters)
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            try await source.update(using:  newCharacters)
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            let fetchedData = try await source.fetch()
            XCTAssertEqual(fetchedData, newCharacters)
        }catch {
            XCTFail("No errors should be thrown")
        }
    }
}
