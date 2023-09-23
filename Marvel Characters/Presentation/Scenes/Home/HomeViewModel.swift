//
//  HomeViewModel.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

@MainActor class HomeViewModel: ObservableObject {
//MARK: - Publishers
    @Published var state = TableViewState.loading
    @Published var characters = [Character]()
//MARK: - Closures
    var reloadTableView: (() -> Void)?
//MARK: - Properties
    private let limit = 15
    private let useCase: FetchCharactersUseCase
    private(set) var count = 0
//MARK: - Initializer
    init(useCase: FetchCharactersUseCase) {
        self.useCase = useCase
    }
//MARK: - Functions
    private func loadCharacters() async {
        let prameters = CharactersParameters(limit: limit, offset: count)
        do {
            let result = try await useCase.fetch(using: prameters)
            update(with: result)
        }catch {
            print(error)
            state = .error(error.localizedDescription)
        }
    }
    private func update(with data: [Character]) {
        if count == 0 {
            state = .loaded
        }
        let newDataCount = data.count
        count += newDataCount
        characters.append(contentsOf: data)
        reloadTableView?()
    }
//MARK: - View Functions
    func load() {
        state = .loading
        Task {
            await loadCharacters()
        }
    }
    func setUp(cell: CharacterTableViewCell, at indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let viewModel = CharacterTableCellViewModel(title: character.name, description: character.description)
        cell.setUp(with: viewModel)
    }
    func didSelect(at indexPath: IndexPath) {
        
    }
}

enum TableViewState {
    case empty, error(String), loading, loaded
}
