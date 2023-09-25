//
//  CharacterDetailsSourceStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation

import Foundation
@testable import Marvel_Characters

struct CharacterDetailsSourceStub: CharacterDetailsSource {
    let expectedResponse: Result<[FeaturedContent], Error>
    func fetchContent(for characterID: Int) async throws -> [FeaturedContent] {
        return try expectedResponse.get()
    }
}
