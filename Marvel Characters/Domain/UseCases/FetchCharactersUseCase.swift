//
//  FetchCharactersUseCase.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

struct FetchCharactersUseCase {
    let source: CharactersSource
    func fetch(using parameters: CharactersParameters) async throws -> [Character] {
        return try await source.fetch(using: parameters)
    }
}
