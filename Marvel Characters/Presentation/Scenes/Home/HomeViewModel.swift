//
//  HomeViewModel.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

@MainActor class HomeViewModel: ObservableObject {
//MARK: - Publishers
    @Published var navigationPath = [Character]()
    @Published var displayedCharacterStyle: CharacterDisplayStyle?
    @Published var displayStyle = HomeDisplayStyle.list
    @Published var state = ContentViewState.loading
    @Published var characters = [CharacterDisplayStyle.pagination]
    @Published var overlayError: String?
//MARK: - Closures
    var reloadTableView: (() -> Void)?
//MARK: - Properties
    private let limit = 15
    private let useCase: FetchCharactersUseCase
    private(set) var count = 1
    var displayedCharacter: Character? {
        return displayedCharacterStyle?.get()
    }
//MARK: - Initializer
    init(useCase: FetchCharactersUseCase) {
        self.useCase = useCase
    }
//MARK: - Functions
    private func loadCharacters(offset: Int, paginating: Bool) async {
        let prameters = CharactersParameters(limit: limit, offset: offset)
        do {
            let result = try await useCase.fetch(using: prameters)
            update(with: result, paginating: paginating)
        }catch {
            let message = error.localizedDescription
            if count > 1 {
                await updateOverlay(error: message)
            }else {
                state = .error(message)
            }
        }
    }
    private func update(with data: [Character], paginating: Bool) {
        let newDataCount = data.count
        guard newDataCount > 0 else {
            state = .empty
            return
        }
        if paginating {
            _ = characters.popLast()
            characters.append(contentsOf: data.map({CharacterDisplayStyle.info($0)}))
        }else {
            state = .loaded
            characters = data.map({CharacterDisplayStyle.info($0)})
            count = 1
        }
        count += newDataCount
        addPaginationState()
        reloadTableView?()
    }
    private func addPaginationState() {
        guard characters.last != .pagination else {return}
        displayedCharacterStyle = characters.last
        characters.append(.pagination)
    }
    private func updateOverlay(error: String?) async {
        overlayError = error
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        overlayError = nil
    }
//MARK: - View Functions
    func load() async {
        await loadCharacters(offset: 0, paginating: false)
        displayedCharacterStyle = characters.first
    }
    func refresh() async {
        await loadCharacters(offset: 0, paginating: false)
    }
    func paginate() async {
        await loadCharacters(offset: count, paginating: true)
    }
    func setUp(cell: CharacterTableViewCell, at indexPath: IndexPath) {
        guard let character = characters[indexPath.row].get() else {return}
        let viewModel = CharacterTableCellViewModel(imageURL: character.thumbnailURL, title: character.name, description: character.description)
        cell.setUp(with: viewModel)
    }
    func didSelect(at indexPath: IndexPath) {
        guard let character = characters[indexPath.row].get() else {return}
        navigationPath.append(character)
    }
    func navigateToDisplayedCharacter() {
        guard let displayedCharacter else {return}
        navigationPath.append(displayedCharacter)
    }
    func isPaginationCell(_ indexPath: IndexPath) -> Bool {
        return indexPath.row == count - 1
    }
    func willDisplayCell(at indexPath: IndexPath) {
        guard state.loaded, isPaginationCell(indexPath) else {return}
        Task {
            await paginate()
        }
    }
    func switchStyle(to style: HomeDisplayStyle) {
        displayStyle = style
        displayedCharacterStyle = characters.first
    }
}
