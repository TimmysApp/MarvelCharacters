//
//  HomeViewModelTests.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import XCTest
@testable import Marvel_Characters

@MainActor final class HomeViewModelTests: XCTestCase {
//MARK: - Functions
    private func viewModel(result: Result<[Character], Error>) -> HomeViewModel {
        let source = CharactersSourceStub(expectedResponse: result)
        let useCase = FetchCharactersUseCase(source: source)
        return HomeViewModel(useCase: useCase)
    }
    private func viewModel(source: CharactersSourceStub) -> HomeViewModel {
        let useCase = FetchCharactersUseCase(source: source)
        return HomeViewModel(useCase: useCase)
    }
//MARK: - Tests
    func testInitialSuccessfullLoadUpdatesCharacters() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        XCTAssertEqual(viewModel.characters.compactMap({$0.get()}), characters)
    }
    func testInitialSuccessfullLoadUpdatesCount() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        let expectedCount = characters.count + 1
        XCTAssertEqual(viewModel.count, expectedCount)
    }
    func testSuccessfullLoadUpdatesStateToLoaded() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        XCTAssertEqual(viewModel.state, .loaded)
    }
    func testEmptyLoadUpdatesStateToEmpty() async {
        let viewModel = viewModel(result: .success([]))
        await viewModel.load()
        XCTAssertEqual(viewModel.state, .empty)
    }
    func testFailedLoadUpdatesStateToError() async {
        let expectedError = ErrorStub.unknownError
        let viewModel = viewModel(result: .failure(expectedError))
        await viewModel.load()
        XCTAssertEqual(viewModel.state, .error(expectedError.localizedDescription))
    }
    func testFailedLoadDoesNotUpdateCount() async {
        let expectedError = ErrorStub.unknownError
        let viewModel = viewModel(result: .failure(expectedError))
        let expectedCount = viewModel.count
        await viewModel.load()
        XCTAssertEqual(viewModel.count, expectedCount)
    }
    func testFailedLoadDoesNotUpdateCharacters() async {
        let expectedError = ErrorStub.unknownError
        let viewModel = viewModel(result: .failure(expectedError))
        let oldCharacters = viewModel.characters
        await viewModel.load()
        XCTAssertEqual(viewModel.characters, oldCharacters)
    }
    func testSuccessfullRefreshResetsCharactersArray() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        await viewModel.paginate()
        await viewModel.refresh()
        XCTAssertEqual(viewModel.characters.compactMap({$0.get()}), characters)
    }
    func testSuccessfullRefreshResetsCount() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        await viewModel.paginate()
        await viewModel.refresh()
        let expectedCount = characters.count + 1
        XCTAssertEqual(viewModel.count, expectedCount)
    }
    func testFailedRefreshDoesNotUpdateArray() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let source = CharactersSourceStub(expectedResponse: .success(characters))
        let viewModel = viewModel(source: source)
        await viewModel.load()
        await viewModel.paginate()
        source.expectedResponse = .failure(ErrorStub.unknownError)
        let expectedArray = viewModel.characters
        await viewModel.refresh()
        XCTAssertEqual(viewModel.characters, expectedArray)
    }
    func testFailedRefreshDoesNoUpdateCount() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let source = CharactersSourceStub(expectedResponse: .success(characters))
        let viewModel = viewModel(source: source)
        await viewModel.load()
        await viewModel.paginate()
        source.expectedResponse = .failure(ErrorStub.unknownError)
        let expectedCount = viewModel.count
        await viewModel.refresh()
        XCTAssertEqual(viewModel.count, expectedCount)
    }
    func testFailedRefreshUpdatesOverlayError() async {
        let expectedError = ErrorStub.unknownError
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let source = CharactersSourceStub(expectedResponse: .success(characters))
        let viewModel = viewModel(source: source)
        await viewModel.load()
        await viewModel.paginate()
        source.expectedResponse = .failure(expectedError)
        await viewModel.refresh()
        XCTAssertEqual(viewModel.overlayError, expectedError.localizedDescription)
    }
    func testSuccessfullPaginateAppendsToCharactersArray() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        await viewModel.paginate()
        let expectedCharactersCount = characters.count + characters.count + 1
        XCTAssertEqual(viewModel.characters.count, expectedCharactersCount)
    }
    func testSuccessfullPaginateMovesPaginationItemToLast() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        let paginationItem = viewModel.characters.last
        await viewModel.paginate()
        XCTAssertEqual(viewModel.characters.last, paginationItem)
    }
    func testSuccessfullPaginateUpdatesCount() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let viewModel = viewModel(result: .success(characters))
        await viewModel.load()
        await viewModel.paginate()
        let expectedCount = characters.count * 2 + 1
        XCTAssertEqual(viewModel.count, expectedCount)
    }
    func testFailedPaginateDoesNoUpdateArray() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let source = CharactersSourceStub(expectedResponse: .success(characters))
        let viewModel = viewModel(source: source)
        await viewModel.load()
        let expectedArray = viewModel.characters
        source.expectedResponse = .failure(ErrorStub.unknownError)
        await viewModel.paginate()
        XCTAssertEqual(viewModel.characters, expectedArray)
    }
    func testFailedPaginateDoesNotUpdateCount() async {
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let source = CharactersSourceStub(expectedResponse: .success(characters))
        let viewModel = viewModel(source: source)
        await viewModel.load()
        let expectedCount = viewModel.count
        source.expectedResponse = .failure(ErrorStub.unknownError)
        await viewModel.paginate()
        XCTAssertEqual(viewModel.count, expectedCount)
    }
    func testFailedPaginateUpdatesOverlayError() async {
        let expectedError = ErrorStub.unknownError
        let characters = CharacterEntityMockFactory.assembleCharacters(offset: 0, limit: 15)
        let source = CharactersSourceStub(expectedResponse: .success(characters))
        let viewModel = viewModel(source: source)
        await viewModel.load()
        source.expectedResponse = .failure(expectedError)
        await viewModel.paginate()
        XCTAssertEqual(viewModel.overlayError, expectedError.localizedDescription)
    }
    func testIsPaginationCellReturnsTrueIfIndexIsLast() async {
        let viewModel = viewModel(result: .success([]))
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertTrue(viewModel.isPaginationCell(indexPath))
    }
    func testIsPaginationCellReturnsFalseIfIndexIsNotLast() async {
        let viewModel = viewModel(result: .success([]))
        let indexPath = IndexPath(row: 10, section: 0)
        XCTAssertFalse(viewModel.isPaginationCell(indexPath))
    }
}
