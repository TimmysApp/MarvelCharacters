//
//  CharacterDetailsRemoteSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 24/09/2023.
//

import Foundation
import NetworkUI

protocol CharacterDetailsRemoteSource {
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent]
}

struct CharacterDetailsService {
    var network: NetworkRequestable
}

//MARK: - CharacterDetailsRemoteSource
extension CharacterDetailsService: CharacterDetailsRemoteSource {
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        let contentsDTO = try await network.request(for: CharactersRoute.details(characterID: characterID, type: type))
            .tryDecode(using: ResponseContainer<PaginatedResponse<ContentDTO>>.self)
            .get()
        return CharacterContent.Mapper.map(contentsDTO.data.results, characterID: characterID, type: type)
    }
}

struct CharacterDetailsRemoteSourceGateway: CharacterDetailsRemoteSource {
    let remoteSource: CharacterDetailsService
    let localSource: CharacterDetailsLocalSource
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        let result = try await remoteSource.fetch(for: characterID, type: type)
        let limittedResult = Array(result.prefix(3))
        try await localSource.update(using: limittedResult, for: characterID, type: type)
        return limittedResult
    }
}
