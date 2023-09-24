//
//  CharacterDetailsUseCase.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct CharacterDetailsUseCase {
    let source: CharacterDetailsSource
    func fetch(for characterID: Int) async throws -> [FeaturedContent] {
        return try await source.fetchContent(for: characterID)
    }
}
