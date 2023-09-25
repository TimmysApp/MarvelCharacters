//
//  CharacterDetailsRepositoryTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import XCTest
@testable import Marvel_Characters

final class CharacterDetailsRepositoryTests: XCTestCase {
//MARK: - Functions
    private func assembleRepository(result: @escaping (CharacterContent.ContentType) -> Result<[CharacterContent], Error>) -> CharacterDetailsRepository {
        let source = CharacterDetailsContentSourceStub(expectedResponse: result)
        let useCase = CharacterDetailsContentUseCase(source: source)
        return CharacterDetailsRepository(useCase: useCase)
    }
//MARK: - Tests
    func testRepositoryReturnsAllTypesContentsWhenAllSourcesSucceed() async {
        let characterID = 10
        do {
            let expectedData = { type -> Result<[CharacterContent], Error> in
                    .success(CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID))
            }
            let repository = assembleRepository(result: expectedData)
            let data = try await repository.fetchContent(for: characterID)
            XCTAssertEqual(data.count, CharacterContent.ContentType.allCases.count)
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
    func testRepositoryReturnsAllNonEmptyTypesContentsWhenAllSourcesSucceed() async {
        let characterID = 10
        do {
            var emptyTypes = [CharacterContent.ContentType]()
            for newType in CharacterContent.ContentType.allCases {
                emptyTypes.append(newType)
                let expectedData = { type -> Result<[CharacterContent], Error> in
                    if emptyTypes.contains(type) {
                        return .success([])
                    }
                    return .success(CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID))
                }
                let repository = assembleRepository(result: expectedData)
                let data = try await repository.fetchContent(for: characterID)
                XCTAssertEqual(data.count, CharacterContent.ContentType.allCases.count - emptyTypes.count)
            }
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
    func testRepositoryReturnsAllSuccessfulTypesContentsInCaseOfAnyFailure() async {
        let characterID = 10
        do {
            var failingTypes = [CharacterContent.ContentType]()
            for newType in CharacterContent.ContentType.allCases {
                failingTypes.append(newType)
                let expectedData = { type -> Result<[CharacterContent], Error> in
                    if failingTypes.contains(type) {
                        return .failure(ErrorStub.unknownError)
                    }
                    return .success(CharacterContentEntityMockFactory.assembleCharacters(offset: 0, limit: 5, type: type, characterID: characterID))
                }
                let repository = assembleRepository(result: expectedData)
                let data = try await repository.fetchContent(for: characterID)
                XCTAssertEqual(data.count, CharacterContent.ContentType.allCases.count - failingTypes.count)
            }
        }catch {
            XCTFail("Repository needs to return data")
        }
    }
}
