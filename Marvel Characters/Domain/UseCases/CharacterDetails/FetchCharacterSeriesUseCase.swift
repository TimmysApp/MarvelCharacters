//
//  FetchCharacterSeriesUseCase.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct FetchCharacterSeriesUseCase {
    let source: CharacterDetailsSource
    func fetch(for characterID: Int) async throws -> [CharacterContent] {
        return try await source.fetchSeries(for: characterID)
    }
}
