//
//  CharactersRepository.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation

struct CharactersRepository {
    let localSource: CharactersLocalSource
}

//MARK: - CharactersSource
extension CharactersRepository: CharactersSource {
    func fetch() async throws -> [Character] {
        return try await localSource.fetch()
    }
}
