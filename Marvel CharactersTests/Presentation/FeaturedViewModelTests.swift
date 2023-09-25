//
//  FeaturedViewModelTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import XCTest
@testable import Marvel_Characters

@MainActor final class FeaturedViewModelTests: XCTestCase {
//MARK: - Properties
    private let characterID = 10
//MARK: - Functions
    private func viewModel(characterID: Int, result: Result<[FeaturedContent], Error>) -> FeaturedViewModel {
        let source = CharacterDetailsSourceStub(expectedResponse: result)
        let useCase = CharacterDetailsUseCase(source: source)
        return FeaturedViewModel(characterID: characterID, useCase: useCase)
    }
//MARK: - Tests
    func testUseCaseReturnsDataStateBecomesLoaded() async {
        let result = FeaturedContentEntityMockFactory.assembleContent(characterID: characterID)
        let viewModel = viewModel(characterID: characterID, result: .success(result))
        await viewModel.load()
        XCTAssertEqual(viewModel.state, .loaded)
    }
    func testUseCaseReturnsEmptyDataStateBecomesEmpty() async {
        let viewModel = viewModel(characterID: characterID, result: .success([]))
        await viewModel.load()
        XCTAssertEqual(viewModel.state, .empty)
    }
    func testUseCaseFailsStateBecomesError() async {
        let expectedError = ErrorStub.unknownError
        let viewModel = viewModel(characterID: characterID, result: .failure(expectedError))
        await viewModel.load()
        XCTAssertEqual(viewModel.state, .error(expectedError.localizedDescription))
    }
}
