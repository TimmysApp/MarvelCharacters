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
    @Published var state = TableViewState.loading
    @Published var characters = [CharacterDisplayStyle]()
//MARK: - Closures
    var reloadTableView: (() -> Void)?
//MARK: - Properties
    private let loader: PhotoLoader
    private let limit = 15
    private let useCase: FetchCharactersUseCase
    private(set) var count = 1
    var displayedCharacter: Character? {
        return displayedCharacterStyle?.get()
    }
//MARK: - Initializer
    init(useCase: FetchCharactersUseCase, loader: PhotoLoader) {
        self.useCase = useCase
        self.loader = loader
    }
//MARK: - Functions
    private func loadCharacters() async {
        let offset = count - 1
        let prameters = CharactersParameters(limit: limit, offset: offset)
        do {
            let result = try await useCase.fetch(using: prameters)
            update(with: result)
        }catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
    private func update(with data: [Character]) {
        if count == 1 {
            state = .loaded
        }
        let newDataCount = data.count
        count += newDataCount
        _ = characters.popLast()
        characters.append(contentsOf: data.map({CharacterDisplayStyle.info($0)}))
        addPaginationState()
        reloadTableView?()
    }
    private func addPaginationState() {
        guard characters.last != .pagination else {return}
        displayedCharacterStyle = characters.last
        characters.append(.pagination)
    }
//MARK: - View Functions
    func load() async {
        state = .loading
        await loadCharacters()
        addPaginationState()
        displayedCharacterStyle = characters.first
    }
    func paginate() async {
        await loadCharacters()
    }
    func setUp(cell: CharacterTableViewCell, at indexPath: IndexPath) {
        guard let character = characters[indexPath.row].get() else {return}
        let viewModel = CharacterTableCellViewModel(imageURL: character.thumbnailURL, title: character.name, description: character.description, loader: loader)
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
