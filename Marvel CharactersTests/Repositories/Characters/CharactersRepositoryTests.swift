//
//  CharactersRepositoryTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 23/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CharactersRepositoryTests: XCTestCase {
//MARK: - Functions
    private func assembleRepository(localResult: Result<[Character], Error>, remoteResult: Result<[Character], Error>) -> CharactersRepository {
        let localSource = CharactersLocalSourceStub(expectedResponse: localResult)
        let remoteSource = CharactersRemoteSourceStub(expectedResponse: remoteResult)
        return CharactersRepository(remoteSource: remoteSource, localSource: localSource)
    }
//MARK: - Tests
    func testLocalSourceReturnsEmptyAndRemoteSourceFailedRepositoryThrowsError() async {
        let expectedError = ErrorStub.unknownError
        let repository = assembleRepository(localResult: .success([]), remoteResult: .failure(expectedError))
        do {
            _ = try await repository.fetch(using: CharactersParameters())
            XCTFail("Repository needs to throw an error")
        }catch {
            let errorStub = error as? ErrorStub
            XCTAssertTrue(errorStub == expectedError)
        }
    }
    func testLocalSourceReturnsDataAndRemoteSourceFailedRepositoryReturnsLocalData() async {
        let expectedError = ErrorStub.unknownError
        let expectedData = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 5)
        let repository = assembleRepository(localResult: .success(expectedData), remoteResult: .failure(expectedError))
        do {
            let result = try await repository.fetch(using: CharactersParameters())
            XCTAssertEqual(result, expectedData)
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
    func testLocalSourceReturnsEmptyAndRemoteSourceSucceedsRepositoryReturnsRemoteData() async {
        let expectedData = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 5)
        let repository = assembleRepository(localResult: .success([]), remoteResult: .success(expectedData))
        do {
            let result = try await repository.fetch(using: CharactersParameters())
            XCTAssertEqual(result, expectedData)
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
    func testLocalSourceReturnsDataAndRemoteSourceSucceedsRepositoryReturnsLocalData() async {
        let expectedLocalData = CharacterEntityMockFactory.assembleCharacters(offset: 2, limit: 5)
        let expectedRemoteData = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 5)
        let repository = assembleRepository(localResult: .success(expectedLocalData), remoteResult: .success(expectedRemoteData))
        do {
            let result = try await repository.fetch(using: CharactersParameters())
            XCTAssertEqual(result, expectedLocalData)
            XCTAssertNotEqual(result, expectedRemoteData)
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
}
