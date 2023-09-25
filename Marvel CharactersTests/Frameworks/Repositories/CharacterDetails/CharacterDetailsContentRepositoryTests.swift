//
//  CharacterDetailsContentRepositoryTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CharacterDetailsContentRepositoryTests: XCTestCase {
//MARK: - Functions
    private func assembleRepository(localResult: Result<[CharacterContent], Error>, remoteResult: Result<[CharacterContent], Error>) -> CharacterDetailsContentRepository {
        let localSource = CharacterDetailsLocalSourceStub(expectedResponse: localResult)
        let remoteSource = CharacterDetailsRemoteSourceStub(expectedResponse: remoteResult)
        return CharacterDetailsContentRepository(remoteSource: remoteSource, localSource: localSource)
    }
//MARK: - Tests
    func testLocalSourceReturnsEmptyAndRemoteSourceFailedRepositoryThrowsError() async {
        let expectedError = ErrorStub.unknownError
        let repository = assembleRepository(localResult: .success([]), remoteResult: .failure(expectedError))
        do {
            _ = try await repository.fetchContent(for: 10, type: .comics)
            XCTFail("Repository needs to throw an error")
        }catch {
            let errorStub = error as? ErrorStub
            XCTAssertTrue(errorStub == expectedError)
        }
    }
    func testLocalSourceReturnsDataAndRemoteSourceFailedRepositoryReturnsLocalData() async {
        let type = CharacterContent.ContentType.comics
        let characterID = 10
        let expectedError = ErrorStub.unknownError
        let expectedData = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
        let repository = assembleRepository(localResult: .success(expectedData), remoteResult: .failure(expectedError))
        do {
            let result = try await repository.fetchContent(for: characterID, type: type)
            XCTAssertEqual(result, expectedData)
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
    func testLocalSourceReturnsEmptyAndRemoteSourceSucceedsRepositoryReturnsRemoteData() async {
        let type = CharacterContent.ContentType.comics
        let characterID = 10
        let expectedData = CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID)
        let repository = assembleRepository(localResult: .success([]), remoteResult: .success(expectedData))
        do {
            let result = try await repository.fetchContent(for: characterID, type: type)
            XCTAssertEqual(result, expectedData)
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
}
