//
//  CharacterDetailsContentUseCase.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct CharacterDetailsContentUseCase {
    let source: CharacterDetailsContentSource
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        return try await source.fetchContent(for: characterID, type: type)
    }
}
