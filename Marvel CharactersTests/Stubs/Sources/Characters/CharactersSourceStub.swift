//
//  CharactersSourceStub.swift
//  Marvel CharactersTests
//
//  Created by Joe Maghzal on 25/09/2023.
//

import Foundation
@testable import Marvel_Characters

class CharactersSourceStub: CharactersSource {
    var expectedResponse: Result<[Character], Error>
    init(expectedResponse: Result<[Character], Error>) {
        self.expectedResponse = expectedResponse
    }
    func fetch(using parameters: CharactersParameters) async throws -> [Character] {
        return try expectedResponse.get()
    }
}
