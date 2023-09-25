//
//  CharacterDetailsContentSourceStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CharacterDetailsContentSourceStub: CharacterDetailsContentSource {
    let expectedResponse: ((CharacterContent.ContentType) -> Result<[CharacterContent], Error>)
    func fetchContent(for characterID: Int, type: CharacterContent.ContentType) async throws -> [CharacterContent] {
        let builder = expectedResponse(type)
        return try builder.get()
    }
}
