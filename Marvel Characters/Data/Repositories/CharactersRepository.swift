//
//  CharactersRepository.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation

struct CharactersRepository {
    let remoteSource: CharactersRemoteSource
    let localSource: CharactersLocalSource
}

//MARK: - CharactersSource
extension CharactersRepository: CharactersSource {
    func fetch(using parameters: CharactersParameters) async throws -> [Character] {
        let localCharacters = try await localSource.fetch(using: parameters)
        guard localCharacters.isEmpty else {
            Task.detached(priority: .background) {
                _ = try? await remoteSource.fetch(using: parameters)
            }
            return localCharacters
        }
        return try await remoteSource.fetch(using: parameters)
    }
}
