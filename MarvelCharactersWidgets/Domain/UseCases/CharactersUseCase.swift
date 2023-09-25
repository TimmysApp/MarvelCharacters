//
//  FetchCharactersUseCase.swift
//  MarvelCharactersWidgetsExtension
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation

struct FetchCharactersUseCase {
    let source: CharactersSource
    func fetch() async throws -> [Character] {
        return try await source.fetch()
    }
}
