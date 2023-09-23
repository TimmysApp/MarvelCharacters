//
//  CharactersRemoteSource.swift
//  Marvel Characters
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation
import NetworkUI

protocol CharactersRemoteSource {
    func fetch(using parameters: CharactersParameters) async throws -> [Character]
}

struct CharactersService {
    var network: NetworkRequestable
}

//MARK: - CharactersRemoteSource
extension CharactersService: CharactersRemoteSource {
    func fetch(using parameters: CharactersParameters) async throws -> [Character] {
        let charactersDTO = try await network.request(for: CharactersRoute.characters(parameters: parameters))
            .tryDecode(using: ResponseContainer<PaginatedResponse<CharacterDTO>>.self)
            .get()
        return Character.Mapper.map(charactersDTO.data.results)
    }
}
