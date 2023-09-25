//
//  CharacterDetailsRemoteSourceStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CharacterDetailsRemoteSourceStub: CharacterDetailsRemoteSource {
    let expectedResponse: Result<[CharacterContent], Error>
    func fetch(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        return try expectedResponse.get()
    }
}
