//
//  CharacterDetailsDataBaseTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CharacterDetailsDataBaseTests: XCTestCase {
//MARK: - Properies
    private let characterID = 10
    private var source: CharacterDetailsDatabase!
//MARK: - Lifecycle
    override func setUp() async throws {
        try await super.setUp()
        source = CharacterDetailsDatabase(objectContext: PersistenceControllerStub().container.newBackgroundContext())
    }
    override func tearDown() async throws {
        try await super.tearDown()
        source = nil
    }
//MARK: - Tests
    func testUpdateFunctionSavesData() async {
        do {
            for type in CharacterContent.ContentType.allCases {
                let data = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
                try await source.update(using: data, for: characterID, type: type)
                let fetchedData = try await source.fetch(for: characterID, type: type)
                XCTAssertEqual(fetchedData, data)
            }
        }catch {
            XCTFail("No errors should be thrown")
        }
    }
    func testUpdateFunctionDeletesOldDataAndSavesNewData() async {
        do {
            for type in CharacterContent.ContentType.allCases {
                let oldData = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
                let newData = CharacterContentEntityMockFactory.assembleCharacters(offset: 20, limit: 25, type: type, characterID: characterID)
                try await source.update(using: oldData, for: characterID, type: type)
                try await source.update(using: newData, for: characterID, type: type)
                let fetchedData = try await source.fetch(for: characterID, type: type)
                XCTAssertEqual(fetchedData, newData)
                XCTAssertNotEqual(fetchedData, oldData)
            }
        }catch {
            XCTFail("No errors should be thrown")
        }
    }
    func testFetchFunctionFetchesDataForSepcificCharacterID() async {
        let newCharacterID = 100
        let type = CharacterContent.ContentType.comics
        do {
            let data = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
            let diffrentData = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: newCharacterID)
            try await source.update(using: diffrentData, for: newCharacterID, type: type)
            try await source.update(using: data, for: characterID, type: type)
            let fetchedData = try await source.fetch(for: characterID, type: type)
            let characterIDs = fetchedData.reduce(into: [Int]()) { partialResult, content in
                let id = content.characterID
                guard !partialResult.contains(id) else {return}
                partialResult.append(id)
            }
            XCTAssertEqual(characterIDs, [characterID])
        }catch {
            XCTFail("No errors should be thrown")
        }
    }
    func testFetchFunctionFetchesDataForSepcificType() async {
        do {
            for type in CharacterContent.ContentType.allCases {
                let data = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
                let diffrentData = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
                try await source.update(using: diffrentData, for: characterID, type: type)
                try await source.update(using: data, for: characterID, type: type)
                let fetchedData = try await source.fetch(for: characterID, type: type)
                let contentTypes = fetchedData.reduce(into: [CharacterContent.ContentType]()) { partialResult, content in
                    let contentType = content.type
                    guard !partialResult.contains(contentType) else {return}
                    partialResult.append(contentType)
                }
                XCTAssertEqual(contentTypes, [type])
            }
        }catch {
            XCTFail("No errors should be thrown")
        }
    }
}
