//
//  CharactersLocalSourceStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 23/09/2023.
//

import Foundation
@testable import Marvel_Characters

struct CharactersLocalSourceStub: CharactersLocalSource {
    let expectedResponse: Result<[Character], Error>
    func fetch() async throws -> [Character] {
        return try expectedResponse.get()
    }
    func update(using data: [Character]) async throws {
    }
}
