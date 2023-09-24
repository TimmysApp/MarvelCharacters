//
//  CharacterDetailsRepository.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation

struct CharacterDetailsRepository {
//MARK: - Properties
    let remoteSource: CharacterDetailsRemoteSource
    let localSource: CharacterDetailsLocalSource
//MARK: - Functions
    private func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        let localContent = (try? await localSource.fetch(for: characterID, type: type)) ?? []
        guard localContent.isEmpty else {
            Task.detached(priority: .background) {
                _ = try? await remoteSource.fetch(for: characterID, type: type)
            }
            return localContent
        }
        return try await remoteSource.fetch(for: characterID, type: type)
    }
}

//MARK: - CharactersSource
extension CharacterDetailsRepository: CharacterDetailsSource {
    func fetchComics(for characterID: Int) async throws -> [CharacterContent] {
        return try await fetch(for: characterID, type: .comics)
    }
    func fetchSeries(for characterID: Int) async throws -> [CharacterContent] {
        return try await fetch(for: characterID, type: .series)
    }
    func fetchEvents(for characterID: Int) async throws -> [CharacterContent] {
        return try await fetch(for: characterID, type: .events)
    }
    func fetchStories(for characterID: Int) async throws -> [CharacterContent] {
        return try await fetch(for: characterID, type: .stories)
    }
}
