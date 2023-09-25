//
//  FeaturedViewModel.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

@MainActor class FeaturedViewModel: ObservableObject {
//MARK: - Properties
    @Published var state = ContentViewState.loading
    @Published var featuredData = [FeaturedContent]()
    private let characterID: Int
    private let useCase: CharacterDetailsUseCase
//MARK: - Initializers
    init(characterID: Int, useCase: CharacterDetailsUseCase) {
        self.characterID = characterID
        self.useCase = useCase
    }
//MARK: - Functions
    func load() async {
        do {
            let data = try await useCase.fetch(for: characterID)
            featuredData = data
            state = featuredData.isEmpty ? .empty: .loaded
        }catch {
            state = .error(error.localizedDescription)
        }
    }
}
